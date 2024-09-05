import 'package:flutter/material.dart';

import './homepage_screen.dart';

import '../models/student.dart';

import '../providers/local_file_provider.dart';

import '../widgets/custom_appbar.dart';

class ValidateAccountScreen extends StatelessWidget {
  static const routeName = "/validate-account";

  const ValidateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Student? student = ModalRoute.of(context)?.settings.arguments as Student?;
    final appTheme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final navigator = Navigator.of(context);

    final studentInfo = {
      'Matricule': student!.matricule,
      'Nom': student.firstName,
      'Prénom': student.lastName,
      'Filière': student.filiere,
    };

    List<Widget> studentInfoTile(Map<String, String> studentInfo) {
      List<Widget> studentInfoList = [];
      for (var i = 0; i < studentInfo.keys.toList().length; i++) {
        studentInfoList.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Spacer(),
              Text(
                studentInfo.keys.toList()[i],
                style: appTheme.textTheme.titleMedium,
              ),
              Text(
                '  :  ',
                style: appTheme.textTheme.titleMedium,
              ),
              SizedBox(
                width: mediaQuery.size.width * 0.45,
                child: Text(
                  studentInfo.values.toList()[i],
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        );
      }
      return studentInfoList;
    }

    return Scaffold(
      appBar: customAppBar(null, context),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.1),
              child: Text(
                'Vérfiez vos informations',
                style: appTheme.textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: mediaQuery.size.height * 0.025),
              height: mediaQuery.size.height * 0.15,
              child: Image.asset(
                'assets/images/user.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              constraints:
                  BoxConstraints(maxWidth: mediaQuery.size.width * 0.8),
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: appTheme.colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'NDJESSE LETERE Emmanuel Andy',
                style: appTheme.textTheme.titleLarge,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: (mediaQuery.size.height - AppBar().preferredSize.height) *
                  0.3,
              width: mediaQuery.size.width * 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ...studentInfoTile(studentInfo),
                ],
              ),
            ),
            SizedBox(
              width: mediaQuery.size.width * 0.55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: appTheme.colorScheme.onPrimary,
                        side: BorderSide(
                          color: appTheme.colorScheme.onPrimary,
                        )),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Annuler'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await LocalFileProvider().writeToFile(student.matricule);
                      navigator.pushNamedAndRemoveUntil(
                          HomepageScreen.routeName, ModalRoute.withName("/"),
                          arguments: student.matricule);
                    },
                    child: const Text('Valider'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
