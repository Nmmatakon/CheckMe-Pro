import 'package:flutter/material.dart';

import './homepage_screen.dart';

import '../widgets/custom_appbar.dart';

class ValidateAccountScreen extends StatelessWidget {
  static const routeName = "/validate-account";

  ValidateAccountScreen({super.key});

  final _studentInfo = {
    'Matricule': '20G60465',
    'Filière': 'Ingénierie des systèmes numériques',
    'Option': 'Production de palteforme numériques',
    'Niveau': '5',
  };

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

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
      appBar: customAppBar(null),
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
                  ...studentInfoTile(_studentInfo),
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
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          HomepageScreen.routeName, ModalRoute.withName("/"));
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
