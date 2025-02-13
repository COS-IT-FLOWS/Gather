import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:gather/components/data_text_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gather/components/floating_camera_widget.dart';
import 'package:gather/models/list_view_model.dart';
import 'package:gather/components/appbar_widget.dart';
import 'package:gather/components/drawer_widget.dart';
import 'package:gather/models/user_data_model.dart';
import 'package:gather/providers/auth_provider.dart';
import 'package:gather/providers/database_provider.dart';
import 'package:gather/providers/profile_provider.dart';
import 'package:provider/provider.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SignInProvider authProvider = context.read<SignInProvider>();
    DatabaseProvider databaseProvider = context.read<DatabaseProvider>();
    ProfileProvider profileProvider = context.read<ProfileProvider>();
    return FutureBuilder<UserDataModel>(
        future: databaseProvider.readUserData(authProvider.userId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserDataModel userDataReadModel = snapshot.data!;
            if (userDataReadModel.stationIds != null) {
              profileProvider.setStationIds(userDataReadModel.stationIds!);
            }
            return GestureDetector(
              onTap: () => _model.unfocusNode.canRequestFocus
                  ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                  : FocusScope.of(context).unfocus(),
              child: Scaffold(
                appBar: appBarWidget(context, 'Enter Data'),
                drawer: DrawerWidget(),
                key: scaffoldKey,
                body: SafeArea(
                  top: true,
                  child: Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10, // Spacing between rows
                          crossAxisSpacing: 10,
                        ),
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
                                      onTap: () => _model
                                              .unfocusNode.canRequestFocus
                                          ? FocusScope.of(context)
                                              .requestFocus(_model.unfocusNode)
                                          : FocusScope.of(context).unfocus(),
                                      child: Padding(
                                        padding:
                                            MediaQuery.viewInsetsOf(context),
                                        child: DataTextFormWidget(
                                          paramType: 'RAINFALL',
                                          unitType: 'mm',
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      width: 2,
                                      color: FlutterFlowTheme.of(context)
                                          .secondary,
                                    )),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/data_param_rainfall.png',
                                      height: 75,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Rainfall',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                  ],
                                ),
                              )),
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
                                      onTap: () => _model
                                              .unfocusNode.canRequestFocus
                                          ? FocusScope.of(context)
                                              .requestFocus(_model.unfocusNode)
                                          : FocusScope.of(context).unfocus(),
                                      child: Padding(
                                        padding:
                                            MediaQuery.viewInsetsOf(context),
                                        child: DataTextFormWidget(
                                          paramType: 'RIVER',
                                          unitType: 'm',
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      width: 2,
                                      color: FlutterFlowTheme.of(context)
                                          .secondary,
                                    )),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/data_param_river.png',
                                      height: 75,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'River',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                  ],
                                ),
                              )),
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
                                      onTap: () => _model
                                              .unfocusNode.canRequestFocus
                                          ? FocusScope.of(context)
                                              .requestFocus(_model.unfocusNode)
                                          : FocusScope.of(context).unfocus(),
                                      child: Padding(
                                        padding:
                                            MediaQuery.viewInsetsOf(context),
                                        child: DataTextFormWidget(
                                          paramType: 'GROUNDWATER',
                                          unitType: 'm',
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      width: 2,
                                      color: FlutterFlowTheme.of(context)
                                          .secondary,
                                    )),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/data_param_well.png',
                                      height: 75,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Groundwater',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                  ],
                                ),
                              )),
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
                                      onTap: () => _model
                                              .unfocusNode.canRequestFocus
                                          ? FocusScope.of(context)
                                              .requestFocus(_model.unfocusNode)
                                          : FocusScope.of(context).unfocus(),
                                      child: Padding(
                                        padding:
                                            MediaQuery.viewInsetsOf(context),
                                        child: DataTextFormWidget(
                                          paramType: 'TIDAL',
                                          unitType: 'm',
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      width: 2,
                                      color: FlutterFlowTheme.of(context)
                                          .secondary,
                                    )),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/data_param_tide.png',
                                      height: 75,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Tidal',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                floatingActionButton: FloatingCameraWidget(),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
