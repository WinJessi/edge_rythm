import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:edge_rythm/business_logic/model/myticket.dart';
import 'package:edge_rythm/business_logic/services/providers/ticket.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_ticket_widget/flutter_ticket_widget.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission/permission.dart';
import 'package:provider/provider.dart';

class EventsHistory extends StatelessWidget {
  const EventsHistory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<TicketProvider>(context, listen: false)
            .fetchMyTickets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox();
          } else {
            return Consumer<TicketProvider>(
              builder: (context, value, child) => ListView(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      child: Text(
                        'Swipe to delete',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                  for (var i = 0; i < value.myTickets.length; i++)
                    HistoryECard(myTicket: value.myTickets[i])
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class HistoryECard extends StatelessWidget {
  const HistoryECard({
    Key key,
    this.myTicket,
  }) : super(key: key);

  final MyTicket myTicket;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey('${myTicket.bookingID}'),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) async {
        await Provider.of<TicketProvider>(context, listen: false)
            .deleteTicket(myTicket.id);
      },
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red,
        ),
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Delete',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.white),
              ),
              Icon(Icons.delete),
            ],
          ),
        ),
      ),
      child: GestureDetector(
        onTap: () => showTickets(context, myTicket),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              CircleAvatar(
                maxRadius: 30,
                backgroundImage: NetworkImage(myTicket.ticket.showBanner),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      myTicket.ticket.showTitle,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${myTicket.ticket.showDate}',
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 15),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }

  Future showTickets(BuildContext context, MyTicket myTicket) {
    var howMany = int.parse(myTicket.howMany);
    return showDialog(
      context: context,
      builder: (context) => Material(
        child: ListView(
          children: [
            SizedBox(height: 30),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.all(15),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            for (var i = 0; i < howMany; i++)
              TicketCard(
                myTicket: myTicket,
                i: i,
              ),
          ],
        ),
      ),
    );
  }
}

class TicketCard extends StatefulWidget {
  const TicketCard({
    Key key,
    this.myTicket,
    this.i,
  }) : super(key: key);

  final MyTicket myTicket;
  final int i;

  @override
  _TicketCardState createState() => _TicketCardState();
}

class _TicketCardState extends State<TicketCard> {
  GlobalKey globalKey = GlobalKey();

  Future<Uint8List> createPhoto() async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    return pngBytes;
  }

  downloadImage() async {
    await _requestPermission();
    Future.delayed(Duration(milliseconds: 100)).then(
      (_) => createPhoto().then((value) {
        saveToGallery(value);
        showDialog(
            context: context,
            builder: (context) => Stack(
                  children: [
                    Container(color: Colors.black38),
                    Align(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Image.memory(value),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.close, color: Colors.black),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ),
                  ],
                ));
      }),
    );
  }

  saveToGallery(Uint8List data) async {
    File file = await writeToFile(data);
    await ImageGallerySaver.saveFile(file.path);
    AchievementView(
      context,
      title: "Success",
      subTitle: "Ticket saved to your gallery",
      icon: Icon(Icons.calendar_today, color: Colors.white),
      typeAnimationContent: AnimationTypeAchievement.fade,
      borderRadius: 20.0,
      color: Colors.black,
      alignment: Alignment.topCenter,
      duration: Duration(seconds: 3),
    )..show();
  }

  Future<File> writeToFile(Uint8List data) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath = tempPath + '/${DateTime.now()}.png';
    return new File(filePath).writeAsBytes(data);
  }

  Future _requestPermission() async {
    List<PermissionName> permissionNames = [];
    permissionNames.add(PermissionName.Storage);
    var permissions = await Permission.requestPermissions(permissionNames);
    permissions.forEach((element) {
      if (element.permissionStatus == PermissionStatus.allow) {
        print('permitted');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: globalKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: FlutterTicketWidget(
          width: double.infinity,
          height: 520,
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FancyShimmerImage(
                            imageUrl: widget.myTicket.ticket.showBanner,
                            boxFit: BoxFit.cover,
                            width: double.infinity,
                            height: double.maxFinite,
                            shimmerBackColor: Color.fromRGBO(219, 165, 20, 1),
                            shimmerBaseColor: Color.fromRGBO(183, 134, 40, 1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.myTicket.ticket.showTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        SizedBox(width: 30),
                        Row(
                          children: [
                            Icon(Icons.calendar_today, color: Colors.black),
                            SizedBox(width: 5),
                            Text(
                              widget.myTicket.ticket.showTime,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today, color: Colors.black),
                              SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  widget.myTicket.ticket.showDate,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 30),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        SizedBox(width: 30),
                        Icon(Icons.location_pin, color: Colors.black),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            widget.myTicket.ticket.showAddress,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                        SizedBox(width: 30),
                      ],
                    ),
                    SizedBox(height: 25),
                  ],
                ),
              ),
              Divider(color: Colors.black),
              SizedBox(height: 5),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(
                      'Booking ID',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Colors.black),
                    ),
                    Text(
                      '${widget.myTicket.bookingID}_${widget.i}',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    TextButton(
                      onPressed: () => downloadImage(),
                      child: Text(
                        'Download',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(color: Colors.black),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          isCornerRounded: true,
        ),
      ),
    );
  }
}
