import 'package:app/core/services/authentication/auth_service.dart';
import 'package:app/core/services/database/database_service.dart';
import 'package:app/core/services/dialog/dialog_service.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/test/test_animal_transport_record.dart';
import 'package:app/ui/views/new/test_screens/test_screen_three.dart';

class NewScreenViewModel extends BaseViewModel {
  final DialogService _dialogService = locator<DialogService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DatabaseService _dbService = locator<DatabaseService>();

  void signOut() async {
    _authenticationService
        .signOut()
        .then((_) => _navigationService.pop())
        .catchError((error) => _dialogService.showDialog(
              title: 'Sign out failed',
              description: error.message,
            ));
  }

  void saveAtr() async {
    final dumy = await _dbService.saveNewAtr("dum-e", false);
    final dumyAtr = testAnimalTransportRecord(
        shipInfo: dumy.shipInfo,
        tranInfo: dumy.tranInfo,
        deliveryInfo: dumy.deliveryInfo,
        ackInfo: dumy.ackInfo,
        contingencyInfo: dumy.contingencyInfo,
        fwrInfo: dumy.fwrInfo,
        vehicleInfo: dumy.vehicleInfo,
        identifier: dumy.identifier);
    await _dbService.updateWholeAtr(dumyAtr);
  }

  void getAtr() async {
    final myRecs = await _dbService.getActiveRecords();
    myRecs.forEach((element) {
      print("${element.identifier.atrDocumentId}");
      print("${element.identifier.userId}");
      print("${element.shipInfo.shipperName}");
      print("${element.identifier.isComplete}");
    });
  }

  void navigateToTestScreenThree() =>
      _navigationService.navigateTo(TestScreenThree.route);

  void navigateToNewScreen() => _navigationService.pop();
}
