import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:badges/badges.dart' as badges;

PreferredSizeWidget appBarWidget(context, title) {
  bool _showButton(BuildContext context) {
    final ModalRoute<Object?>? route = ModalRoute.of(context);
    return route?.settings.name != '/notifications';
  }
  // final String title;

  return AppBar(
    backgroundColor: FlutterFlowTheme.of(context).primary,
    // automaticallyImplyLeading: false,
    title: Align(
      alignment: AlignmentDirectional(-1, -1),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
        child: Text(
          title,
          style: FlutterFlowTheme.of(context).headlineMedium.override(
                fontFamily: 'Outfit',
                color: Colors.white,
                fontSize: 22,
              ),
        ),
      ),
    ),
    actions: [
      badges.Badge(
        badgeContent: Text(
          '1',
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.of(context).titleSmall.override(
                fontFamily: 'Readex Pro',
                color: Colors.white,
              ),
        ),
        // showBadge: _notificationProvider.showBadge,
        showBadge: false,
        badgeStyle: badges.BadgeStyle(
            shape: badges.BadgeShape.circle,
            badgeColor: FlutterFlowTheme.of(context).tertiary,
            elevation: 4,
            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8)),
        position: badges.BadgePosition.topEnd(),
        badgeAnimation: badges.BadgeAnimation.scale(),
        child: _showButton(context)
            ? IconButton(
                icon: Icon(Icons.notifications, size: 20),
                color: Colors.white,
                onPressed: () async {
                  Navigator.pushNamed(context, '/notifications');
                },
              )
            : null,
      ),
    ],
    centerTitle: false,
    elevation: 2,
  );
}
