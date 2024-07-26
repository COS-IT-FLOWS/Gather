import 'package:flutter/material.dart';
import 'package:gather/components/appbar_widget.dart';
import 'package:gather/components/floating_camera_widget.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // String _username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, 'User Profile'),
      body: Center(child: Text('Profile Details')
          // child: StreamBuilder<DocumentSnapshot>(
          // stream: _firestore.collection('users').doc('userId').snapshots(),
          // builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          //   if (snapshot.hasError) {
          //     return Text('Error: ${snapshot.error}');
          //   } else if (!snapshot.hasData) {
          //     return CircularProgressIndicator();
          //   } else if (snapshot.hasData) {
          //     Map<String, dynamic> data = snapshot.data.data();
          //     _username = data['username'];
          //     return Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         CircleAvatar(
          //           radius: 50,
          //           backgroundImage: AssetImage('assets/profile_picture.jpg'),
          //         ),
          //         SizedBox(height: 16),
          //         Text(
          //           'Username: $_username',
          //           style: TextStyle(fontSize: 20),
          //         ),
          //         SizedBox(height: 8),
          //         Text(
          //           'Email: ${data['email']}',
          //           style: TextStyle(fontSize: 16),
          //         ),
          //       ],
          //     );
          //   }
          //   return Container();
          // },
          ),
      floatingActionButton: FloatingCameraWidget(),
    );
  }
}
