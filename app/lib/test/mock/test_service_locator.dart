import 'package:get_it/get_it.dart';

// The service locator must have global scope for dependency injection.
// DO NOT move these functions out of global scope.

/* If you want to use a mock, you have to use:
   testLocator.registerLazySingleton<T>(MockT())
*/
void addLazySingletonForTest<T>(GetIt testLocator, T Function() service) =>
    testLocator.registerLazySingleton<T>(() => service());

void addFactoryForTest<T>(GetIt testLocator, T Function() factory) =>
    testLocator.registerFactory(() => factory());

Future<void> resetForTest(GetIt testLocator) => testLocator.reset();
