import 'package:checkme_pro/models/student.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/fingerprint_auth.dart';
import '../providers/student_provider.dart';
import '../providers/session_provider.dart';

import '../widgets/custom_appbar.dart';
import '../widgets/statistic_grid.dart';
import '../widgets/answer_button.dart';

import './qr_code_scan_screen.dart';

class HomepageScreen extends StatelessWidget {
  static const routeName = "/home-page";

  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    final appTheme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    var fingerprintAuth = FingerprintAuth();

    // String studentmatricule =
    //     ModalRoute.of(context)?.settings.arguments as String;
    Student student = Student(
      matricule: "20G60412",
      firstName: "NDJESSE LETERE",
      lastName: "Emmanuel Andy",
      filiere: "Ingenierie des systèmes numériques",
    );

    // Future<Student> student =
    //     StudentProvider().fetchStudentByMatricule(student.matricule);

    return Scaffold(
      appBar: customAppBar('CheckME'),
      body: Center(
        child: SizedBox(
          width: mediaQuery.size.width * 0.9,
          child: Column(
            children: [
              // this is the container row with the user icon and the rest
              ListTile(
                leading: const FittedBox(
                  fit: BoxFit.contain,
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage('assets/images/user.png'),
                  ),
                ),
                title: Text(
                  '${student.firstName} ${student.lastName}',
                  style: appTheme.textTheme.titleMedium,
                ),
                subtitle: Text(student.filiere),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                child: Text(
                  DateFormat.yMMMMEEEEd().format(DateTime.now()),
                  textAlign: TextAlign.end,
                ),
              ),
/*********************************The following is the statistic grid*********************************************/
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 10),
                child: const Text(
                  "Participation d'aujourd'hui",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height:
                    (mediaQuery.size.height - AppBar().preferredSize.height) *
                        0.33,
                width: mediaQuery.size.width * 0.9,
                child: StatisticGrid(),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 10),
                child: const Text(
                  "Votre Activité",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
/***************************************************************************************************************** */
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color:
                            appTheme.colorScheme.onPrimary.withOpacity(0.15)),
                    child: Icon(
                      Icons.next_plan_outlined,
                      color: appTheme.colorScheme.onPrimary,
                    ),
                  ),
                  title: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [Text("Check In"), Text("10:00 am")],
                  ),
                  subtitle: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [Text("Apr 17 2023"), Text("on Time")],
                  ),
                ),
              ),
              const Spacer(),
/************************************************************************************************************** */
              SizedBox(
                width: mediaQuery.size.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnswerButton(
                      buttonImage: 'assets/images/empreinte.png',
                      answerCall: () async {
                        if (await fingerprintAuth.checkFingerPrint()) {
                          if (await fingerprintAuth.showFingerPrint()) {
                            try {
                              await SessionProvider().answerCallSession(
                                  matricule: student.matricule);
                              scaffold.showSnackBar(
                                const SnackBar(
                                  content: Text("Authentification réussie"),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } catch (e) {
                              //handling error here
                            }
                          }
                        }
                      },
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10)),
                    AnswerButton(
                        answerCall: () {
                          Navigator.of(context).pushNamed(
                              QrCodeScanScreen.routeName,
                              arguments: student.matricule);
                        },
                        buttonImage: 'assets/images/qrcode.png')
                  ],
                ),
              ),
              const Spacer(),
/******************************************************************************************************************* */
              Text(
                'Répondre à l\'appel',
                style: TextStyle(
                  color: appTheme.colorScheme.onPrimary,
                ),
              ),
              const Text(
                'Veuillez Appuyer sur un button',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              // Last text
              const Spacer(),
              const Text(
                '@uiecc2024',
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
