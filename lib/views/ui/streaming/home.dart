import 'package:flutter/material.dart';

import '../../util/gradient_button.dart';

class StreamingMusicScree extends StatelessWidget {
  static const route = '/streamingmusicscreen';
  const StreamingMusicScree({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Music Streaming\nComing soon',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(height: 15),
            Text(
              'Music stream is currently ongoing development and coming soon',
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 140),
            Text(
              'While you are here you could use out other services and enjoy the app.',
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            GradientRaisedButton(
              child: Text(
                'Order Event',
                style: Theme.of(context).textTheme.button,
              ),
            ),
            SizedBox(height: 15),
            MaterialButton(
              onPressed: () {},
              child: Text('Book Producer'),
              color: Colors.blue,
              padding: EdgeInsets.symmetric(vertical: 15),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
