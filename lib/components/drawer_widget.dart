import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Text('Gather Menu')),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Weather Dashboard'),
            onTap: () {
              // Handle tap here
              Navigator.pushNamed(context, '/dashboard');
            },
          ),
          ListTile(
            leading: Icon(Icons.person_2),
            title: Text('Profile'),
            onTap: () {
              // Handle tap here
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              // Handle tap here
              Navigator.pushReplacementNamed(context, '/authentication');
            },
          ),
        ],
      ),
    );
  }
}
