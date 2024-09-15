import 'package:flutter/material.dart';

Future errorDialog(BuildContext ctx, String message) => showDialog(
      context: ctx,
      builder: (ctx) => AlertDialog(
        title: const Icon(
          Icons.warning,
          color: Colors.red,
          size: 50,
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Close'),
          )
        ],
      ),
    );
