import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:provider/provider.dart';

import 'package:gather/components/appbar_widget.dart';
import 'package:gather/components/floating_camera_widget.dart';
import 'package:gather/models/user_data_model.dart';
import 'package:gather/providers/database_provider.dart';
import 'package:gather/providers/auth_provider.dart';
import 'package:gather/providers/profile_provider.dart';

import 'package:gather/components/confirmation_dialog_widget.dart';

class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // String _username;

  @override
  Widget build(BuildContext context) {
    DatabaseProvider _databaseProvider = context.read<DatabaseProvider>();
    SignInProvider _authProvider = context.read<SignInProvider>();
    ProfileProvider _profileProvider = context.watch<ProfileProvider>();
    TextEditingController _firstNameController = TextEditingController();
    TextEditingController _lastNameController = TextEditingController();
    TextEditingController _phoneNumberController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _occupationController = TextEditingController();
    TextEditingController _userAgeController = TextEditingController();
    return Scaffold(
        // appBar: appBarWidget(context, 'User Profile'),
        appBar: AppBar(
          iconTheme:
              IconThemeData(color: Colors.white), // Set icon color to white
          title: Text(style: TextStyle(color: Colors.white), 'User Profile'),
          backgroundColor: FlutterFlowTheme.of(context).primary,
          actions: [
            IconButton(
                icon: !_profileProvider.isEditProfileDetails
                    ? Icon(Icons.edit)
                    : Icon(Icons.check),
                onPressed: () {
                  if (_profileProvider.isEditProfileDetails == false) {
                    _profileProvider.setProfileEditFlag(true);
                  } else {
                    UserDataModel userDataWriteModel = UserDataModel(
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                      phoneNumber: _phoneNumberController.text,
                      emailAddress: _emailController.text,
                      occupation: _occupationController.text,
                      userAge: int.tryParse(_userAgeController.text) ?? 0,
                    );
                    _databaseProvider.insertUserData(userDataWriteModel);
                    _profileProvider.setProfileEditFlag(false);
                  }
                })
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
          child: FutureBuilder<UserDataModel>(
              future: _databaseProvider.readUserData(_authProvider.userId),
              builder: (BuildContext context,
                  AsyncSnapshot<UserDataModel> snapshot) {
                if (snapshot.hasData) {
                  UserDataModel userDataReadModel = snapshot.data!;
                  _firstNameController.text = userDataReadModel.firstName ?? '';
                  _lastNameController.text = userDataReadModel.lastName ?? '';
                  _phoneNumberController.text =
                      userDataReadModel.phoneNumber ?? '';
                  _emailController.text = userDataReadModel.emailAddress ?? '';
                  _occupationController.text =
                      userDataReadModel.occupation ?? '';
                  _userAgeController.text =
                      userDataReadModel.userAge.toString();
                  return ListView(shrinkWrap: true, children: [
                    ListTile(
                        leading: SizedBox(
                          width: 80,
                          child: Text('First Name',
                              style: TextStyle(fontSize: 14)),
                        ),
                        title: TextFormField(
                            style: TextStyle(fontSize: 15),
                            readOnly: !_profileProvider.isEditProfileDetails,
                            controller: _firstNameController)),
                    ListTile(
                        leading: SizedBox(
                            width: 80,
                            child: Text('Last Name',
                                style: TextStyle(fontSize: 14))),
                        title: TextFormField(
                            readOnly: !_profileProvider.isEditProfileDetails,
                            controller: _lastNameController)),
                    ListTile(
                        leading: SizedBox(
                            width: 80,
                            child:
                                Text('Phone', style: TextStyle(fontSize: 14))),
                        title: TextFormField(
                            readOnly: !_profileProvider.isEditProfileDetails,
                            controller: _phoneNumberController)),
                    ListTile(
                        leading: SizedBox(
                            width: 80,
                            child:
                                Text('Email', style: TextStyle(fontSize: 14))),
                        title: TextField(
                            readOnly: true, controller: _emailController)),
                    ListTile(
                        leading: SizedBox(
                            width: 80,
                            child: Text('Occupation',
                                style: TextStyle(fontSize: 14))),
                        title: TextFormField(
                            readOnly: !_profileProvider.isEditProfileDetails,
                            controller: _occupationController)),
                    ListTile(
                        leading: SizedBox(
                            width: 80,
                            child: Text('Age', style: TextStyle(fontSize: 14))),
                        title: TextFormField(
                            readOnly: !_profileProvider.isEditProfileDetails,
                            controller: _userAgeController)),
                    ListTile(
                        leading: SizedBox(
                            width: 80,
                            child: Text('Station IDs:',
                                style: TextStyle(fontSize: 14))),
                        title: Text(
                            style: TextStyle(fontWeight: FontWeight.bold),
                            userDataReadModel.stationIds != null
                                ? userDataReadModel.stationIds!.join(', ')
                                : 'None')),
                  ]);
                } else if (snapshot.hasError) {
                  return Center(child: Text('Data unavailable'));
                } else {
                  return Center(
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              }),
        ));
    // floatingActionButton: FloatingCameraWidget(),
  }
}
