import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gather/providers/auth_provider.dart';

final signOutSnackBar = SnackBar(
  content: Text('You have successfully logged out'),
);

class DrawerWidget extends StatelessWidget {
  SignInProvider? _signInProvider;

  @override
  Widget build(BuildContext context) {
    return Consumer<SignInProvider>(builder: (context, signInProvider, child) {
      _signInProvider = signInProvider;
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
              trailing: const DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: const Text(
                      'Launching Soon',
                    ),
                  )),
              onTap: () {
                // Handle tap here
                // Navigator.pushNamed(context, '/dashboard');
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
                leading: Icon(Icons.info),
                title: Text('About Us'),
                onTap: () {
                  Navigator.pushNamed(context, '/about-us');
                }),
            ListTile(
                leading: Icon(Icons.phone),
                title: Text('Contact Us'),
                onTap: () {
                  Navigator.pushNamed(context, '/contact-us');
                }),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () async {
                // Handle tap here
                await _signInProvider!.signOut();
                // if (!mounted) return;
                Navigator.pushReplacementNamed(context, '/authentication');
                ScaffoldMessenger.of(context).showSnackBar(signOutSnackBar);
              },
            ),
          ],
        ),
      );
    });
  }
}
