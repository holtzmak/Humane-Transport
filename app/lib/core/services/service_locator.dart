import 'package:app/core/services/database/database_service.dart';
import 'package:app/core/services/dialog/dialog_service.dart';
import 'package:app/core/view_models/active_screen_view_model.dart';
import 'package:app/core/view_models/history_screen_view_model.dart';
import 'package:app/core/view_models/nav_view_model.dart';
import 'package:app/core/view_models/new_screen_view_model.dart';
import 'package:app/core/view_models/sign_in_view_model.dart';
import 'package:app/core/view_models/welcome_screen_view_model.dart';
import 'package:get_it/get_it.dart';

import 'authentication/auth_service.dart';
import 'navigation/nav_service.dart';

final locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton<AuthenticationService>(
      () => AuthenticationService());
  locator.registerLazySingleton<DatabaseService>(() => DatabaseService());
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<DialogService>(() => DialogService());

  locator
      .registerFactory<WelcomeScreenViewModel>(() => WelcomeScreenViewModel());
  locator.registerFactory<SignInViewModel>(() => SignInViewModel());
  locator.registerFactory<NewScreenViewModel>(() => NewScreenViewModel());
  locator.registerFactory<NavigationViewModel>(() => NavigationViewModel());
  locator
      .registerFactory<HistoryScreenViewModel>(() => HistoryScreenViewModel());
  locator.registerFactory<ActiveScreenViewModel>(() => ActiveScreenViewModel());
}
