import 'package:app/core/view_models/history_screen_view_model.dart';
import 'package:app/ui/views/home/home_screen.dart';
import 'package:app/ui/widgets/utility/pdf_screen.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  static const route = '${HomeScreen.route}/history';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: TemplateBaseViewModel<HistoryScreenViewModel>(
        builder: (context, model, _) => ListView.builder(
          itemCount: model.animalTransportPreviews.length,
          itemBuilder: (context, index) => model.animalTransportPreviews[index],
        ),
      ),
      // TODO: Make PDF from selected ATRPreview, need to make cards selectable
      floatingActionButton: FloatingActionButton(
        /* The navigator for the floating action button is not the same as our app navigator
           https://stackoverflow.com/questions/60872579/navigating-inside-a-floating-action-button\
         */
        onPressed: () => Navigator.of(context).pushNamed(PDFScreen.route),
        child: Icon(Icons.save),
      ),
    );
  }
}
