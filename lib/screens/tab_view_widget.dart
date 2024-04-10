import 'package:flutter/material.dart';
import 'package:gather/components/floating_camera_widget.dart';
import 'package:gather/screens/list_view_widget.dart';
import 'package:gather/screens/dashboard_widget.dart';
import 'package:gather/screens/notification_widget.dart';

class TabViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              // handle logout
              Navigator.pushReplacementNamed(context, '/initialRoute');
            },
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          bottom: TabBar(
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.redAccent),
            indicatorColor: Colors.red,
            // indicatorWeight: 0,
            tabs: [
              Tab(icon: Icon(Icons.numbers)),
              Tab(icon: Icon(Icons.dashboard)),
              Tab(icon: Icon(Icons.notifications))
            ],
          ),
        ),
        body: TabBarView(physics: NeverScrollableScrollPhysics(), children: [
          ListViewWidget(),
          DashboardWidget(),
          NotificationWidget()
        ]),
        floatingActionButton: FloatingCameraWidget(),
      ),
    );
  }
}
