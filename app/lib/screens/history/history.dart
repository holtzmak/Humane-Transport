import 'dart:io';

import 'package:app/screens/history/pdf_preview.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class TravelHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Building.... Travel History page');
    return Scaffold(
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Card(
            color: index % 2 == 0 ? Colors.grey[300] : null,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('Travel History ${index + 1}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            buildPdf();
            savePdf();
            final output = await getTemporaryDirectory();
            String fullPath = ("${output.path}/example.pdf");

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PdfPreview(
                          path: fullPath,
                        )));
          } on HttpException catch (err) {
            print('Error: $err');
          }
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
