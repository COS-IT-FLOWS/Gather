import 'package:flutter/material.dart';
import 'package:gather/components/appbar_widget.dart';
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
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.data_array)),
              Tab(icon: Icon(Icons.dashboard)),
              Tab(icon: Icon(Icons.notifications))
            ],
          ),
        ),
        body: TabBarView(children: [
          ListViewWidget(),
          DashboardWidget(),
          NotificationWidget()
        ]),
        floatingActionButton: FloatingCameraWidget(),
      ),
    );
  }
}
