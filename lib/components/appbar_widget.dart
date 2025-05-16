import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:gather/themes/app_theme.dart';

PreferredSizeWidget appBarWidget(context, title) {
  bool _showButton(BuildContext context) {
    final ModalRoute<Object?>? route = ModalRoute.of(context);
    return route?.settings.name != '/notifications';
  }
  // final String title;

  return AppBar(
    iconTheme: IconThemeData(color: Colors.white),
    backgroundColor: AppTheme.primaryColor(context),
    // automaticallyImplyLeading: false,
    title: Align(
      alignment: AlignmentDirectional(-1, -1),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
        child: Text(
          title,
          style: TextStyle(
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
          style: TextStyle(
            fontFamily: 'Readex Pro',
            color: Colors.white,
          ),
        ),
        // showBadge: _notificationProvider.showBadge,
        showBadge: false,
        badgeStyle: badges.BadgeStyle(
            shape: badges.BadgeShape.circle,
            badgeColor: AppTheme.tertiaryColor(context),
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
