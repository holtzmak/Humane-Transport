import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/view_models/active_screen_view_model.dart';
import 'package:app/ui/widgets/atr_preview_card.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:app/ui/common/style.dart';

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
        backgroundColor: homeBackground,
        appBar: appBar('Active Forms'),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: bottomNavBarColor,
            onTap: (int item) async {
              switch (item) {
                case 0:
                  return model.navigateToHomeScreen();
                case 1:
                  return model.navigateToHistoryScreen();
                case 2:
                  return model.startNewAtr();
              }
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.arrow_back,
                  color: buttonColor,
                ),
                label: "Back",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.access_time,
                  color: buttonColor,
                ),
                label: "History",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_circle,
                  color: buttonColor,
                ),
                label: "New Form",
              )
            ]),
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
