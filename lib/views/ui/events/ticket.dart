import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:edge_rythm/business_logic/model/myticket.dart';
import 'package:edge_rythm/business_logic/model/ticket.dart';
import 'package:edge_rythm/business_logic/services/providers/ticket.dart';
import 'package:edge_rythm/views/ui/home.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_ticket_widget/flutter_ticket_widget.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission/permission.dart';
import 'package:provider/provider.dart';

class TicketScreen extends StatelessWidget {
  static const route = '/ticketscreen';
  const TicketScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ticket = Provider.of<TicketProvider>(context);
    var purchase = ModalRoute.of(context).settings.arguments as bool;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context)
                .pushNamedAndRemoveUntil(HomeScreen.route, (route) => false)),
      ),
      body: ListView(
        children: [
          if (purchase)
            Column(
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top * .5),
                Image.asset('assets/images/success.png'),
                SizedBox(height: 15),
                Text(
                  'Payment successful',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Text(
              'Your tickets',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          if (ticket.myTickets.single.howMany != null)
            for (var i = 0; i < int.parse(ticket.myTickets.single.howMany); i++)
              TicketCard(myTicket: ticket.myTickets.single, i: i),
        ],
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
    var ticket = Provider.of<TicketProvider>(context, listen: false)
        .tickets[TMap.ticket] as Ticket;
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
                            imageUrl: ticket.showBanner,
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
                      ticket.showTitle,
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
                              ticket.showTime,
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
                                  ticket.showDate,
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
                            ticket.showAddress,
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
