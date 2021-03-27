import 'package:app/core/services/nav_service.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/widgets/utility/email_form.dart';
import 'dart:io';

class PdfScreenViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void navigateToEmailForm(File pdf) =>
      _navigationService.navigateTo(EmailForm.route, arguments: pdf);
}
