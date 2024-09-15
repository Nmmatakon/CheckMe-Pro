import 'package:checkme_pro/providers/student_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/fingerprint_auth.dart';
import '../../providers/session_provider.dart';

import '../../models/student.dart';
import '../../models/session.dart';

import 'statistic_grid.dart';
import 'answer_button.dart';

import '../../screens/qr_code_scan_screen.dart';

class HomepageContent extends StatelessWidget {
  const HomepageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final Student student =
        Provider.of<StudentProvider>(context, listen: false).student;
    final Session session =
        Provider.of<SessionProvider>(context, listen: false).session;

    final scaffold = ScaffoldMessenger.of(context);
    final appTheme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    var fingerprintAuth = FingerprintAuth();

    return SizedBox(
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
            subtitle: SizedBox(
                width: double.infinity,
                child: Text(
                  student.filiere,
                  overflow: TextOverflow.ellipsis,
                )),
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
                (mediaQuery.size.height - AppBar().preferredSize.height) * 0.33,
            width: mediaQuery.size.width * 0.9,
            child: StatisticGrid(session: session),
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
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: appTheme.colorScheme.onPrimary.withOpacity(0.15)),
                child: Icon(
                  Icons.next_plan_outlined,
                  color: appTheme.colorScheme.onPrimary,
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [Text(session.title), Text(session.codeUE)],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [Text(session.teacher), Text(session.sessionStatus)],
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
                          await SessionProvider()
                              .answerCallSession(matricule: student.matricule);
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
    );
  }
}
