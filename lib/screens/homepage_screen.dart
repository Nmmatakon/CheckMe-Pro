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

    String studentmatricule =
        ModalRoute.of(context)?.settings.arguments as String;

    Future<Student> student =
        StudentProvider().fetchStudentByMatricule(studentmatricule);

    return Scaffold(
      appBar: customAppBar('CheckME'),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Acceuil', style: appTheme.textTheme.displayLarge),
            const Spacer(),
            // this is the container row with the user icon and the rest
            FutureBuilder(
                future: student,
                builder: (ctx, dataSnapshot) {
                  if (dataSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (dataSnapshot.error != null) {
                      // Do error handling stuff here
                      return const Center(child: Text('An error occured'));
                    } else {
                      return SizedBox(
                        width: mediaQuery.size.width * 0.9,
                        child: Card(
                          margin: const EdgeInsets.all(5),
                          child: ListTile(
                            leading: const FittedBox(
                              fit: BoxFit.contain,
                              child: CircleAvatar(
                                radius: 80,
                                backgroundImage:
                                    AssetImage('assets/images/user.png'),
                              ),
                            ),
                            title: Text(
                              '${dataSnapshot.data?.firstName} ${dataSnapshot.data?.lastName}',
                              style: appTheme.textTheme.titleMedium,
                            ),
                            subtitle: Text('${dataSnapshot.data?.filiere}'),
                          ),
                        ),
                      );
                    }
                  }
                }),
            const Spacer(),
            SizedBox(
                width: mediaQuery.size.width * 0.8,
                child: Text(
                  DateFormat.yMMMMEEEEd().format(DateTime.now()),
                )),
            const Spacer(),
            // The following is the statistic grid
            SizedBox(
              height: (mediaQuery.size.height - AppBar().preferredSize.height) *
                  0.15,
              width: mediaQuery.size.width * 0.9,
              child: StatisticGrid(),
            ),
            const Spacer(),
            // this is the button to answer at roll call by finger print
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
                            await SessionProvider()
                                .answerCallSession(matricule: studentmatricule);
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
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                  AnswerButton(
                      answerCall: () {
                        Navigator.of(context).pushNamed(
                            QrCodeScanScreen.routeName,
                            arguments: studentmatricule);
                      },
                      buttonImage: 'assets/images/qrcode.png')
                ],
              ),
            ),
            const Spacer(),
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
    );
  }
}
