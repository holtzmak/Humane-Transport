import 'package:app/core/services/database/database_service.dart';
import 'package:app/core/view_models/add_history_view_model.dart';
import 'package:app/core/view_models/atr_pre_view_model.dart';
import 'package:app/core/view_models/nav_view_model.dart';
import 'package:app/core/view_models/ongoing_view_model.dart';
import 'package:app/core/view_models/signin_view_model.dart';
import 'package:app/core/view_models/signout_view_model.dart';
import 'package:app/core/view_models/signup_view_model.dart';
import 'package:app/core/view_models/splash_screen_view_model.dart';
import 'package:app/core/view_models/user_profile_view_model.dart';
import 'package:app/core/view_models/welcome_view_model.dart';
import 'package:get_it/get_it.dart';
import 'authentication/auth_service.dart';
import 'firestore/firestore_service.dart';
import 'navigation/nav_service.dart';

final locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => DatabaseService());

  locator.registerFactory(() => SplashScreenViewModel());
  locator.registerFactory(() => WelcomeViewModel());
  locator.registerFactory(() => SignInViewModel());
  locator.registerFactory(() => SignUpViewModel());
  locator.registerFactory(() => SignOutViewModel());
  locator.registerFactory(() => UserProfileViewModel());
  locator.registerFactory(() => OngoingViewModel());
  locator.registerFactory(() => AddHistoryViewModel());
  locator.registerFactory(() => NavigationViewModel());
  locator.registerFactory(() => AnimalTransportRecordPreViewModel());
}
