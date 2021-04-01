import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/view_models/history_screen_view_model.dart';
import 'package:app/ui/common/style.dart';
import 'package:app/ui/widgets/atr_preview_card.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

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
              appBar: appBarInner('Travel History'),
              backgroundColor: Beige,
              bottomNavigationBar: BottomNavigationBar(
                  unselectedLabelStyle: TextStyle(fontSize: SmallTextSize),
                  selectedItemColor: NavyBlue,
                  unselectedItemColor: NavyBlue,
                  backgroundColor: SlateGrey,
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
                        color: NavyBlue,
                      ),
                      label: "Back",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.directions_car,
                        color: NavyBlue,
                      ),
                      label: "Active",
                    ),
                  ]),
              body: Column(children: [
                Card(
                    child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Search"),
                          onFieldSubmitted: (String searchTerm) =>
                              model.filterBySearchTerm(searchTerm),
                        ))),
                model.animalTransportRecords.isEmpty
                    ? Center(
                        child: Container(
                          margin: EdgeInsets.all(50.0),
                          child: Card(
                            child: ListTile(
                              title:
                                  Text("No completed Animal Transport Records"),
                              subtitle: Text(
                                  "Submitted completed records will appear here"),
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: GridView.builder(
                        itemCount: model.filteredAnimalTransportRecords.length,
                        itemBuilder: (context, index) => createPreview(
                            model, model.filteredAnimalTransportRecords[index]),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 9 / 8,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                      )),
              ]),
            ));
  }
}
