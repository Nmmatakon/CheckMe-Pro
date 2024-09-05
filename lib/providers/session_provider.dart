import 'dart:convert';

import 'package:http/http.dart' as http;

String urlBase = "http://lameute.alwaysdata.net";

class SessionProvider {
  Future answerCallSession({required String matricule}) async {
    try {
      final response = await http.put(
        Uri.parse("$urlBase/student/answer/$matricule"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'matricule': matricule,
        }),
      );
      // print("la response est la suivante: ${response.body}");
      print("le statut de la reponse est la suivante: ${response.statusCode}");
      if (response.statusCode == 200) {
        print(response.body);
      } else {
        throw Exception('Failed to communicate with server');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
