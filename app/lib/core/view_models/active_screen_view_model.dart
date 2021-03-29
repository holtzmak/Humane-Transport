import 'dart:async';
import 'dart:io';

import 'package:app/core/models/acknowledgement_info.dart';
import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/services/auth_service.dart';
import 'package:app/core/services/database/database_service.dart';
import 'package:app/core/services/dialog_service.dart';
import 'package:app/core/services/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/services/shared_preferences_service.dart';
import 'package:app/core/utilities/optional.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/common/view_state.dart';
import 'package:app/ui/views/active/atr_editing_screen.dart';
import 'package:app/ui/views/active/form_field/acknowledgement_info_form_field.dart';
import 'package:app/ui/views/history/history_screen.dart';
import 'package:app/ui/views/home_screen.dart';
import 'package:crypto/crypto.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

/// This ViewModel will only view active ATR models
class ActiveScreenViewModel extends BaseViewModel {
  final SharedPreferencesService _sharedPreferencesService =
      locator<SharedPreferencesService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DatabaseService _databaseService = locator<DatabaseService>();
  final DialogService _dialogService = locator<DialogService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  StreamSubscription<Optional<User>> _currentUserSubscription;
  StreamSubscription<List<AnimalTransportRecord>> _atrSubscription;

  final List<AnimalTransportRecord> _animalTransportRecords = [];

  List<AnimalTransportRecord> get animalTransportRecords =>
      List.unmodifiable(_animalTransportRecords);

  ActiveScreenViewModel() {
    final thisUser = _authenticationService.currentUser;
    if (thisUser.isPresent()) {
      _atrSubscription = _databaseService
          .getUpdatedActiveATRs(thisUser.get().uid)
          .listen((List<AnimalTransportRecord> atrs) {
        removeAll();
        addAll(atrs);
      });
      _currentUserSubscription = _authenticationService.currentUserChanges
          .listen((Optional<User> user) {
        // User has logged out or is no longer authenticated, lock the ViewModel
        if (!user.isPresent()) _cancelAtrSubscription();
      });
    } else {
      _dialogService.showDialog(
        title: 'Launching the active screen failed',
        description: "You are not logged in!",
      );
    }
  }

  void _cancelAtrSubscription() {
    removeAll();
    if (_atrSubscription != null) _atrSubscription.cancel();
  }

  @mustCallSuper
  void dispose() {
    _cancelAtrSubscription();
    if (_currentUserSubscription != null) _currentUserSubscription.cancel();
    super.dispose();
  }

  void addAll(List<AnimalTransportRecord> atrs) {
    _animalTransportRecords.addAll(atrs);
    notifyListeners();
  }

  void removeAll() {
    _animalTransportRecords.clear();
    notifyListeners();
  }

// May have come from Home screen or Active screen
  void navigateBack() => _navigationService.pop();

  void navigateToHomeScreen() =>
      _navigationService.navigateBackUntil(HomeScreen.route);

  void navigateToHistoryScreen() =>
      _navigationService.navigateAndReplace(HistoryScreen.route);

  void navigateToEditingScreen(AnimalTransportRecord atr) {
    _navigationService.navigateTo(ATREditingScreen.route, arguments: atr);
  }

  Future<void> startNewAtr() async {
    setState(ViewState.Busy);
    final currentUser = _authenticationService.currentUser;
    final defaultAtr = _sharedPreferencesService.getDefaultAtr();
    currentUser.isPresent()
        ? _databaseService
            .saveNewAtr(defaultAtr.isPresent()
                ? defaultAtr.get()
                : AnimalTransportRecord.empty(currentUser.get().uid))
            .then((atr) {
            setState(ViewState.Idle);
            return navigateToEditingScreen(atr);
          }).catchError((e) {
            setState(ViewState.Idle);
            _dialogService.showDialog(
              title: 'Starting a new Animal Transport Record failed',
              description: e.message,
            );
          })
        : _dialogService.showDialog(
            title: 'Starting a new Animal Transport Record failed',
            description: "You are not logged in!",
          );
  }

  Future<void> saveEditedAtr(
      AnimalTransportRecord atr, AcknowledgementInfoImages ackImages) async {
    setState(ViewState.Busy);
    return _uploadAcknowledgementImagesIfNeeded(ackImages)
        .then((AcknowledgementInfo ackInfo) =>
            _databaseService.saveUpdatedAtr(atr.withAckInfo(ackInfo)))
        .then((_) => setState(ViewState.Idle))
        .catchError((e) {
      setState(ViewState.Idle);
      _dialogService.showDialog(
        title: 'Saving the Animal Transport Record failed',
        description: e.message,
      );
    });
  }

  Future<void> deleteActiveAtr(AnimalTransportRecord atr) async {
    setState(ViewState.Busy);
    final currentUser = _authenticationService.currentUser;
    currentUser.isPresent()
        ? _databaseService
            .removeAtr(atr.identifier.atrDocumentId)
            .then((_) => _dialogService.showDialog(
                title: 'Animal Transport Record Deleted',
                description: 'This record has been deleted successfully'))
            .then((_) => setState(ViewState.Idle))
            .then((_) => navigateBack())
            .catchError((e) {
            setState(ViewState.Idle);
            _dialogService.showDialog(
                title: 'Deleting the Animal Transport Record Failed',
                description: e.message);
          })
        : _dialogService.showDialog(
            title: 'Failed to Delete', description: 'User not logged in');
  }

  Future<void> saveCompletedAtr(
      AnimalTransportRecord atr, AcknowledgementInfoImages ackImages) async {
    setState(ViewState.Busy);
    saveEditedAtr(atr.asComplete(), ackImages)
        .then((_) => _dialogService.showDialog(
            title: "Animal Transport Form Submitted",
            description:
                '${DateFormat("yyyy-MM-dd hh:mm").format(DateTime.now())}'))
        .then((_) => setState(ViewState.Idle))
        // May have come from Home screen or Active screen
        .then((_) => navigateBack())
        .catchError((e) {
      setState(ViewState.Idle);
      _dialogService.showDialog(
        title: 'Submission of the Animal Transport Record failed',
        description: e.message,
      );
    });
  }

  Future<String> _uploadOrGetExistingImageUrl(File image) async {
    // We use MD5 here not for security, but for a unique encoding of the
    // image file that can be repeated with identical images to prevent
    // file and file name duplication
    final fileName = md5.convert(image.readAsBytesSync()).toString();
    return _databaseService
        .getAtrImage(fileName)
        .catchError((_) => _databaseService.uploadAtrImage(image, fileName));
  }

  Future<AcknowledgementInfo> _uploadAcknowledgementImagesIfNeeded(
      AcknowledgementInfoImages ackImages) async {
    String shipperAck = ackImages.shipperAck;
    String transporterAck = ackImages.transporterAck;
    String receiverAck = ackImages.receiverAck;
    try {
      if (ackImages.shipperAckRecentImage != null) {
        shipperAck =
            await _uploadOrGetExistingImageUrl(ackImages.shipperAckRecentImage);
      }
      if (ackImages.transporterAckRecentImage != null) {
        transporterAck = await _uploadOrGetExistingImageUrl(
            ackImages.transporterAckRecentImage);
      }
      if (ackImages.receiverAckRecentImage != null) {
        receiverAck = await _uploadOrGetExistingImageUrl(
            ackImages.receiverAckRecentImage);
      }
      return Future.value(AcknowledgementInfo(
          shipperAck: shipperAck,
          transporterAck: transporterAck,
          receiverAck: receiverAck));
    } catch (error) {
      return Future.error(error);
    }
  }
}
