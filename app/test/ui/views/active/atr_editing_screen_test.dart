import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/services/dialog/dialog_service.dart';
import 'package:app/core/services/navigation/nav_service.dart';
import 'package:app/core/view_models/active_screen_view_model.dart';
import 'package:app/test/test_animal_transport_record.dart';
import 'package:app/ui/views/active/atr_editing_screen.dart';
import 'package:app/ui/views/active/form_field/fwr_info_form_field.dart';
import 'package:app/ui/views/active/form_field/shipper_info_form_field.dart';
import 'package:app/ui/views/active/form_field/transporter_info_form_field.dart';
import 'package:app/ui/widgets/utility/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

class MockNavigationService extends Mock implements NavigationService {}

class MockDialogService extends Mock implements DialogService {}

class MockActiveScreenViewModel extends Mock implements ActiveScreenViewModel {}

final testLocator = GetIt.instance;

void main() {
  final mockNavService = MockNavigationService();
  final mockDialogService = MockDialogService();

  Future<void> pumpATREditingScreen(
          WidgetTester tester, AnimalTransportRecord initialATR) async =>
      tester.pumpWidget(MaterialApp(home: ATREditingScreen(atr: initialATR)));

  group('ATR Editing Screen', () {
    setUpAll(() async {
      testLocator
          .registerLazySingleton<NavigationService>(() => mockNavService);
      testLocator.registerLazySingleton<DialogService>(() => mockDialogService);
      testLocator.registerLazySingleton<ActiveScreenViewModel>(
          () => MockActiveScreenViewModel());
    });

    testWidgets('has shipping info form field', (WidgetTester tester) async {
      await pumpATREditingScreen(tester, testAnimalTransportRecord());
      expect(find.byType(ShipperInfoFormField), findsOneWidget);
    });

    testWidgets('has transporter info form field', (WidgetTester tester) async {
      await pumpATREditingScreen(tester, testAnimalTransportRecord());
      expect(find.byType(TransporterInfoFormField), findsOneWidget);
    });

    testWidgets('has feed, water, rest form field',
        (WidgetTester tester) async {
      await pumpATREditingScreen(
          tester, testAnimalTransportRecord(shipInfo: testShipperInfo()));
      expect(find.byType(FeedWaterRestInfoFormField), findsOneWidget);
    });

    testWidgets('shows submit button', (WidgetTester tester) async {
      final submitButtonFinder = find.widgetWithText(RaisedButton, "Submit");
      await pumpATREditingScreen(tester, testAnimalTransportRecord());
      await tester.ensureVisible(submitButtonFinder);
      expect(submitButtonFinder, findsOneWidget);
    });

    testWidgets('launches successful dialog on submit',
        (WidgetTester tester) async {
      final testATR = testAnimalTransportRecord();
      final submitButtonFinder = find.widgetWithText(RaisedButton, "Submit");
      when(mockDialogService.showDialog(
              title: anyNamed("title"),
              description: anyNamed("description"),
              buttonText: anyNamed("buttonText")))
          .thenAnswer((_) => Future.value(DialogResponse(confirmed: true)));
      when(mockNavService.pop()).thenAnswer((_) {
        // Do nothing for test
      });
      await pumpATREditingScreen(tester, testATR);
      await tester.ensureVisible(submitButtonFinder);
      await tester.tap(submitButtonFinder);
      await tester.pumpAndSettle();
      verify(mockDialogService.showDialog(
              title: anyNamed("title"),
              description: anyNamed("description"),
              buttonText: anyNamed("buttonText")))
          .called(1);
      verify(mockNavService.pop()).called(1);
    });

    testWidgets(
        'launches failure dialog on submit', (WidgetTester tester) async {});
    testWidgets('gives completed ATR to database service on submit',
        (WidgetTester tester) async {});
    testWidgets('gives edited, completed ATR to database service on submit',
        (WidgetTester tester) async {});
    testWidgets(
        'closes on submit (prevent completed ATR from being edited further)',
        (WidgetTester tester) async {});
  });
}
