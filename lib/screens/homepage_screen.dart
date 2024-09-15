import 'package:checkme_pro/providers/session_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/student_provider.dart';

import '../widgets/custom_appbar.dart';
import '../widgets/homepage/homepage_content.dart';

class HomepageScreen extends StatelessWidget {
  static const routeName = "/home-page";

  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String studentmatricule =
        ModalRoute.of(context)?.settings.arguments as String;
    // Student student = Student(
    //   matricule: "20G60412",
    //   firstName: "NDJESSE LETERE",
    //   lastName: "Emmanuel Andy",
    //   filiere: "Ingenierie des systèmes numériques",
    // );

    Future<void> receivedData() async {
      await Provider.of<StudentProvider>(context, listen: false)
          .fetchStudentByMatricule(studentmatricule);
      await Provider.of<SessionProvider>(context, listen: false)
          .getSession(studentmatricule);
    }

    return Scaffold(
      appBar: customAppBar('CheckME'),
      body: Center(
        child: RefreshIndicator(
          onRefresh: () => receivedData(),
          child: FutureBuilder(
            future: receivedData(),
            builder: (ctx, datasnapshot) {
              if (datasnapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                if (datasnapshot.hasError) {
                  return const Text(
                      "Aucune session n'est active pour le moment");
                } else {
                  return const HomepageContent();
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
