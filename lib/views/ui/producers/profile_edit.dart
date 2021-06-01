import 'package:edge_rythm/business_logic/model/user.dart';
import 'package:edge_rythm/business_logic/services/providers/user.dart';
import 'package:edge_rythm/views/util/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileEdit extends StatefulWidget {
  static const route = '/user_profile_edit';
  const ProfileEdit({Key key}) : super(key: key);

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  GlobalKey<FormState> _form = new GlobalKey();
  var _isLoading = false;

  void save(UserProvider user) async {
    if (!_form.currentState.validate()) return;
    _form.currentState.save();
    setState(() => _isLoading = !_isLoading);
    try {
      await user.updateUser();
      Navigator.of(context).pop();
      // setState(() => _isLoading = !_isLoading);
    } catch (error) {
      throw error;
    }
    setState(() => _isLoading = !_isLoading);
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.black),
      ),
      body: Stack(
        children: [
          Consumer<UserProvider>(
            builder: (context, value, child) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Text(
                      'Edit Profile',
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(color: Colors.black),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: 'profile',
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context).accentColor,
                              width: .5,
                            ),
                          ),
                          child: Image.asset(
                            'assets/images/rhythm.png',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Form(
                    key: _form,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          initialValue: value.userModel.name,
                          validator: (value) {
                            if (value.isEmpty) return 'Name cannot be empty.';
                            return null;
                          },
                          onSaved: (value) =>
                              user.saveData(UserMap.name, value),
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person, color: Colors.black),
                            hintText: 'Full name',
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(242, 241, 243, 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ListTile(
                            leading: Icon(Icons.mail, color: Colors.black),
                            title: Text(
                              value.userModel.email,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          initialValue: value.userModel.phone,
                          validator: (value) {
                            if (value.isEmpty) return 'Phone cannot be empty.';
                            return null;
                          },
                          onSaved: (value) =>
                              user.saveData(UserMap.phone, value),
                          keyboardType: TextInputType.phone,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.call, color: Colors.black),
                            hintText: 'Phone number',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Hero(
                    tag: 'edit_profile',
                    child: GradientRaisedButton(
                      child: Text(
                        'Save changes',
                        style: Theme.of(context).textTheme.button,
                      ),
                      onPressed: () => save(user),
                    ),
                  )
                ],
              ),
            ),
          ),
          if (_isLoading)
            Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
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
            ),
        ],
      ),
    );
  }
}
