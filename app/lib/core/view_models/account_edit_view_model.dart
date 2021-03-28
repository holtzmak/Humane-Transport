import 'dart:io';

import 'package:app/core/models/transporter.dart';
import 'package:app/core/services/database/database_service.dart';
import 'package:app/core/services/dialog_service.dart';
import 'package:app/core/services/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/common/view_state.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AccountEditViewModel extends BaseViewModel {
  final DatabaseService _databaseService = locator<DatabaseService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  final _picker = ImagePicker();

  Transporter _account;
  File _selectedImage;

  File get selectedImage => _selectedImage;
  String _imageUrl;

  String get imageUrl => _imageUrl;

  Future<void> selectImage() async {
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      var tempImage = await _picker.getImage(source: ImageSource.gallery);

      if (tempImage != null) {
        _selectedImage = File(tempImage.path);
        notifyListeners();
      }
    } else {
      _dialogService.showDialog(
        title: 'Access Request',
        description: 'Permission to access gallery denied',
      );
    }
  }

  Future<void> setImageUrl() async => _imageUrl = _selectedImage != null
      ? await _databaseService.uploadAvatarImage(
          _selectedImage, _account.userId)
      : _account.displayImageUrl;

  Future<void> saveTransporterAccount({
    @required String firstName,
    @required String lastName,
    @required String userEmailAddress,
    @required String userPhoneNumber,
  }) async {
    setState(ViewState.Busy);
    setImageUrl().then((value) {
      var updateTransporterAccount = Transporter(
        firstName: firstName,
        isAdmin: _account.isAdmin,
        lastName: lastName,
        userEmailAddress: userEmailAddress,
        userId: _account.userId,
        userPhoneNumber: userPhoneNumber,
        displayImageUrl: _imageUrl,
      );
      _databaseService.updateTransporter(updateTransporterAccount);
    }).then((_) => _dialogService
            .showDialog(
                title: 'Transporter Account',
                description: 'Changes has been saved')
            .then((_) => setState(ViewState.Idle))
            .then((_) => _navigationService.pop())
            .catchError((e) {
          setState(ViewState.Idle);
          _dialogService.showDialog(
            title: 'Saving changes to your account failed',
            description: e.message,
          );
        }));
  }

  void setTransporterAccount(Transporter account) {
    _account = account;
    notifyListeners();
  }

  void navigateToAccount() => _navigationService.pop();
}
