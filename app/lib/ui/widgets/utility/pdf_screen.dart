import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/view_models/history_screen_view_model.dart';
import 'package:app/ui/common/style.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:network_image_to_byte/network_image_to_byte.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PDFScreen extends StatefulWidget {
  static const route = '/pdfScreen';
  final AnimalTransportRecord atr;

  PDFScreen({Key key, @required this.atr});

  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  Future<PDFDocument> document;
  Future<File> file;

  @override
  void initState() {
    file = _getBuiltAndSavedPdf(widget.atr);
    document = file.then((File file) => PDFDocument.fromFile(file));
    super.initState();
  }

  @override
  build(BuildContext context) {
    return FutureBuilder<List>(
        future: Future.wait([file, document]),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Container(
                  color: Beige,
                  child: Stack(
                    alignment: FractionalOffset.center,
                    children: <Widget>[
                      new Container(
                        child: new CircularProgressIndicator(
                          backgroundColor: NavyBlue,
                        ),
                      ),
                    ],
                  ));
            default:
              if (snapshot.hasError) {
                return Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: Text(
                      'Could not build and save PDF: ${snapshot.error}',
                      style: TitleTextStyle,
                    ));
              } else {
                return TemplateBaseViewModel<HistoryScreenViewModel>(
                    builder: (context, model, child) => Scaffold(
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
                                    model.navigateToEmailForm(snapshot.data[0]);
                                  },
                                  icon: Icon(Icons.mail, color: NavyBlue),
                                  label: Text(
                                    'Email',
                                    style: TextStyle(color: NavyBlue),
                                  ))
                            ],
                          ),
                          body: PDFViewer(
                            document: snapshot.data[1],
                            zoomSteps: 1,
                            scrollDirection: Axis.vertical,
                          ),
                        ));
              }
          }
        });
  }

  Future<File> _getBuiltAndSavedPdf(AnimalTransportRecord atr) async {
    final pdf = pw.Document();
    pw.MemoryImage tranImage;
    pw.MemoryImage shipperImage;
    pw.MemoryImage receiverImage;
    try {
      final tranAckImage =
          pw.MemoryImage(await networkImageToByte(atr.ackInfo.transporterAck));
      setState(() {
        tranImage = tranAckImage;
      });
    } catch (e) {
      return Future.error(
          "Could not load transporter's acknowledgment receipt");
    }
    try {
      final shipperAckImage =
          pw.MemoryImage(await networkImageToByte(atr.ackInfo.shipperAck));
      setState(() {
        shipperImage = shipperAckImage;
      });
    } catch (e) {
      return Future.error("Could not load shipper's acknowledgment receipt");
    }
    try {
      final receiverAckImage =
          pw.MemoryImage(await networkImageToByte(atr.ackInfo.receiverAck));
      setState(() {
        receiverImage = receiverAckImage;
      });
    } catch (e) {
      return Future.error("Could not load receiver's acknowledgment receipt");
    }
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
          pw.Text("Transporter's Acknowledgment"),
          pw.SizedBox(
            child: pw.Image(tranImage),
          ),
          pw.Padding(padding: pw.EdgeInsets.all(20)),
          pw.Text("Shipper's Acknowledgment"),
          pw.SizedBox(
            child: pw.Image(shipperImage),
          ),
          pw.Padding(padding: pw.EdgeInsets.all(20)),
          pw.Text("Receiver's Acknowledgment"),
          pw.SizedBox(
            child: pw.Image(receiverImage),
          ),
          pw.Padding(padding: pw.EdgeInsets.all(25)),
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

    return Future.wait(
        [getTemporaryDirectory(), pdf.save()]).then((List values) => File(
            "${values[0].path}/${atr.deliveryInfo.recInfo.destinationLocationName}${atr.deliveryInfo.arrivalDateAndTime}${atr.identifier.atrDocumentId}.pdf")
        .writeAsBytes(values[1]));
  }
}
