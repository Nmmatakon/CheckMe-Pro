import 'package:flutter/material.dart';

import './create_account_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("CheckMe Pro"),
        centerTitle: true,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Spacer(),
              SizedBox(
                height:
                    (mediaQuery.size.height - AppBar().preferredSize.height) *
                        0.2,
                child: Image.asset(
                  'assets/images/empreinte.png',
                  fit: BoxFit.cover,
                ),
              ),
              const Spacer(),
              // this is the container containing check me
              const Text(
                'Check',
                style: TextStyle(
                  fontSize: 50,
                  color: Color.fromARGB(221, 52, 50, 50),
                ),
              ),
              const Text(
                'ME',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  color: Colors.lightBlue,
                ),
              ),
              const Spacer(),
              // this is the welcome text and pursue button
              const Text(
                'Bienvenue cher étudiant!',
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              const Spacer(),
              ElevatedButton(
                child: const Text('Poursuivre'),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(
                    CreateAccountScreen.routeName,
                  );
                },
              ),
              const Spacer(),
              const Text(
                '@uiecc2024',
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ]),
      ),
    );
  }
}
