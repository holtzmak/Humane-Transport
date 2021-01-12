import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfPreview extends StatelessWidget {
  final String path;

  PdfPreview({this.path});

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      appBar: AppBar(
        title: Text('Back to Home'),
      ),
      path: path,
    );
  }
}

//Create a blank document
final pdf = pw.Document();
//add data into the pdf file
buildPdf() {
  pdf.addPage(pw.MultiPage(
    pageFormat: PdfPageFormat.a4,
    margin: pw.EdgeInsets.all(34),
    build: (pw.Context context) {
      return <pw.Widget>[
        /*
              We will be calling API and fetching data from the database here.
              Now just adding random text for experimentation purpose. Once we have database/API set up, will
              experimenting on fetching data
              */
        pw.Header(level: 0, child: pw.Text('Shipper Information')),
        pw.Paragraph(text: 'Some Information'),
        pw.Paragraph(text: 'Some Information'),
        pw.Header(level: 1, child: pw.Text("Travel Information")),
        pw.Paragraph(text: 'Some Text 1'),
        pw.Paragraph(text: 'Some Text 2')
      ];
    },
  ));
}

Future savePdf() async {
  try {
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/example.pdf");
    file.writeAsBytesSync(await pdf.save());
  } on HttpException catch (err) {
    print('Error: $err');
  }
}
