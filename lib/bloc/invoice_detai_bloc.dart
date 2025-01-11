// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tmsmobile/extension/extension.dart';
import 'package:tmsmobile/utils/colors.dart';
import 'package:tmsmobile/utils/dimens.dart';

class InvoiceDetaiBloc extends ChangeNotifier {
  bool isDownloadLoading = false;
  BuildContext? context;
  bool isDisposed = false;

  InvoiceDetaiBloc({this.context}) {
    context = context;
    checkAndRequestStoragePermission();
  }

  Future<void> savePdf(GlobalKey contentKey) async {
    try {
      _showDownloading();

      RenderRepaintBoundary boundary = contentKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 4.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      final imageBytes = byteData!.buffer.asUint8List();

      // Create PDF
      final pdf = pw.Document();
      final pdfImage = pw.MemoryImage(imageBytes);
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.undefined,
          build: (pw.Context context) => pw.Center(
            child: pw.Image(pdfImage),
          ),
        ),
      );
      _hideDownloading();
      // Get file path
      var date = DateTime.now();
      final directory = Platform.isAndroid
          ? await _getAndroidDirectory()
          : await _getCustomDirectory();
      final file = File('$directory/invoice_${date.microsecond}.pdf');
      await file.writeAsBytes(await pdf.save());

      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
            duration: Duration(seconds: 1),
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
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
            backgroundColor: kPrimaryColor,
            content: Text(
              'Error generating PDF: $e',
              style: TextStyle(color: kWhiteColor, fontWeight: FontWeight.bold),
            )),
      );
    }
  }

  _showDownloading() {
    isDownloadLoading = true;
    _notifySafely();
  }

  _hideDownloading() {
    isDownloadLoading = false;
    _notifySafely();
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }

  checkAndRequestStoragePermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  Future<String> _getCustomDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    final customDir = Directory('${directory.path}/TMSMobile');

    if (!(await customDir.exists())) {
      await customDir.create(recursive: true);
    }
    return customDir.path;
  }

  Future<String> _getAndroidDirectory() async {
    
    final customDir = Directory('/storage/emulated/0/Download/TMSMobile');

    if (!(await customDir.exists())) {
      await customDir.create(recursive: true);
    }
    return customDir.path;
  }
}
