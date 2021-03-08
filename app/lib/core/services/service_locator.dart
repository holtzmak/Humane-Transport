import 'package:app/core/services/database/database_interface.dart';
import 'package:app/core/services/database/database_service.dart';
import 'package:app/core/services/database/firebase_database_interface.dart';
import 'package:app/core/view_models/account_edit_view_model.dart';
import 'package:app/core/view_models/account_screen_view_model.dart';
import 'package:app/core/view_models/active_screen_view_model.dart';
import 'package:app/core/view_models/history_screen_view_model.dart';
import 'package:app/core/view_models/home_screen_view_model.dart';
import 'package:app/core/view_models/sign_in_view_model.dart';
import 'package:app/core/view_models/signup_view_model.dart';
import 'package:app/core/view_models/welcome_screen_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'auth_service.dart';
import 'dialog_service.dart';
import 'nav_service.dart';

final locator = GetIt.instance;

void setUpLocator() {
  // Singletons
  locator.registerLazySingleton<DatabaseInterface>(
      () => FirebaseDatabaseInterface(FirebaseFirestore.instance));
  locator.registerLazySingleton<DatabaseService>(
      () => DatabaseService(locator<DatabaseInterface>()));
  locator.registerLazySingleton<AuthenticationService>(
      () => AuthenticationService(firebaseAuth: FirebaseAuth.instance));
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<DialogService>(() => DialogService());
  // Factories
  locator
      .registerFactory<WelcomeScreenViewModel>(() => WelcomeScreenViewModel());
  locator.registerFactory<SignInViewModel>(() => SignInViewModel());
  locator.registerFactory<SignUpViewModel>(() => SignUpViewModel());
  locator
      .registerFactory<AccountScreenViewModel>(() => AccountScreenViewModel());
  locator.registerFactory<AccountEditViewModel>(() => AccountEditViewModel());
  locator.registerFactory<HomeScreenViewModel>(() => HomeScreenViewModel());
  locator
      .registerFactory<HistoryScreenViewModel>(() => HistoryScreenViewModel());
  locator.registerFactory<ActiveScreenViewModel>(() => ActiveScreenViewModel());
}
