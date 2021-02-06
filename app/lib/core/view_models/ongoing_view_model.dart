import 'package:app/core/models/test_history.dart';
import 'package:app/core/services/dialogs/dialogs_service.dart';
import 'package:app/core/services/firestore/firestore_service.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/views/add_history/add_history.dart';

class OngoingViewModel extends BaseViewModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  List<HistoryRecord> _history = [];
  List<HistoryRecord> get histories => _history;

  void listenToTavelHistoryChanges() {
    setBusy(true);

    _firestoreService
        .getHistoryRecordsInRealTime(currentUser.userId)
        .listen((snapshotHistory) {
      List<HistoryRecord> updatedHistory = snapshotHistory;
      if (updatedHistory != null && updatedHistory.length > 0) {
        _history = updatedHistory;
        notifyListeners();
      } else {
        print('Hello');
      }

      setBusy(false);
    });
  }

  // This needs to be Future as this rebuild the widget when new info added
  Future navigateToCreateView() async {
    await _navigationService.navigateTo(AddHistory.route);
  }

  void editHistoryTravel(int index) {
    _navigationService.navigateTo(AddHistory.route, arguments: _history[index]);
  }

  Future deletePost(int index) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Hold Up!',
      description: 'Are you sure you want to delete this record?',
      confirmationText: 'Yes',
      cancelText: 'No',
    );

    if (dialogResponse.confirmed) {
      setBusy(true);
      await _firestoreService.deletePost(
          _history[index].documentId, currentUser.userId);
      setBusy(false);
    }
  }
}
