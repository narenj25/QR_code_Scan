import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

Widget buildQrCode({
  required BuildContext context,
  required String data,
}) =>
    QrImageView(
      data: data,
      version: QrVersions.auto,
      size: MediaQuery.of(context).size.width * 0.8,
    );
