import 'package:flutter/material.dart';

import './validate_account_screen.dart';

import '../widgets/custom_appbar.dart';

class CreateAccountScreen extends StatefulWidget {
  static const routeName = "/create-account";

  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _matriculeController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: customAppBar(null),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Text(
                'Créer un Compte',
                style: appTheme.textTheme.displayLarge,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: mediaQuery.size.height * 0.05),
                height: mediaQuery.size.height * 0.3,
                child: Image.asset(
                  'assets/images/createaccount.png',
                  fit: BoxFit.cover,
                ),
              ),
              TextField(
                maxLength: 8,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  constraints:
                      BoxConstraints(maxWidth: mediaQuery.size.width * 0.8),
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
                onSubmitted: (_) {},
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(ValidateAccountScreen.routeName);
                  },
                  child: const Text('Poursuivre'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
