import 'package:checkme_pro/providers/session_provider.dart';
import 'package:checkme_pro/screens/homepage_screen.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannedBarcodeLabel extends StatelessWidget {
  const ScannedBarcodeLabel({
    super.key,
    required this.barcodes,
  });

  final Stream<BarcodeCapture> barcodes;

  @override
  Widget build(BuildContext context) {
    SessionProvider sessionProvider = SessionProvider();
    String userMatricule =
        "20G60465"; // Voici la variable qui doit contenir la valeur du matricule garder en local
    return StreamBuilder(
      stream: barcodes,
      builder: (context, snapshot) {
        final scannedBarcodes = snapshot.data?.barcodes ?? [];

        if (scannedBarcodes.isEmpty) {
          return const Text(
            'Scan QR_Code...',
            overflow: TextOverflow.fade,
            style: TextStyle(color: Colors.white),
          );
        }

        if (scannedBarcodes.first.displayValue == userMatricule) {
          // Voici ou est effectué la comparaison entre la valeur du matricule gardé en local et celle contenu dans le QR Code
          print("Succés");
          sessionProvider.answerCallSession(matricule: userMatricule);

          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(HomepageScreen.routeName,
                arguments: userMatricule);
          }); // Rétour à la page home apres le scan du QR code si les valeurs correspondent
        }

        return Text(
          scannedBarcodes.first.displayValue ?? 'No display value.',
          overflow: TextOverflow.fade,
          style: const TextStyle(color: Colors.white),
        );
      },
    );
  }
}
