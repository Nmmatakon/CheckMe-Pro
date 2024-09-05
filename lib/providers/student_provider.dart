import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/student.dart';

class StudentProvider {
  Future<Student> fetchStudentByMatricule(String matricule) async {
    var url = Uri.http(
      "lameute.alwaysdata.net",
      "/student/mat/$matricule",
    );
    try {
      final response = await http.get(url);
      final student = jsonDecode(response.body) as Map<String, dynamic>;
      final actualStudent = Student(
        matricule: student['matricule']!,
        firstName: student['firstName']!,
        lastName: student['lastName'],
        filiere: student['filiere'],
      );

      return actualStudent;
    } catch (error) {
      rethrow;
    }
  }
}
