import 'package:flutter/material.dart';
import 'package:gather/components/floating_camera_widget.dart';
import 'package:gather/screens/home_page_widget.dart';
import 'package:gather/screens/dashboard_widget.dart';
import 'package:gather/screens/notification_widget.dart';

import 'package:gather/models/tab_view_model.dart';
export 'package:gather/models/tab_view_model.dart';

class TabViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          // toolbarHeight: 50,
          leading: IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              // handle logout
              Navigator.pushReplacementNamed(context, '/initialRoute');
            },
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: TabBar(
            dividerColor: Colors.transparent,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent),
            indicatorWeight: 0,
            tabs: [
              Tab(
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.redAccent, width: 1)),
                    child: Icon(Icons.numbers)),
              ),
              Tab(
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.redAccent, width: 1)),
                    child: Icon(Icons.dashboard)),
              ),
              Tab(
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.redAccent, width: 1)),
                    child: Icon(Icons.notifications)),
              ),
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
