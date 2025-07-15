import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:share_plus/share_plus.dart';

class ShareHelper {
  static Future<void> shareBoard(GlobalKey boardKey) async {
    try {
      RenderRepaintBoundary boundary = boardKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      // Save to temp file and share
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/tic_tac_toe.png').writeAsBytes(pngBytes);
      await Share.shareXFiles([
        XFile(file.path)
      ], text: 'Check out my Tic Tac Toe game!');
    } catch (e) {
      // Handle error
    }
  }
}
