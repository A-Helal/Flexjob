import 'dart:async';
import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flexiJobs/core/utils/log_utils.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

@RoutePage()
class QrScannerWidget extends StatefulWidget {
  const QrScannerWidget({super.key});

  @override
  State<QrScannerWidget> createState() => _QrScannerWidgetState();
}

class _QrScannerWidgetState extends State<QrScannerWidget> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  StreamSubscription<Barcode>? _scanSubscription;

  @override
  void initState() {
    super.initState();
  }

  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     controller?.pauseCamera();
  //   } else if (Platform.isIOS) {
  //     controller?.resumeCamera();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double scanArea =
        (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 280.w : 300.w;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Palette.primaryColor, borderRadius: 10, borderLength: 50, borderWidth: 8, cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    _scanSubscription = controller.scannedDataStream.listen((Barcode scanData) {
      if (scanData.code != null) {
        try {
          String decodedString = utf8.decode(base64.decode(scanData.code!));
          String id = json.decode(decodedString)["id"];

          controller.pauseCamera();
          _scanSubscription?.cancel(); // prevent further calls
          CustomMainRouter.pop(result: id);
        } catch (e) {
          Log.e('Error decoding QR: $e');
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
