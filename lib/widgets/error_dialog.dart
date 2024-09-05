import 'package:flutter/material.dart';

Future errorDialog(BuildContext ctx) => showDialog(
      context: ctx,
      builder: (ctx) => AlertDialog(
        title: const Icon(
          Icons.warning,
          color: Colors.red,
          size: 50,
        ),
        content: const Text(
            'Vérifiez votre connexion à internet ou votre matricule'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Close'),
          )
        ],
      ),
    );
