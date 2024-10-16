import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:gather/components/appbar_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:global_configuration/global_configuration.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _loadContactDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: appBarWidget(context, 'Contact Us'),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Contact Us'),
            ),
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (snapshot.hasData) {
          final contactDetails = snapshot.data!;
          final whatsappNumber = contactDetails['WHATSAPP'];
          final phoneNumber = contactDetails['PHONE'];
          final emailAddress = contactDetails['EMAIL'];

          return Scaffold(
            appBar: AppBar(
              title: Text('Contact Us'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Card(
                    child: ListTile(
                      subtitle: Text('WhatsApp'),
                      title: SelectableText(whatsappNumber),
                    ),
                  ),
                  SizedBox(height: 10),
                  Card(
                    child: ListTile(
                      subtitle: Text('Phone'),
                      title: SelectableText(phoneNumber),
                    ),
                  ),
                  SizedBox(height: 10),
                  Card(
                    child: ListTile(
                      subtitle: Text('Email'),
                      title: SelectableText(emailAddress),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('Contact Us'),
            ),
            body: Center(
              child: Text('No data available'),
            ),
          );
        }
      },
    );
  }

  Future<Map<String, dynamic>> _loadContactDetails() async {
    // Assuming the configuration is loaded correctly from a JSON file
    // await GlobalConfiguration().loadFromPath("assets/config.json");
    return GlobalConfiguration().getValue('CONTACT_US');
  }
}
