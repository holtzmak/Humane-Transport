import 'package:app/core/services/dialog/dialog_service.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/view_models/welcome_screen_view_model.dart';
import 'package:app/humane_transport_app.dart';
import 'package:app/ui/views/welcome/welcome_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'test_lib/test_service_locator.dart';

final testLocator = GetIt.instance;

void main() {
  group('Application main', () {
    tearDown(() async => resetForTest(testLocator));

    testWidgets('first route is welcome screen', (WidgetTester tester) async {
      addLazySingletonForTest(testLocator, () => WelcomeScreenViewModel());
      addLazySingletonForTest(testLocator, () => NavigationService());
      addLazySingletonForTest(testLocator, () => DialogService());
      await tester.pumpWidget(HumaneTransportApp());

      expect(find.widgetWithText(WelcomeScreen, 'Welcome!'), findsOneWidget);
    });
  });
}
