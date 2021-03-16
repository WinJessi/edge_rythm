import 'package:edge_rythm/business_logic/services/providers/nav_provider.dart';
import 'package:edge_rythm/views/util/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticationScreen extends StatefulWidget {
  static const route = '/authentication';
  callSignUp(BuildContext context) => createState().gotoSignUP(context);
  callLogin(BuildContext context) => createState().gotoLogin();
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  void gotoSignUP(BuildContext context) {
    Provider.of<NavProvider>(context, listen: false).current = 1;
    _controller.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  void gotoLogin() {
    _controller.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void next() {
    Future.delayed(Duration(seconds: 5)).then((value) =>
        _controller.animateToPage(1,
            duration: Duration(milliseconds: 500), curve: Curves.ease));
    prev();
  }

  void prev() {
    Future.delayed(Duration(seconds: 5)).then((value) =>
        _controller.animateToPage(1,
            duration: Duration(milliseconds: 500), curve: Curves.ease));
    next();
  }

  @override
  Widget build(BuildContext context) {
    next();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Consumer<NavProvider>(
        builder: (context, value, child) => Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: Image.asset(
                  value.current == 0
                      ? 'assets/images/login.png'
                      : 'assets/images/sign_up.png',
                  height: MediaQuery.of(context).size.height * .35,
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * .65,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      padding: EdgeInsets.only(right: 15, left: 15),
                      child: PageView(
                        controller: _controller,
                        // physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        onPageChanged: (i) =>
                            Future.delayed(Duration(milliseconds: 350))
                                .then((value) => value.current = i),
                        children: [Login(), Signup()],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 15),
        Text(
          'Login',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline3,
        ),
        SizedBox(height: 15),
        Text(
          'Welcome Superstar, Fill in your details',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        SizedBox(height: 30),
        TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.mail, color: Colors.grey),
            hintText: 'Email address',
          ),
        ),
        SizedBox(height: 15),
        TextField(
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock, color: Colors.grey),
              hintText: 'Password',
              suffixIcon: Icon(Icons.remove_red_eye, color: Colors.grey)),
        ),
        Spacer(),
        GradientRaisedButton(
          child: Text(
            'Login',
            style: Theme.of(context).textTheme.button,
          ),
        ),
        TextButton(
          onPressed: () => AuthenticationScreen().callSignUp(context),
          child: Text(
            'Don’t have an account?',
            style: Theme.of(context)
                .textTheme
                .button
                .copyWith(color: Colors.black),
          ),
        ),
      ],
    );
  }
}

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 15),
        Text(
          'Sign',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline3,
        ),
        SizedBox(height: 15),
        Text(
          'Welcome Superstar, Fill in your details',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        SizedBox(height: 30),
        TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.mail, color: Colors.grey),
            hintText: 'Email address',
          ),
        ),
        SizedBox(height: 15),
        TextField(
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock, color: Colors.grey),
              hintText: 'Password',
              suffixIcon: Icon(Icons.remove_red_eye, color: Colors.grey)),
        ),
        Spacer(),
        GradientRaisedButton(
          child: Text(
            'Sign Up',
            style: Theme.of(context).textTheme.button,
          ),
        ),
        TextButton(
          onPressed: () => AuthenticationScreen().callSignUp(context),
          child: Text(
            'Already have an account?',
            style: Theme.of(context)
                .textTheme
                .button
                .copyWith(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
