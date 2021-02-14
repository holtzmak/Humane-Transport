import 'package:app/core/view_models/complete_atr_preview_model.dart';
import 'package:app/ui/widgets/utility/pdf_screen.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  static const route = '/history';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: TemplateBaseViewModel<CompleteATRPreviewModel>(
        builder: (context, model, _) => ListView.builder(
          itemCount: model.animalTransportPreviews.length,
          itemBuilder: (context, index) => model.animalTransportPreviews[index],
        ),
      ),
      // TODO: Make PDF from selected ATRPreview, need to make cards selectable
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(PDFScreen.route),
        child: Icon(Icons.save),
      ),
    );
  }
}
