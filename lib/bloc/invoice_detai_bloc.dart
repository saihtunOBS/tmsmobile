// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';

class InvoiceDetaiBloc extends ChangeNotifier {
  double progress = 0.0;
  bool isDownloadLoading = false;

  //save pdf
  Future<void> savePdf(BuildContext context, GlobalKey contentKey) async {
    try {
      isDownloadLoading = true;
      progress = 0.0;
      notifyListeners();
      // Capture the widget as an image
      RenderRepaintBoundary boundary = contentKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 1.0);

      // Update progress
      progress = 0.3;
      notifyListeners();

      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      final imageBytes = byteData!.buffer.asUint8List();

      // Create PDF
      final pdf = pw.Document();
      final pdfImage = pw.MemoryImage(imageBytes);
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Center(
            child: pw.Image(pdfImage),
          ),
        ),
      );

      progress = 0.6;
      notifyListeners();

      progress = 0.9;
      notifyListeners();

      // Get file path
      final directory = await getDownloadsDirectory();
      final file = File('${directory?.path}/invoice.pdf');
      await file.writeAsBytes(await pdf.save());

      // Update progress
      progress = 1.0;
      isDownloadLoading = false;
      notifyListeners();
      // Notify user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: kDarkBlueColor,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'PDF saved successfully!',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: kTextRegular),
                ),
                20.hGap,
                InkWell(
                  onTap: () async {
                    await OpenFile.open(file.path);
                  },
                  child: Container(
                    height: 28,
                    width: 100,
                    decoration: BoxDecoration(
                        color: kBackgroundColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        'Open',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            )),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating PDF: $e')),
      );
    }
  }
}
