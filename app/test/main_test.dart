import 'package:app/core/services/auth_service.dart';
import 'package:app/core/services/dialog_service.dart';
import 'package:app/core/services/nav_service.dart';
import 'package:app/core/utilities/optional.dart';
import 'package:app/core/view_models/welcome_screen_view_model.dart';
import 'package:app/humane_transport_app.dart';
import 'package:app/test/mock/test_service_locator.dart';
import 'package:app/ui/views/welcome_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

class MockAuthenticationService extends Mock implements AuthenticationService {}

final testLocator = GetIt.instance;

void main() {
  final mockAuthService = MockAuthenticationService();

  group('Application main', () {
    tearDown(() async => resetForTest(testLocator));

    testWidgets('first route is welcome screen', (WidgetTester tester) async {
      testLocator
          .registerLazySingleton<AuthenticationService>(() => mockAuthService);
      when(mockAuthService.currentUser).thenReturn(Optional.empty());
      addFactoryForTest(testLocator, () => WelcomeScreenViewModel());
      addLazySingletonForTest(testLocator, () => NavigationService());
      addLazySingletonForTest(testLocator, () => DialogService());
      await tester.pumpWidget(HumaneTransportApp());

      expect(find.widgetWithText(WelcomeScreen, 'Welcome!'), findsOneWidget);
    });
  });
}
