import 'package:flutter/material.dart';

import './validate_account_screen.dart';

import '../widgets/custom_appbar.dart';
import '../widgets/error_dialog.dart';

import '../providers/student_provider.dart';

class CreateAccountScreen extends StatefulWidget {
  static const routeName = "/create-account";

  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _matriculeController = TextEditingController();
  final _scrollController = ScrollController();
  var _isLoading = false;

  void _onMatriculeSubmited() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final student = await StudentProvider()
          .fetchStudentByMatricule(_matriculeController.text);
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        Navigator.of(context)
            .pushNamed(ValidateAccountScreen.routeName, arguments: student);
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        await errorDialog(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: customAppBar("Créer un Compte"),
      body: Center(
        child: SizedBox(
          height: double.infinity,
          width: mediaQuery.size.width * 0.9,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(
                      vertical: mediaQuery.size.height * 0.05),
                  height: mediaQuery.size.height * 0.2,
                  child: Image.asset(
                    'assets/images/createaccount.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  'Bienvenue 👋🏾',
                  style: TextStyle(
                      fontSize: mediaQuery.size.width * 0.13,
                      fontWeight: FontWeight.bold),
                ),
                Row(children: [
                  Text(
                    "Dans ",
                    style: TextStyle(
                        fontSize: mediaQuery.size.width * 0.1,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Check Me',
                    style: appTheme.textTheme.displayLarge,
                  )
                ]),
                const Text(
                  'Veuillez vous enregistrer pour continuer',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: mediaQuery.size.height * 0.03,
                ),
                TextField(
                  maxLength: 8,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: appTheme.colorScheme.onPrimary,
                        width: 2.0,
                        style: BorderStyle.solid, // Add border radius here
                      ),
                    ),
                    labelText: 'Veuillez saisir votre matricule',
                    //errorText: 'Wrong matricule',
                  ),
                  controller: _matriculeController,
                  onChanged: (_) {
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 1),
                      curve: Curves.linear,
                    );
                  },
                  onSubmitted: (_) => _onMatriculeSubmited(),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 5),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () => _onMatriculeSubmited(),
                          child: const Text(
                            'Continuer',
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
