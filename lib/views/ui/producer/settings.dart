import 'package:edge_rythm/business_logic/services/providers/user.dart';
import 'package:edge_rythm/views/ui/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProducerSetting extends StatelessWidget {
  const ProducerSetting({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            Provider.of<UserProvider>(context, listen: false).logout();
            Navigator.of(context).pushNamedAndRemoveUntil(
                AuthenticationScreen.route, (route) => false);
          },
          child: Text("Logout"),
        ),
      ),
    );
  }
}
