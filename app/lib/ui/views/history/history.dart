import 'package:app/core/utilities/pdf_preview.dart';
import 'package:app/core/view_models/atr_pre_view_model.dart';
import 'package:app/ui/views/base_view.dart';
import 'package:flutter/material.dart';

class TravelHistory extends StatelessWidget {
  static const route = '/history';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: BaseView<AnimalTransportRecordPreViewModel>(
        builder: (context, model, _) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: model.animalTransportPreviews,
        ),
      ),
      // TODO: Make PDF from selected ATRPreview, need to make cards selectable
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(PdfPreview.route),
        child: Icon(Icons.save),
      ),
    );
  }
}
