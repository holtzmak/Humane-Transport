import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/view_models/history_screen_view_model.dart';
import 'package:app/ui/widgets/atr_preview_card.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:app/ui/common/style.dart';

class HistoryScreen extends StatefulWidget {
  static const route = '/history';

  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  ATRPreviewCard createPreview(
          HistoryScreenViewModel model, AnimalTransportRecord atr) =>
      ATRPreviewCard(
          // Must have unique keys in rebuilding widget lists
          key: ObjectKey(Uuid().v4()),
          atr: atr,
          onTap: () => model.navigateToDisplayScreen(atr));

  @override
  Widget build(BuildContext context) {
    return TemplateBaseViewModel<HistoryScreenViewModel>(
      builder: (context, model, _) => Scaffold(
          appBar: appBar('Travel History'),
          backgroundColor: homeBackground,
          bottomNavigationBar: BottomNavigationBar(
              unselectedLabelStyle: TextStyle(color: buttonColor),
              backgroundColor: bottomNavBarColor,
              onTap: (int item) async {
                switch (item) {
                  case 0:
                    return model.navigateToHomeScreen();
                  case 1:
                    return model.navigateToActiveScreen();
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
                    Icons.directions_car,
                    color: buttonColor,
                  ),
                  label: "Active",
                ),
              ]),
          body: model.animalTransportRecords.isEmpty
              ? ListTile(
                  title: Text("No completed Animal Transport Records"),
                  subtitle:
                      Text("Submitted completed records will appear here"))
              : GridView.builder(
                  itemCount: model.animalTransportRecords.length,
                  itemBuilder: (_, index) =>
                      createPreview(model, model.animalTransportRecords[index]),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                )),
    );
  }
}
