import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  // print('Handling a background message ${message.messageId}');
}

String _token = FirebaseMessaging.instance.getToken(
        vapidKey: 'AAAAxc6AaH8:APA91bHklWqDjW292n9k-bW12OZlxeccVF0b7hiRo_02-'
            'RtrR0eaOcpZGlmk77SMMfnVWVVY1nEvAFwzoYfH31TA4t_9GJUBIjC3YdrVjBQ-Dw-SqMu6VZ5E0EzbXfaz35GGN0xapJYu')
    as String;

Future<void> sendPushMessage() async {
  try {
    await http.post(
      Uri.parse('https://api.rnfirebase.io/messaging/send'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: constructFCMPayload(_token),
    );
  } catch (e) {
    log(e.toString());
  }
}

int _messageCount = 0;

String constructFCMPayload(String? token) {
  _messageCount++;
  return jsonEncode({
    'token': token,
    'data': {
      'via': 'FlutterFire Cloud Messaging!!!',
      'count': _messageCount.toString(),
    },
    'notification': {
      'title': 'Medicines Alert',
      'body': 'Number of Medicines is less than 20'
    }
  });
}
