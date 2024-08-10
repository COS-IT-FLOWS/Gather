import 'dart:async';

import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';

import 'package:gather/models/data_text_form_model.dart';
import 'package:gather/providers/datetime_provider.dart';
import 'package:gather/providers/database_provider.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:provider/provider.dart';
export 'package:gather/models/data_text_form_model.dart';

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

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DataTextFormModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTimeProvider _dateTimeProvider = context.read<DateTimeProvider>();
    DatabaseProvider _databaseProvider = context.read<DatabaseProvider>();
    _dateTextController.text =
        _dateTimeProvider.getDateString(_dateTimeProvider.initialDate);
    _timeTextController.text =
        _dateTimeProvider.getTimeString(context, _dateTimeProvider.initialTime);
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
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          valueOrDefault<String>(
                            // widget.paramType,
                            GlobalConfiguration().getDeepValue(
                                'DISPLAY_NAME_PARAMS:${widget.paramType}'),
                            'parameter',
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 30,
                                  ),
                        ),
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
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .labelMedium,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedErrorBorder:
                                            UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
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
                              valueOrDefault<String>(
                                widget.unitType,
                                'unit',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
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
                                        padding: EdgeInsetsDirectional.fromSTEB(
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
                                                  _dateTimeProvider.selectDate(
                                                      _selectedDate!);
                                                  _dateTextController.text =
                                                      _dateTimeProvider
                                                          .getDateString(
                                                              _dateTimeProvider
                                                                  .selectedDate);
                                                }
                                              })
                                        ])))),
                            Expanded(
                                flex: 1,
                                child: Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
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
                                                            _dateTimeProvider
                                                                .selectedTime);
                                                if (_selectedTime != null) {
                                                  _dateTimeProvider.selectTime(
                                                      _selectedTime!);
                                                  _timeTextController.text =
                                                      _dateTimeProvider
                                                          .getTimeString(
                                                              context,
                                                              _dateTimeProvider
                                                                  .selectedTime);
                                                }
                                              })
                                        ])))),
                          ],
                        ),
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                DateTime _timeStamp =
                                    _dateTimeProvider.getSelectedDateTime();
                                double _parameterValue =
                                    double.parse(_model.textController.text);
                                await _databaseProvider.insertWeatherData(
                                    'RAINFALL',
                                    _timeStamp,
                                    'RAIN0001',
                                    _parameterValue);

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

                                // ScaffoldMessenger.of(context)
                                //     .showSnackBar(const SnackBar(
                                //   content: Text("Data Submitted Successfully"),
                                // ));

                                Navigator.of(context).pop();
                              }
                            },
                            text: 'Submit',
                            options: FFButtonOptions(
                              width: MediaQuery.sizeOf(context).width * 0.6,
                              height: 40,
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                              iconPadding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle:
                                  FlutterFlowTheme.of(context).titleMedium,
                              elevation: 3,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
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
