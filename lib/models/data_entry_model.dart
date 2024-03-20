import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/overlays/data_text_form/data_text_form_widget.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'list_view_model.dart';
export 'list_view_model.dart';

class ListViewWidget extends StatefulWidget {
  const ListViewWidget({super.key});

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  late ListViewModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ListViewModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        floatingActionButton: Align(
          alignment: AlignmentDirectional(1, 1),
          child: FloatingActionButton(
            onPressed: () {
              print('FloatingActionButton pressed ...');
            },
            backgroundColor: FlutterFlowTheme.of(context).tertiary,
            elevation: 8,
            child: Icon(
              Icons.camera_alt_sharp,
              color: FlutterFlowTheme.of(context).info,
              size: 24,
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Align(
            alignment: AlignmentDirectional(-1, -1),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
              child: Text(
                'Enter Data',
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
              showBadge: true,
              shape: badges.BadgeShape.circle,
              badgeColor: FlutterFlowTheme.of(context).tertiary,
              elevation: 4,
              padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
              position: badges.BadgePosition.topEnd(),
              animationType: badges.BadgeAnimationType.scale,
              toAnimate: true,
            ),
          ],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        useSafeArea: true,
                        context: context,
                        builder: (context) {
                          return GestureDetector(
                            onTap: () => _model.unfocusNode.canRequestFocus
                                ? FocusScope.of(context)
                                    .requestFocus(_model.unfocusNode)
                                : FocusScope.of(context).unfocus(),
                            child: Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: DataTextFormWidget(
                                paramType: 'Rainfall',
                                unitType: 'mm',
                              ),
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));
                    },
                    child: ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.cloudRain,
                      ),
                      title: Text(
                        'Rainfall',
                        style: FlutterFlowTheme.of(context).titleLarge,
                      ),
                      subtitle: Text(
                        'Select Mode',
                        style: FlutterFlowTheme.of(context).labelMedium,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 20,
                      ),
                      tileColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      dense: false,
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        enableDrag: false,
                        context: context,
                        builder: (context) {
                          return GestureDetector(
                            onTap: () => _model.unfocusNode.canRequestFocus
                                ? FocusScope.of(context)
                                    .requestFocus(_model.unfocusNode)
                                : FocusScope.of(context).unfocus(),
                            child: Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: DataTextFormWidget(
                                paramType: 'River Level',
                                unitType: 'm',
                              ),
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.water_rounded,
                      ),
                      title: Text(
                        'River Level',
                        style: FlutterFlowTheme.of(context).titleLarge,
                      ),
                      subtitle: Text(
                        'Select Mode',
                        style: FlutterFlowTheme.of(context).labelMedium,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 20,
                      ),
                      tileColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      dense: false,
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        enableDrag: false,
                        context: context,
                        builder: (context) {
                          return GestureDetector(
                            onTap: () => _model.unfocusNode.canRequestFocus
                                ? FocusScope.of(context)
                                    .requestFocus(_model.unfocusNode)
                                : FocusScope.of(context).unfocus(),
                            child: Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: DataTextFormWidget(
                                paramType: 'Well Water',
                                unitType: 'm',
                              ),
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));
                    },
                    child: ListTile(
                      title: Text(
                        'Well Water',
                        style: FlutterFlowTheme.of(context).titleLarge,
                      ),
                      subtitle: Text(
                        'Select Mode',
                        style: FlutterFlowTheme.of(context).labelMedium,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 20,
                      ),
                      tileColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      dense: false,
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        enableDrag: false,
                        context: context,
                        builder: (context) {
                          return GestureDetector(
                            onTap: () => _model.unfocusNode.canRequestFocus
                                ? FocusScope.of(context)
                                    .requestFocus(_model.unfocusNode)
                                : FocusScope.of(context).unfocus(),
                            child: Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: DataTextFormWidget(
                                paramType: 'Tidal Level',
                                unitType: 'm',
                              ),
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));
                    },
                    child: ListTile(
                      title: Text(
                        'Tidal Level',
                        style: FlutterFlowTheme.of(context).titleLarge,
                      ),
                      subtitle: Text(
                        'Select Mode',
                        style: FlutterFlowTheme.of(context).labelMedium,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 20,
                      ),
                      tileColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      dense: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
