import 'package:edge_rythm/views/ui/streaming/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../business_logic/services/providers/nav_provider.dart';
import '../../util/gradient_button.dart';

class ProducersHomeScreen extends StatelessWidget {
  static const route = '/producershomescreen';
  const ProducersHomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Book a Producer\nComing soon',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(height: 15),
            Text(
              'Book a producer is currently ongoing development and coming soon',
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
              onPressed: () =>
                  Provider.of<NavProvider>(context, listen: false).topBar = 1,
            ),
            SizedBox(height: 15),
            MaterialButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(StreamingMusicScree.route),
              child: Text('Stream Music'),
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
