import 'package:checkme_pro/models/student.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/fingerprint_auth.dart';
import '../providers/student_provider.dart';

import '../widgets/custom_appbar.dart';
import '../widgets/statistic_grid.dart';

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
            // Coures description is below
            SizedBox(
              width: mediaQuery.size.width * 0.9,
              child: ListTile(
                leading: const Text(
                  "ISN5211",
                  style: TextStyle(fontSize: 14),
                ),
                title: Text(
                  'Management de l\'innovation Digitale',
                  style: appTheme.textTheme.titleMedium,
                ),
                subtitle: const Text('Pr SONE MBASSI'),
                trailing: Container(
                  width: 20,
                  decoration: const BoxDecoration(
                      color: Colors.green, shape: BoxShape.circle),
                ),
              ),
            ),
            const Spacer(),
            // The following is the statistic grid
            SizedBox(
              height: (mediaQuery.size.height - AppBar().preferredSize.height) *
                  0.15,
              width: mediaQuery.size.width * 0.9,
              child: StatisticGrid(),
            ),
            const Spacer(),
            // this is the button to answer at roll call
            GestureDetector(
              onTap: () async {
                if (await fingerprintAuth.checkFingerPrint()) {
                  if (await fingerprintAuth.showFingerPrint()) {
                    scaffold.showSnackBar(
                      const SnackBar(
                        content: Text("Authentification réussie"),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }
                }
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset.zero,
                          blurRadius: 10,
                          spreadRadius: 2,
                          color: Color.fromARGB(20, 33, 149, 243)),
                    ],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: appTheme.colorScheme.onPrimary)),
                height: 80,
                child: Image.asset(
                  'assets/images/empreinte.png',
                  fit: BoxFit.cover,
                ),
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
              'Veuillez Appuyer',
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
