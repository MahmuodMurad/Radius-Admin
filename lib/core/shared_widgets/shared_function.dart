import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:redius_admin/core/cache_helper/local_database.dart';
import 'package:redius_admin/main.dart';

Future<void> sendNotification(BuildContext context, String userToken, String title, String body) async {
  try {
    // Load your service account JSON key file from assets
    var jsonCredentials = await rootBundle.loadString('assets/notification/service_account.json');

    // Parse the JSON key
    var credentials = ServiceAccountCredentials.fromJson(jsonCredentials);

    // Scopes required for Firebase Cloud Messaging API
    var scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

    // Get an authenticated client
    var client = await clientViaServiceAccount(credentials, scopes);

    final Uri url = Uri.parse('https://fcm.googleapis.com/v1/projects/redius-ec442/messages:send');

    // Create the notification payload
    final Map<String, dynamic> message = {
      "message": {
        "token": userToken,
        "notification": {
          "title": title,
          "body": body,
        },
      }
    };

    // Send the HTTP POST request
    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(message),
    );

    // Check the response and show a SnackBar accordingly
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Notification sent successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send notification: ${response.body}')),
      );
    }

    client.close();
  } catch (e) {
    print('Error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}

Future<void> sendNotificationToAll(BuildContext context, String title, String body) async {
  try {
    var jsonCredentials = await rootBundle.loadString('assets/notification/service_account.json');
    var credentials = ServiceAccountCredentials.fromJson(jsonCredentials);
    var scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
    var client = await clientViaServiceAccount(credentials, scopes);

    final Uri url = Uri.parse('https://fcm.googleapis.com/v1/projects/redius-ec442/messages:send');
    String topic = await LocalDatabase.getSecuredString('adminTopic');
    print("topic $topic");

    final Map<String, dynamic> message = {
      "message": {
        "topic": topic,
        "notification": {
          "title": title,
          "body": body,
        },
      }
    };

    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(message),
    );

    if (response.statusCode == 200) {
      print(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Notification sent successfully')),
      );
    } else {
      print('Failed to send notification: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send notification: ${response.body}')),
      );
    }

    client.close();
  } catch (e) {
    print('Error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}

