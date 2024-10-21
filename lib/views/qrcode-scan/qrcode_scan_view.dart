import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../config/assets/assets_path.dart';
import '../../widgets/cs_appbar.dart';

class QrcodeScanView extends StatefulWidget {
  const QrcodeScanView({
    required this.title,
    required this.callback,
    super.key,
  });

  final String title;
  final void Function(String?) callback;

  @override
  State<QrcodeScanView> createState() => _QrcodeScanViewState();
}

class _QrcodeScanViewState extends State<QrcodeScanView> {
  QRViewController? controller;

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    bool hasRead = false;

    controller.scannedDataStream.listen((data) {
      if (hasRead) return;
      hasRead = true;

      widget.callback(data.code);
    });
  }

  @override
  void dispose() {
    controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CsAppbar(title: widget.title),
      body: Stack(
        children: [
          Positioned.fill(
            child: QRView(
              key: GlobalKey(),
              onQRViewCreated: onQRViewCreated,
              formatsAllowed: const [BarcodeFormat.qrcode],
            ),
          ),

          Positioned.fill(child: Image.asset(AssetsPath.MASK_QRCODE)),
        ],
      ),
    );
  }
}
