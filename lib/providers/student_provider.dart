import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/student.dart';

import './session_provider.dart';

class StudentProvider with ChangeNotifier {
  late Student student;

  Future<void> fetchStudentByMatricule(String matricule) async {
    var url = Uri(
      scheme: "http",
      host: SessionProvider.hostIp,
      port: SessionProvider.hostPort,
      path: "/student/mat/$matricule",
    );
    try {
      final response = await http.get(url);
      final studentResponse = jsonDecode(response.body) as Map<String, dynamic>;
      final actualStudent = Student(
        matricule: studentResponse['matricule']!,
        firstName: studentResponse['firstName']!,
        lastName: studentResponse['lastName'],
        filiere: studentResponse['filiere'],
      );

      student = actualStudent;
    } catch (error) {
      rethrow;
    }
  }
}
