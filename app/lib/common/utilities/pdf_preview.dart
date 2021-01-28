import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfPreview extends StatefulWidget {
  static const route = '/pdf_preview';
  @override
  _PdfPreviewState createState() => _PdfPreviewState();
}

class _PdfPreviewState extends State<PdfPreview> {
  Future<File> _pdf;

  @override
  void initState() {
    super.initState();
    _pdf = _getBuiltAndSavedPdf();
  }

  @override
  build(BuildContext context) {
    return FutureBuilder<File>(
        future: _pdf,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              // TODO: Replace this with loading screen
              return Text('Loading PDF');
            default:
              if (snapshot.hasError)
                return Text('Could not build and save PDF: ${snapshot.error}');
              else
                return PDFViewerScaffold(
                  appBar: AppBar(
                    title: Text('Example PDF'),
                  ),
                  path: snapshot.data.path,
                );
          }
        });
  }

  // TODO: Give this function an object to build PDF from
  Future<File> _getBuiltAndSavedPdf() async {
    final pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(34),
      build: (pw.Context context) {
        /* We will be calling API and fetching data from the database here.
        Now just adding random text for experimentation purpose. Once we have
        database/API set up, will experimenting on fetching data */
        return <pw.Widget>[
          pw.Header(level: 0, child: pw.Text('Shipper Information')),
          pw.Paragraph(text: 'Some Information'),
          pw.Paragraph(text: 'Some Information'),
          pw.Header(level: 1, child: pw.Text("Travel Information")),
          pw.Paragraph(text: 'Some Text 1'),
          pw.Paragraph(text: 'Some Text 2')
        ];
      },
    ));

    // TODO: Change the filename to something useful
    return Future.wait([getTemporaryDirectory(), pdf.save()]).then(
        (List values) =>
            File("${values[0].path}/example.pdf").writeAsBytes(values[1]));
  }
}
