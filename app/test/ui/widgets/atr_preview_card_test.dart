import 'package:app/core/services/shared_preferences_service.dart';
import 'package:app/test/test_data.dart';
import 'package:app/ui/widgets/atr_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mockito/mockito.dart';

class MockSharedPreferencesService extends Mock
    implements SharedPreferencesService {}

final testLocator = GetIt.instance;

void main() {
  final mockSharedPreferencesService = MockSharedPreferencesService();

  group('ATR Preview Card', () {
    setUpAll(() async {
      testLocator.registerLazySingleton<SharedPreferencesService>(
          () => mockSharedPreferencesService);
    });

    testWidgets('shows right information', (WidgetTester tester) async {
      final testDate = DateTime.parse("2021-01-01 01:01");
      final testCompany = "Test Company";
      final testRecWithDelInfo = testAnimalTransportRecord().withDeliveryInfo(
          testDeliveryInfo(
              recInfo: testReceiverInfo(receiverCompanyName: testCompany)));
      final testRecWithInfo = testRecWithDelInfo
          .withVehicleInfo(testVehicleInfo(dateAndTimeLoaded: testDate));

      await tester.pumpWidget(new MaterialApp(
          home: ATRPreviewCard(
        atr: testRecWithInfo,
        onTap: () {
          // Do nothing for test
        },
      )));

      expect(find.byIcon(Icons.folder), findsOneWidget);
      expect(find.text("Transport for $testCompany"), findsOneWidget);
      expect(find.text("${DateFormat("yyyy-MM-dd hh:mm").format(testDate)}"),
          findsOneWidget);
    });

    testWidgets('calls function on tap', (WidgetTester tester) async {
      final testCompany = "Test Company";
      final testRecWithDelInfo = testAnimalTransportRecord().withDeliveryInfo(
          testDeliveryInfo(
              recInfo: testReceiverInfo(receiverCompanyName: testCompany)));
      bool callback;
      final testCallback = () => callback = true;
      final widget = ATRPreviewCard(
        atr: testRecWithDelInfo,
        onTap: testCallback,
      );
      await tester.pumpWidget(new MaterialApp(home: widget));
      await tester.tap(find.byIcon(Icons.folder));
      await tester.pumpAndSettle();
      expect(callback, true);
    });

    testWidgets('calls set as default on tap', (WidgetTester tester) async {
      final testCompany = "Test Company";
      final testRecWithDelInfo = testAnimalTransportRecord().withDeliveryInfo(
          testDeliveryInfo(
              recInfo: testReceiverInfo(receiverCompanyName: testCompany)));
      final widget = ATRPreviewCard(
        atr: testRecWithDelInfo,
        onTap: () {
          // do nothing for test
        },
      );
      await tester.pumpWidget(new MaterialApp(home: widget));
      await tester.tap(find.text("Set as my default"));
      await tester.pumpAndSettle();
      verify(mockSharedPreferencesService.setAtrAsDefault(any)).called(1);
    });
  });
}
