import 'package:app/core/services/navigation/nav_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TapPageArguments {
  final String id;
  final VoidCallback onTap;

  TapPageArguments(this.id, this.onTap);
}

// Borrowed from Flutter navigator test
// https://github.com/flutter/flutter/blob/master/packages/flutter/test/widgets/navigator_test.dart
class OnTapPage extends StatelessWidget {
  static const route = "/onTapPage";
  final String id;
  final VoidCallback onTap;

  const OnTapPage({Key key, @required this.id, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page $id')),
      body: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          child: Center(
            child: Text(id, style: Theme.of(context).textTheme.headline3),
          ),
        ),
      ),
    );
  }
}

void main() {
  group("Navigation Service", () {
    testWidgets('navigate and replace', (WidgetTester tester) async {
      final navService = NavigationService();
      /* This is the onGenerateRoute version of the following:
         final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
         '/' : (BuildContext context) => OnTapPage(id: '/', onTap: () { navService.navigateTo('/A'); }),
         '/A': (BuildContext context) => OnTapPage(id: 'A', onTap: () { navService.navigateAndReplace('/B'); }),
         '/B': (BuildContext context) => OnTapPage(id: 'B', onTap: () { navService.pop(); }),
         };
         await tester.pumpWidget(MaterialApp(routes: routes)); */
      navToPageB() => navService.navigateAndReplace(OnTapPage.route,
          arguments: TapPageArguments('B', () => navService.pop()));

      navToPageA() => navService.navigateTo(OnTapPage.route,
          arguments: TapPageArguments('A', () => navToPageB()));

      final homePageWithRouting = OnTapPage(id: '/', onTap: navToPageA);

      await tester.pumpWidget(MaterialApp(
          navigatorKey: navService.navigationKey,
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            return MaterialPageRoute(
              settings: RouteSettings(name: settings.name),
              builder: (BuildContext context) {
                switch (settings.name) {
                  case '/':
                    return homePageWithRouting;
                  case OnTapPage.route:
                    final TapPageArguments args = settings.arguments;
                    return OnTapPage(id: args.id, onTap: args.onTap);
                  default:
                    throw Exception('Invalid route: ${settings.name}');
                }
              },
            );
          }));
      // Start at home page
      expect(find.text('/'), findsOneWidget);
      expect(find.text('A', skipOffstage: false), findsNothing);
      expect(find.text('B', skipOffstage: false), findsNothing);

      // Navigate to page A
      await tester.tap(find.text('/'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('/', skipOffstage: false), findsOneWidget);
      expect(find.text('A'), findsOneWidget);
      expect(find.text('B', skipOffstage: false), findsNothing);

      // Navigate to page B, replacing A
      await tester.tap(find.text('A'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('/', skipOffstage: false), findsOneWidget);
      expect(find.text('A', skipOffstage: false), findsNothing);
      expect(find.text('B'), findsOneWidget);

      // Pop B
      await tester.tap(find.text('B'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('/'), findsOneWidget);
      expect(find.text('A', skipOffstage: false), findsNothing);
      expect(find.text('B', skipOffstage: false), findsNothing);
    });

    testWidgets('navigate back until', (WidgetTester tester) async {
      final navService = NavigationService();
      /* This is the onGenerateRoute version of the following:
         final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
         '/' : (BuildContext context) => OnTapPage(id: '/', onTap: () { navService.navigateTo('/A'); }),
         '/A': (BuildContext context) => OnTapPage(id: 'A', onTap: () { navService.navigateBackUntil('/'); }),
         };
         await tester.pumpWidget(MaterialApp(routes: routes)); */
      navToPageA() => navService.navigateTo(OnTapPage.route,
          arguments:
              TapPageArguments('A', () => navService.navigateBackUntil('/')));

      final homePageWithRouting = OnTapPage(id: '/', onTap: navToPageA);

      await tester.pumpWidget(MaterialApp(
          navigatorKey: navService.navigationKey,
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            return MaterialPageRoute(
              // Must rename the settings each time
              // https://github.com/flutter/flutter/issues/16602#issuecomment-407916243
              settings: RouteSettings(name: settings.name),
              builder: (BuildContext context) {
                final TapPageArguments args = settings.arguments;
                switch (settings.name) {
                  case '/':
                    return homePageWithRouting;
                  case OnTapPage.route:
                    return OnTapPage(id: args.id, onTap: args.onTap);
                  default:
                    throw Exception('Invalid route: ${settings.name}');
                }
              },
            );
          }));

      // Start at home page
      expect(find.text('/'), findsOneWidget);
      expect(find.text('A', skipOffstage: false), findsNothing);

      // Navigate to page A
      await tester.tap(find.text('/'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('/', skipOffstage: false), findsOneWidget);
      expect(find.text('A'), findsOneWidget);

      // Navigate back to home page
      await tester.tap(find.text('A'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('/'), findsOneWidget);
      expect(find.text('A', skipOffstage: false), findsNothing);
    });
  });
}
