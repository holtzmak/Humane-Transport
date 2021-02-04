import 'package:app/core/services/authentication/auth_service.dart';
import 'package:app/core/services/firestore/firestore_service.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/view_models/splash_screen_view_model.dart';
import 'package:app/core/view_models/welcome_view_model.dart';
import 'package:app/humane_transport_app.dart';
import 'package:app/ui/views/welcome/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'test_lib/test_service_locator.dart';
import 'ui/widgets/firebase_auth_mock.dart';

final testLocator = GetIt.instance;

void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  group('Application main', () {
    tearDown(() => resetForTest(testLocator));
    testWidgets('first route is welcome screen', (WidgetTester tester) async {
      addLazySingletonForTest(testLocator, () => NavigationService());
      addLazySingletonForTest(testLocator, () => FirestoreService());
      addLazySingletonForTest(testLocator, () => AuthenticationService());

      addFactoryForTest(testLocator, () => SplashScreenViewModel());
      addFactoryForTest(testLocator, () => WelcomeViewModel());

      await tester.pumpWidget(HumaneTransportApp());

      await tester.pumpAndSettle();

      expect(find.widgetWithText(WelcomeScreen, 'Welcome'), findsOneWidget);
    });
  });
}
