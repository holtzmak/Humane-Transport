import 'package:app/core/view_models/active_atr_preview_model.dart';
import 'package:app/ui/views/home/home_screen.dart';
import 'package:flutter/material.dart';

import '../../widgets/utility/template_base_view_model.dart';

class ActiveScreen extends StatelessWidget {
  static const route = '${HomeScreen.route}/active';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: TemplateBaseViewModel<ActiveATRPreviewModel>(
        builder: (context, model, _) => ListView.builder(
          itemCount: model.animalTransportPreviews.length,
          itemBuilder: (context, index) => model.animalTransportPreviews[index],
        ),
      ),
    );
  }
}
