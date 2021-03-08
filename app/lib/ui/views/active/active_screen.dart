import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/view_models/active_screen_view_model.dart';
import 'package:app/ui/widgets/atr_preview_card.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ActiveScreen extends StatefulWidget {
  static const route = '/active';

  _ActiveScreenState createState() => _ActiveScreenState();
}

class _ActiveScreenState extends State<ActiveScreen> {
  ATRPreviewCard createPreview(
          ActiveScreenViewModel model, AnimalTransportRecord atr) =>
      ATRPreviewCard(
          // Must have unique keys in rebuilding widget lists
          key: ObjectKey(Uuid().v4()),
          atr: atr,
          onTap: () => model.navigateToEditingScreen(atr));

  @override
  Widget build(BuildContext context) {
    return TemplateBaseViewModel<ActiveScreenViewModel>(
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          title: Text('Active Screen'),
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios),
            onPressed: model.navigateToHomeScreen,
          ),
        ),
        body: model.animalTransportRecords.isEmpty
            ? ListTile(
                title: Text("No active Animal Transport Records"),
                subtitle: Text("You can add some using the \"New\" button"))
            : GridView.builder(
                itemCount: model.animalTransportRecords.length,
                itemBuilder: (context, index) =>
                    createPreview(model, model.animalTransportRecords[index]),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
              ),
      ),
    );
  }
}
