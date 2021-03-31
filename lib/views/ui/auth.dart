import 'package:edge_rythm/business_logic/model/user.dart';
import 'package:edge_rythm/business_logic/services/providers/nav_provider.dart';
import 'package:edge_rythm/business_logic/services/providers/user.dart';
import 'package:edge_rythm/views/ui/producer/home.dart';
import 'package:edge_rythm/views/ui/what.dart';
import 'package:edge_rythm/views/util/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticationScreen extends StatefulWidget {
  static const route = '/authentication';
  static final GlobalKey<AuthenticationScreenState> globalKey =
      new GlobalKey<AuthenticationScreenState>();
  AuthenticationScreen() : super(key: AuthenticationScreen.globalKey);
  @override
  AuthenticationScreenState createState() => AuthenticationScreenState();
}

class AuthenticationScreenState extends State<AuthenticationScreen> {
  PageController _controller;
  var _isLoading = false;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  void gotoSignUP(BuildContext context) {
    Future.delayed(Duration(milliseconds: 350)).then((value) =>
        Provider.of<NavProvider>(context, listen: false).current = 1);
    _controller.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.linear);
  }

  void gotoLogin(BuildContext context) {
    Future.delayed(Duration(milliseconds: 350)).then((value) =>
        Provider.of<NavProvider>(context, listen: false).current = 0);
    _controller.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.linear);
  }

  showLoader() {
    setState(() {
      _isLoading = true;
    });
  }

  hideLoader() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Consumer<NavProvider>(
            builder: (context, value, child) => Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .3,
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top * 1.5),
                  child: Image.asset(
                    value.current == 0
                        ? 'assets/images/producer.png'
                        : 'assets/images/sign_up.png',
                    fit: BoxFit.cover,
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
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            children: [
                              Login(),
                              Signup(),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          // preloader here
          if (_isLoading)
            Align(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Card(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset(
                      'assets/images/loading.gif',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.maxFinite,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _form = new GlobalKey();
  var _showPwd = false;

  save(BuildContext context) async {
    if (!_form.currentState.validate()) return;
    _form.currentState.save();
    try {
      AuthenticationScreen.globalKey.currentState.showLoader();
      await Provider.of<UserProvider>(context, listen: false)
          .login()
          .then((value) {
        print(value.role);
        if (value.role == 'USER') {
          Navigator.of(context).pushNamedAndRemoveUntil(
              WhatDoYouWantScreen.route, (route) => false);
        } else {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(ProducerHome.route, (route) => false);
        }
      });
      AuthenticationScreen.globalKey.currentState.hideLoader();
    } catch (error) {
      throw error;
    }
    AuthenticationScreen.globalKey.currentState.hideLoader();
  }

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<UserProvider>(context, listen: false);
    return Form(
      key: _form,
      child: Column(
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
          TextFormField(
            validator: (value) {
              if (!value.contains('@'))
                return 'Please use a valid email address';
              if (value.isEmpty) return 'Email address is empty.';
              return null;
            },
            onSaved: (value) => auth.saveData(UserMap.email, value),
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.grey),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.mail, color: Colors.grey),
              hintText: 'Email address',
            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            validator: (value) {
              if (value.length < 8) return 'Min length of 8';
              if (value.isEmpty) return 'Password cannot be empty.';
              return null;
            },
            onSaved: (value) => auth.saveData(UserMap.pwd, value),
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.grey),
            obscureText: !_showPwd,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock, color: Colors.grey),
                hintText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                      !_showPwd
                          ? Icons.remove_red_eye
                          : Icons.panorama_fish_eye,
                      color: Colors.grey),
                  onPressed: () {
                    setState(() {
                      _showPwd = !_showPwd;
                    });
                  },
                )),
          ),
          Spacer(),
          GradientRaisedButton(
            child: Text(
              'Login',
              style: Theme.of(context).textTheme.button,
            ),
            onPressed: () => save(context),
          ),
          SizedBox(height: 8),
          TextButton(
            onPressed: () =>
                AuthenticationScreen.globalKey.currentState.gotoSignUP(context),
            child: Text(
              'Don’t have an account?',
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: Colors.black),
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _form = new GlobalKey();

  save(BuildContext context) async {
    if (!_form.currentState.validate()) return;
    _form.currentState.save();
    try {
      AuthenticationScreen.globalKey.currentState.showLoader();
      await Provider.of<UserProvider>(context, listen: false)
          .register()
          .then((value) {
        if (value.role == 'USER') {
          Navigator.of(context).pushNamedAndRemoveUntil(
              WhatDoYouWantScreen.route, (route) => false);
        } else {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(ProducerHome.route, (route) => false);
        }
      });
      AuthenticationScreen.globalKey.currentState.hideLoader();
    } catch (error) {
      throw error;
    }
    AuthenticationScreen.globalKey.currentState.hideLoader();
  }

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<UserProvider>(context, listen: false);
    return IntrinsicHeight(
      child: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 15),
              Text(
                'Sign Up',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(height: 15),
              Text(
                'Join other users making waves on our platform now. Gotcha',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(height: 30),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) return 'Name cannot be empty';
                  return null;
                },
                keyboardType: TextInputType.text,
                onSaved: (value) => auth.saveData(UserMap.name, value),
                style: TextStyle(color: Colors.grey),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person, color: Colors.grey),
                  hintText: 'Full name',
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                validator: (value) {
                  if (!value.contains('@'))
                    return 'Please use a valid email address';
                  if (value.isEmpty) return 'Email address is empty.';
                  return null;
                },
                onSaved: (value) => auth.saveData(UserMap.email, value),
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.grey),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.mail, color: Colors.grey),
                  hintText: 'Email address',
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) return 'Phone number is empty.';
                  return null;
                },
                onSaved: (value) => auth.saveData(UserMap.phone, value),
                keyboardType: TextInputType.phone,
                style: TextStyle(color: Colors.grey),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.call, color: Colors.grey),
                  hintText: 'Phone number',
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                validator: (value) {
                  if (value.length < 8) return 'Min length of 8';
                  if (value.isEmpty) return 'Password cannot be empty.';
                  return null;
                },
                onSaved: (value) => auth.saveData(UserMap.pwd, value),
                style: TextStyle(color: Colors.grey),
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Colors.grey),
                    hintText: 'Password',
                    suffixIcon: Icon(Icons.remove_red_eye, color: Colors.grey)),
              ),
              SizedBox(height: 60),
              GradientRaisedButton(
                child: Text(
                  'Sign Up',
                  style: Theme.of(context).textTheme.button,
                ),
                onPressed: () => save(context),
              ),
              SizedBox(height: 8),
              TextButton(
                onPressed: () => AuthenticationScreen.globalKey.currentState
                    .gotoLogin(context),
                child: Text(
                  'Already have an account?',
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: Colors.black),
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
