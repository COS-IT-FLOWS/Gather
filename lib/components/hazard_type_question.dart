import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

class HazardTypeQuestion extends StatefulWidget {
  @override
  _HazardTypeQuestionState createState() => _HazardTypeQuestionState();
}

class _HazardTypeQuestionState extends State<HazardTypeQuestion> {
  String _selectedOption = '';
  Map<String, dynamic> _hazardTypeData = {};

  get hazardTypeData => _hazardTypeData;

  @override
  void initState() {
    super.initState();
    _loadOptionsFromConfig();
  }

  Future<void> _loadOptionsFromConfig() async {
    Map<String, dynamic> hazardTypeData =
        GlobalConfiguration().getValue('HAZARD_TYPES');
    setState(() {
      _hazardTypeData = hazardTypeData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            style: TextStyle(fontSize: 20),
            hazardTypeData['QUESTION'],
            textAlign: TextAlign.left),
        ..._hazardTypeData['OPTIONS'].map((option) {
          return RadioListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            title: Text(
              option['text'].toString(),
              style: TextStyle(fontSize: 17),
            ),
            value: option['value'].toString(),
            groupValue: _selectedOption,
            onChanged: (value) {
              setState(() {
                _selectedOption = value.toString();
              });
            },
          );
        })
      ],
    );
  }
}
