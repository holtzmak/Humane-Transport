import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/active_screen_view_model.dart';
import 'package:app/ui/widgets/atr_preview_card.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'atr_editing_screen.dart';

class ActiveScreen extends StatefulWidget {
  static const route = '/active';
  final NavigationService _navigationService = locator<NavigationService>();

  _ActiveScreenState createState() => _ActiveScreenState();
}

class _ActiveScreenState extends State<ActiveScreen> {
  ATRPreviewCard createPreview(AnimalTransportRecord atr) => ATRPreviewCard(
      // Must have unique keys in rebuilding widget lists
      key: ObjectKey(Uuid().v4()),
      atr: atr,
      onTap: () => widget._navigationService
          .navigateTo(ATREditingScreen.route, arguments: atr));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Active Screen'),
        automaticallyImplyLeading: false,
      ),
      body: TemplateBaseViewModel<ActiveScreenViewModel>(
        builder: (context, model, _) => ListView.builder(
            itemCount: model.animalTransportRecords.length,
            itemBuilder: (context, index) =>
                createPreview(model.animalTransportRecords[index])),
      ),
    );
  }
}
