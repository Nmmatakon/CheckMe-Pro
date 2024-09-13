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
    // Student student = Student(
    //   matricule: "20G60412",
    //   firstName: "NDJESSE LETERE",
    //   lastName: "Emmanuel Andy",
    //   filiere: "Ingenierie des systèmes numériques",
    // );

    final appTheme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final navigator = Navigator.of(context);

    return Scaffold(
      appBar: customAppBar("Valider votre compte"),
      body: Center(
        child: SizedBox(
          height: double.infinity,
          width: mediaQuery.size.width * 0.9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Veuillez vérfier vos informations',
                style: TextStyle(
                  fontSize: mediaQuery.size.width * 0.05,
                ),
              ),
/************************************************************************************************************* */
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  top: mediaQuery.size.height * 0.025,
                  bottom: 5,
                ),
                height: mediaQuery.size.height * 0.15,
                child: Image.asset(
                  'assets/images/user.png',
                  fit: BoxFit.cover,
                ),
              ),
              const Divider(
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
/*********************************************************************************************************** */
              InfoTile(
                title: student!.matricule,
                subTitle: "Matricule",
                iconData: Icons.numbers,
              ),
              InfoTile(
                title: student.firstName,
                subTitle: "Nom",
                iconData: Icons.account_circle,
              ),
              InfoTile(
                title: student.lastName,
                subTitle: "Prénom",
                iconData: Icons.account_circle_outlined,
              ),
              InfoTile(
                title: student.filiere,
                subTitle: "Filière",
                iconData: Icons.app_registration_rounded,
              ),
/*************************************************Buttons********************************************************** */
              Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: mediaQuery.size.height * 0.01)),
              ElevatedButton(
                onPressed: () async {
                  await LocalFileProvider().writeToFile(student.matricule);
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Container(
                        alignment: Alignment.center,
                        height: mediaQuery.size.height * 0.2,
                        child: Image.asset(
                          'assets/images/createaccount.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Félicitaions🎉',
                            style: appTheme.textTheme.displayLarge,
                          ),
                          const Text('Votre compte est prêt à l\'emploi'),
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              navigator.pushNamedAndRemoveUntil(
                                  HomepageScreen.routeName,
                                  ModalRoute.withName("/"),
                                  arguments: student.matricule);
                            },
                            child: const Text("Aller à l'accueil"))
                      ],
                    ),
                  );
                },
                child: const Text('Valider'),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: mediaQuery.size.height * 0.01)),
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
            ],
          ),
        ),
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  const InfoTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.iconData,
  });

  final String title;
  final String subTitle;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return ListTile(
      leading: CircleAvatar(
        child: Icon(
          iconData,
          size: mediaQuery.size.height * 0.04,
        ),
      ),
      title: Text(
        title,
      ),
      subtitle: Text(
        subTitle,
        style: const TextStyle(
          fontStyle: FontStyle.italic,
          color: Colors.grey,
        ),
      ),
    );
  }
}
