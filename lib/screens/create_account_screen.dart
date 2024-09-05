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
                onSubmitted: (_) => _onMatriculeSubmited(),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () => _onMatriculeSubmited(),
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
