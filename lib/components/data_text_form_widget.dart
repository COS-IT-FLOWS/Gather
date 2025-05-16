import 'dart:async';
import 'package:flutter/material.dart';

import 'package:gather/models/data_text_form_model.dart';
import 'package:gather/providers/datetime_provider.dart';
import 'package:gather/providers/database_provider.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:provider/provider.dart';
export 'package:gather/models/data_text_form_model.dart';
import 'package:gather/providers/profile_provider.dart';
import 'package:gather/themes/app_theme.dart';

class DataTextFormWidget extends StatefulWidget {
  const DataTextFormWidget({
    super.key,
    this.paramType,
    this.unitType,
  });

  final String? paramType;
  final String? unitType;

  @override
  State<DataTextFormWidget> createState() => _DataTextFormWidgetState();
}

class _DataTextFormWidgetState extends State<DataTextFormWidget> {
  late DataTextFormModel _model;
  late DateTime? _selectedDate;
  late TimeOfDay? _selectedTime;
  TextEditingController _dateTextController = TextEditingController();
  TextEditingController _timeTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late Timer _timer;

  // @override
  // void setState(VoidCallback callback) {
  //   super.setState(callback);
  //   _model.onUpdate();
  // }

  @override
  void initState() {
    super.initState();
    // _model = createModel(context, () => DataTextFormModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  // @override
  // void dispose() {
  //   _model.maybeDispose();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    DateTimeProvider dateTimeProvider = context.read<DateTimeProvider>();
    DatabaseProvider databaseProvider = context.read<DatabaseProvider>();
    ProfileProvider profileProvider = context.read<ProfileProvider>();
    // if (dateTimeProvider.initialDate != null) {
    _dateTextController.text =
        dateTimeProvider.getDateString(dateTimeProvider.initialDate);
    // }
    _timeTextController.text =
        dateTimeProvider.getTimeString(dateTimeProvider.initialTime);
    String? parameterType = widget.paramType;
    String? stationIdPrefix = (GlobalConfiguration()
                .getDeepValue('STATION_ID_TEMPLATE:$parameterType') !=
            null)
        ? GlobalConfiguration()
            .getDeepValue('STATION_ID_TEMPLATE:$parameterType')
        : 'TEST';
    String? selectedStationId = profileProvider.stationIds!
        .firstWhere((id) => id.contains(stationIdPrefix), orElse: () => null);
    if (selectedStationId == null) {
      return AlertDialog(
        title: const Text('No Station ID Found'),
        content: const Text('Please select a valid station ID'),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    } else {
      return Form(
        key: _formKey,
        child: Material(
          color: Colors.transparent,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Container(
            width: double.infinity,
            height: 370,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [],
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Container(
                      width: 317,
                      height: 321,
                      decoration: BoxDecoration(
                        color: AppTheme.secondaryBackground(context),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            GlobalConfiguration().getDeepValue(
                                    'DISPLAY_NAME_PARAMS:$parameterType') ??
                                'parameter',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 30,
                            ),
                          ),
                          Text(selectedStationId),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 0, 8, 0),
                                    child: TextFormField(
                                        controller: _model.textController,
                                        focusNode: _model.textFieldFocusNode,
                                        autofocus: true,
                                        obscureText: false,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          alignLabelWithHint: false,
                                          // hintStyle:
                                          //     FlutterFlowTheme.of(context)
                                          //         .labelMedium,
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  AppTheme.accentColor(context),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppTheme.primaryColor(
                                                  context),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  AppTheme.errorColor(context),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedErrorBorder:
                                              UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  AppTheme.errorColor(context),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 25,
                                          letterSpacing: 10,
                                        ),
                                        textAlign: TextAlign.end,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter a value';
                                          }
                                          return null;
                                        }),
                                  ),
                                ),
                              ),
                              Text(
                                widget.unitType ?? 'unit',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8, 0, 8, 0),
                                          child: Column(children: [
                                            TextFormField(
                                                controller: _dateTextController,
                                                readOnly: true,
                                                onTap: () async {
                                                  _selectedDate =
                                                      await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate: DateTime
                                                                  .now()
                                                              .subtract(
                                                                  const Duration(
                                                                      days: 1)),
                                                          lastDate:
                                                              DateTime.now());
                                                  if (_selectedDate != null) {
                                                    dateTimeProvider.selectDate(
                                                        _selectedDate!);
                                                    _dateTextController.text =
                                                        dateTimeProvider
                                                            .getDateString(
                                                                dateTimeProvider
                                                                    .selectedDate!);
                                                  }
                                                })
                                          ])))),
                              Expanded(
                                  flex: 1,
                                  child: Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8, 0, 8, 0),
                                          child: Column(children: [
                                            TextFormField(
                                                controller: _timeTextController,
                                                readOnly: true,
                                                onTap: () async {
                                                  _selectedTime =
                                                      await showTimePicker(
                                                          context: context,
                                                          initialTime:
                                                              dateTimeProvider
                                                                  .selectedTime!);
                                                  if (_selectedTime != null) {
                                                    dateTimeProvider.selectTime(
                                                        _selectedTime!);
                                                    _timeTextController.text =
                                                        dateTimeProvider
                                                            .getTimeString(
                                                                dateTimeProvider
                                                                    .selectedTime);
                                                  }
                                                })
                                          ])))),
                            ],
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  DateTime _timeStamp =
                                      dateTimeProvider.getSelectedDateTime();
                                  double _parameterValue =
                                      double.parse(_model.textController!.text);
                                  bool ifSuccess =
                                      await databaseProvider.insertWeatherData(
                                          parameterType,
                                          _timeStamp,
                                          selectedStationId,
                                          _parameterValue);
                                  if (ifSuccess) {
                                    await showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text(
                                            'Data Submitted Successfully'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'OK'),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  // ScaffoldMessenger.of(context)
                                  // .showSnackBar(const SnackBar(
                                  // content: Text("Data Submitted Successfully"),
                                  // ));
                                  Navigator.of(context).pop();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryColor(context),
                                foregroundColor: Colors.white,
                                elevation: 3,
                                padding: EdgeInsets.symmetric(horizontal: 24),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                ),
                                minimumSize: Size(
                                    MediaQuery.of(context).size.width * 0.6,
                                    40),
                              ),
                              child: Text(
                                'Submit',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
