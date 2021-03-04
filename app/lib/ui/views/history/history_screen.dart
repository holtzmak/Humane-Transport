import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/history_screen_view_model.dart';
import 'package:app/ui/widgets/atr_preview_card.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'atr_display_screen.dart';

class HistoryScreen extends StatefulWidget {
  static const route = '/history';
  final NavigationService _navigationService = locator<NavigationService>();

  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  ATRPreviewCard createPreview(AnimalTransportRecord atr) => ATRPreviewCard(
      // Must have unique keys in rebuilding widget lists
      key: ObjectKey(Uuid().v4()),
      atr: atr,
      onTap: () => widget._navigationService
          .navigateTo(ATRDisplayScreen.route, arguments: atr));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History Screen'),
        automaticallyImplyLeading: false,
      ),
      body: TemplateBaseViewModel<HistoryScreenViewModel>(
          builder: (context, model, _) => GridView.builder(
                itemCount: model.animalTransportRecords.length,
                itemBuilder: (_, index) =>
                    createPreview(model.animalTransportRecords[index]),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
              )),
    );
  }
}
