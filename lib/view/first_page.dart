// ignore_for_file: file_names
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get_sim_number/service/service.dart';
import 'package:get_sim_number/utils/get_number.dart';
import 'package:get_sim_number/view/second_page.dart';

class BarcodeScanner extends StatefulWidget {
  const BarcodeScanner({super.key});

  @override
  State<BarcodeScanner> createState() => _BarcodeScannerState();
}

String? qrResult;

class _BarcodeScannerState extends State<BarcodeScanner> {
  Future<void> scanQr() async {
    String? barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666",
      "Cancel",
      true,
      ScanMode.QR,
    );
    if (!mounted) {
      return;
    }
    if (barcodeScanRes != "-1") {
      // A valid QR code was scanned
      setState(() {
        qrResult = barcodeScanRes;
      });
    } else {
      // User cancelled the scan or there was an error
      // Handle this case as needed
    }
  }

  Future<void> scanQrStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
      "#ff6666",
      "Cancel",
      true,
      ScanMode.QR,
    )?.listen((event) {
      debugPrint(event);
    });
  }

  // Barcode? barCode;
  // QRViewController? qrController;
  // final qrKey = GlobalKey(debugLabel: "QR");
  // Widget buildQrView(BuildContext context) => QRView(
  //       cameraFacing: CameraFacing.back,
  //       key: qrKey,
  //       onQRViewCreated: onQRViewCreated,
  //       overlay: QrScannerOverlayShape(
  //           borderWidth: 10,
  //           borderRadius: 10,
  //           cutOutSize: MediaQuery.of(context).size.width * 0.80),
  //     );
  // void onQRViewCreated(QRViewController controller) {
  //   setState(() {
  //     qrController = controller;
  //   });
  //   qrController?.scannedDataStream.listen((event) {
  //     barCode = event;
  //   });
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   qrController?.dispose();
  // }

  // @override
  // void reassemble() async {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     await qrController!.pauseCamera();
  //   } else {
  //     qrController!.resumeCamera();
  //   }
  // }
  String? mobileNumber;
  GetMobileNumber getmobileNumber = GetMobileNumber();
  void claimcoupon() async {
    String? mobNum = await getmobileNumber.getMobileNumberFromMobile();
    setState(() {
      mobileNumber = mobNum;
    });
    // ignore: use_build_context_synchronously
    await QRservice().qrFunction(
      mobileNumber: mobNum,
      urlforapi: qrResult,
      context: context,
    );
    setState(() {
      qrResult = null;
    });
  }

  @override
  void initState() {
    super.initState();
    getmobNumber();
  }

  void getmobNumber() async {
    String? mobNum = await getmobileNumber.getMobileNumberFromMobile();
    setState(() {
      log(mobNum.toString());
      mobileNumber = mobNum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 229, 229),
      appBar: AppBar(
        title: const Text("Idly Vada Sambar"),
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CachedNetworkImage(
            //   imageUrl: "https://ivsveg.com/assets/images/logo/logo-dark.png",
            // ),
            Image.asset("lib/assets/idly_vada_sambar1.png"),
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 100,
              width: 150,
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blue),
                ),
                onPressed: scanQr,
                child: const FittedBox(
                  child: Row(
                    children: [
                      Icon(
                        Icons.qr_code_scanner,
                        size: 50,
                      ),
                      Text(
                        "Scan QR",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Visibility(
              visible: qrResult != null,
              child: SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  onPressed: claimcoupon,
                  child: const Text("Claim Coupon"),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: 100,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowCoupon(mobileNumber: mobileNumber),
                ));
          },
          child: const Center(
              child: Text(
            "Coupons",
            textAlign: TextAlign.center,
          )),
        ),
      ),
    );
  }
}
