import 'dart:async';

import 'package:checkme_pro/providers/session_provider.dart';
import 'package:checkme_pro/screens/homepage_screen.dart';
import 'package:checkme_pro/widgets/scan_error_widget.dart';
import 'package:checkme_pro/widgets/sccanner_buttons_widget.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodeScanScreen extends StatefulWidget {
  static const routeName = "/qrCodeScanScreen";

  const QrCodeScanScreen({super.key});

  @override
  State<QrCodeScanScreen> createState() => _QrCodeScanScreenState();
}

class _QrCodeScanScreenState extends State<QrCodeScanScreen>
    with WidgetsBindingObserver {
  final MobileScannerController controller = MobileScannerController(
    autoStart: false,
    torchEnabled: false,
    useNewCameraSelector: true,
  );
  SessionProvider sessionProvider = SessionProvider();

  Barcode? _barcode;
  StreamSubscription<Object?>? _subscription;
  String userMatricule =
      "M1"; // Voici la variable qui doit contenir la valeur du matricule garder en local

  Widget _buildBarcode(Barcode? value) {
    if (value == null) {
      return const Text(
        'Scanning in progress...',
        overflow: TextOverflow.fade,
        style: TextStyle(color: Colors.white),
      );
    }
    print(value.displayValue);
    if (userMatricule == value.displayValue) {
      // Voici ou est effectué la comparaison entre la valeur du matricule gardé en local et celle contenu dans le QR Code
      print("success");
      sessionProvider.answerCallSession(matricule: userMatricule);
      // Navigator.of(context).pushReplacementNamed(HomepageScreen.routeName);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed(HomepageScreen.routeName);
      });
    }
    return const Text(
      // value.displayValue ?? 'No display value.',
      "Scan performs",
      overflow: TextOverflow.fade,
      style: TextStyle(color: Colors.white),
    );
  }

  void _handleBarcode(BarcodeCapture barcodes) {
    if (mounted) {
      setState(() {
        _barcode = barcodes.barcodes.firstOrNull;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _subscription = controller.barcodes.listen(_handleBarcode);

    unawaited(controller.start());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    userMatricule = ModalRoute.of(context)?.settings.arguments as String;
    if (!controller.value.isInitialized) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        _subscription = controller.barcodes.listen(_handleBarcode);

        unawaited(controller.start());
      case AppLifecycleState.inactive:
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(controller.stop());
    }
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_subscription?.cancel());
    _subscription = null;
    super.dispose();
    await controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CheckMe Scanner')),
      // backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            errorBuilder: (context, error, child) {
              return ScannerErrorWidget(error: error);
            },
            fit: BoxFit.contain,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 100,
              color: Colors.black.withOpacity(0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ToggleFlashlightButton(controller: controller),
                  // StartStopMobileScannerButton(controller: controller),
                  _buildBarcode(_barcode),
                  SwitchCameraButton(controller: controller),
                  // AnalyzeImageFromGalleryButton(controller: controller),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
