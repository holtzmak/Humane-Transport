import 'package:app/core/services/auth_service.dart';
import 'package:app/core/services/dialog_service.dart';
import 'package:app/core/services/nav_service.dart';
import 'package:app/core/utilities/optional.dart';
import 'package:app/core/view_models/splash_screen_view_model.dart';
import 'package:app/core/view_models/welcome_screen_view_model.dart';
import 'package:app/humane_transport_app.dart';
import 'package:app/test/mock/test_service_locator.dart';
import 'package:app/ui/views/splash/splash_screen.dart';
import 'package:app/ui/views/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

class MockAuthenticationService extends Mock implements AuthenticationService {}

final testLocator = GetIt.instance;

void main() {
  final mockAuthService = MockAuthenticationService();
  final mockUser = Optional<User>.empty();

  group('Application main', () {
    tearDown(() async => resetForTest(testLocator));

    testWidgets(
        'first route is splash screen, then automatically the welcome screen',
        (WidgetTester tester) async {
      addLazySingletonForTest(testLocator, () => WelcomeScreenViewModel());
      addLazySingletonForTest(testLocator, () => SplashScreenViewModel());
      testLocator
          .registerLazySingleton<AuthenticationService>(() => mockAuthService);
      addLazySingletonForTest(testLocator, () => NavigationService());
      addLazySingletonForTest(testLocator, () => DialogService());
      when(mockAuthService.currentUser).thenReturn(mockUser);

      await tester.pumpWidget(HumaneTransportApp());
      expect(find.byWidgetPredicate((Widget it) => it is SplashScreen),
          findsOneWidget);
      // The splash screen appears for 3 seconds only
      await tester.pump(Duration(seconds: 3));
      expect(find.widgetWithText(WelcomeScreen, 'Welcome!'), findsOneWidget);
    });
  });
}
