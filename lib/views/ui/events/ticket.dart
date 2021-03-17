import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_ticket_widget/flutter_ticket_widget.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission/permission.dart';

class TicketScreen extends StatelessWidget {
  static const route = '/ticketscreen';
  const TicketScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
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
          for (var i = 0; i < 3; i++) TicketCard(),
        ],
      ),
    );
  }
}

class TicketCard extends StatefulWidget {
  const TicketCard({Key key}) : super(key: key);

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

    final result = await ImageGallerySaver.saveFile(file.path);
    // toast saved
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
                            imageUrl:
                                'https://pbs.twimg.com/media/DrPHOC4XgAAqiH-.jpg',
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
                      'Wizkid Made In Lagos\nShutdown 2018',
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
                              '3:14pm',
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
                                  'Friday saturday 2020',
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
                            'No_15 Jakpa road by the new resort center',
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
                      'ID12345_12',
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
