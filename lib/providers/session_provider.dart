import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/session.dart';

class SessionProvider with ChangeNotifier {
  static String hostIp = "192.168.1.170";
  static int hostPort = 9000;

  late Session session;

  Future<void> answerCallSession({required String matricule}) async {
    var url = Uri(
      scheme: "http",
      host: hostIp,
      port: hostPort,
      path: "/student/answer/$matricule",
    );
    try {
      await http.put(url);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getSession(String matricule) async {
    var url = Uri(
      scheme: "http",
      host: hostIp,
      port: hostPort,
      path: "/student/session/active/$matricule",
    );
    try {
      final response = await http.get(url);
      final sessionresponse = jsonDecode(response.body) as Map<String, dynamic>;
      final actualSession = Session(
        codeUE: sessionresponse['subject']['codeUE'],
        title: sessionresponse['subject']['name'],
        teacher: sessionresponse['subject']['teacher'],
        startTime: sessionresponse['startTime'],
        endTime: sessionresponse['endTime'],
        numberOfSession: sessionresponse['numberOfSession'],
        active: sessionresponse['active'],
        sessionStatus: sessionresponse['sessionStatus'],
      );
      session = actualSession;
    } catch (e) {
      rethrow;
    }
  }
}
