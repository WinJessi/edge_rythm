import 'dart:io';

import 'package:edge_rythm/business_logic/model/producer.dart';
import 'package:edge_rythm/business_logic/services/providers/user.dart';
import 'package:edge_rythm/views/util/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProducerProfileEdit extends StatefulWidget {
  static const route = '/producer_profile_edit';
  const ProducerProfileEdit({Key key}) : super(key: key);

  @override
  _ProducerProfileEditState createState() => _ProducerProfileEditState();
}

class _ProducerProfileEditState extends State<ProducerProfileEdit> {
  var _isLoading = false;
  var _form = new GlobalKey<FormState>();

  void save(UserProvider user) async {
    if (!_form.currentState.validate()) return;
    _form.currentState.save();
    setState(() => _isLoading = !_isLoading);

    try {
      await user.updateProducer(context);
      Navigator.of(context).pop();
      setState(() => _isLoading = !_isLoading);
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
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context).accentColor,
                              width: .5,
                            ),
                          ),
                          child: ProfilePhoto(),
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
                          initialValue: value.producer.name,
                          validator: (value) {
                            if (value.isEmpty) return 'Name cannot be empty.';
                            return null;
                          },
                          onSaved: (value) =>
                              user.setProd(ProducersMap.name, value),
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
                              user.setProd(ProducersMap.phone, value),
                          keyboardType: TextInputType.phone,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.call, color: Colors.black),
                            hintText: 'Phone number',
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          initialValue: value.producer.genre,
                          validator: (value) {
                            if (value.isEmpty) return 'Genre cannot be empty.';
                            return null;
                          },
                          onSaved: (value) =>
                              user.setProd(ProducersMap.genre, value),
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.music_note,
                              color: Colors.black,
                            ),
                            hintText: 'Genre',
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          initialValue: value.producer.location,
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Location cannot be empty.';
                            return null;
                          },
                          onSaved: (value) =>
                              user.setProd(ProducersMap.location, value),
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.place, color: Colors.black),
                            hintText: 'Location',
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          minLines: 3,
                          maxLines: null,
                          initialValue: value.producer.about,
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Write something about yourself';
                            return null;
                          },
                          onSaved: (value) =>
                              user.setProd(ProducersMap.about, value),
                          keyboardType: TextInputType.multiline,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'About you',
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

class ProfilePhoto extends StatefulWidget {
  const ProfilePhoto({
    Key key,
  }) : super(key: key);

  @override
  _ProfilePhotoState createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  File file;

  _pickImage(BuildContext context) async {
    // ignore: deprecated_member_use
    PickedFile image =
        // ignore: invalid_use_of_visible_for_testing_member
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);

    setState(() {
      if (image.path != null) {
        file = File(image.path);
        Provider.of<UserProvider>(context, listen: false)
            .setProd(ProducersMap.photo, image.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) => Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(75),
            child: SizedBox(
              height: 150,
              width: 150,
              child: file != null
                  ? Image.file(file, fit: BoxFit.cover)
                  : Image.network(value.producer.photo, fit: BoxFit.cover),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.add_a_photo),
                  onPressed: () => _pickImage(context),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
