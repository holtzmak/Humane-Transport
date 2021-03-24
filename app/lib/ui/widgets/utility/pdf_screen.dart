import 'dart:io';
import 'dart:ui';

import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/ui/common/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'email_screen.dart';

class PDFScreen extends StatefulWidget {
  static const route = '/pdf_preview';
  final AnimalTransportRecord atr;

  PDFScreen({Key key, @required this.atr});

  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  Future<File> _pdf;

  @override
  void initState() {
    super.initState();
    _pdf = _getBuiltAndSavedPdf(widget.atr);
  }

  @override
  build(BuildContext context) {
    // TODO: Use the BusyOverlay here
    return FutureBuilder<File>(
        future: _pdf,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('Loading PDF');
            default:
              if (snapshot.hasError)
                return Text('Could not build and save PDF: ${snapshot.error}');
              else
                return PDFViewerScaffold(
                  appBar: AppBar(
                    iconTheme: IconThemeData(color: NavyBlue),
                    backgroundColor: Beige,
                    title: Text(
                      'PDF View',
                      style: TextStyle(color: NavyBlue),
                    ),
                    actions: [
                      OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EmailScreen(
                                          pdf: snapshot.requireData,
                                        )));
                          },
                          icon: Icon(Icons.mail, color: NavyBlue),
                          label: Text(
                            'Email',
                            style: TextStyle(color: NavyBlue),
                          ))
                    ],
                  ),
                  path: snapshot.data.path,
                );
          }
        });
  }

  // TODO: Give this function an object to build PDF from
  Future<File> _getBuiltAndSavedPdf(AnimalTransportRecord atr) async {
    final pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(45),
      footer: (pw.Context context) {
        return pw.Container(
            alignment: pw.Alignment.centerRight,
            margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
            child: pw.Text(
              'Page ${context.pageNumber} of ${context.pagesCount}',
            ));
      },
      build: (pw.Context context) {
        //TODO: Add Complete Atr
        return <pw.Widget>[
          pw.Header(
              level: 0,
              child: pw.Text('Animal Transport Record',
                  style: pw.TextStyle(
                      fontSize: 20, fontWeight: pw.FontWeight.bold)),
              outlineStyle: PdfOutlineStyle.italicBold),
          pw.Header(
              level: 1,
              child: pw.Text("Shipper's Information",
                  style: pw.TextStyle(fontSize: 18))),
          pw.Paragraph(
              text: widget.atr.shipInfo.toString(),
              style: pw.TextStyle(fontSize: 16)),
          pw.Header(
              level: 1,
              child: pw.Text("Transporter's Information",
                  style: pw.TextStyle(fontSize: 18))),
          pw.Paragraph(
              text: widget.atr.tranInfo.toString(),
              style: pw.TextStyle(fontSize: 16)),
          pw.Header(
              level: 1,
              child: pw.Text("Feed Water and Rest Information",
                  style: pw.TextStyle(fontSize: 18))),
          pw.Paragraph(
              text: widget.atr.fwrInfo.toString(),
              style: pw.TextStyle(fontSize: 16)),
          pw.Header(
              level: 1,
              child: pw.Text("Loading Vehicle Information",
                  style: pw.TextStyle(fontSize: 18))),
          pw.Paragraph(
              text: widget.atr.vehicleInfo.toString(),
              style: pw.TextStyle(fontSize: 16)),
          pw.Header(
              level: 1,
              child: pw.Text("Delivery Information",
                  style: pw.TextStyle(fontSize: 18))),
          pw.Paragraph(
              text: widget.atr.deliveryInfo.toString(),
              style: pw.TextStyle(fontSize: 16)),
          pw.Header(
              level: 1,
              child: pw.Text("Acknowledgements",
                  style: pw.TextStyle(fontSize: 18))),
          //TODO: Add Ack Images
          pw.Header(
              level: 1,
              child: pw.Text("Contingency Plan",
                  style: pw.TextStyle(fontSize: 18))),
          pw.Paragraph(
              text: widget.atr.contingencyInfo.toString(),
              style: pw.TextStyle(fontSize: 16)),
        ];
      },
    ));

    // TODO: Change the filename to something useful
    return Future.wait([getTemporaryDirectory(), pdf.save()]).then(
        (List values) =>
            File("${values[0].path}/${atr.identifier.atrDocumentId}.pdf")
                .writeAsBytes(values[1]));
  }
}
