import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

class HazardTypeQuestion extends StatefulWidget {
  final Function(String) onOptionSelected;
  final GlobalConfiguration config;

  HazardTypeQuestion({required this.onOptionSelected, required this.config});

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
    _loadOptionsFromConfig(widget.config);
  }

  void _loadOptionsFromConfig(GlobalConfiguration configuration) {
    Map<String, dynamic> hazardTypeData =
        configuration.getValue('HAZARD_TYPES');
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
              widget.onOptionSelected(_selectedOption);
            },
          );
        })
      ],
    );
  }
}
