import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/models/firestore_user.dart';
import 'package:app/core/services/database/database_interface.dart';
import 'package:app/core/services/database/database_service.dart';
import 'package:app/core/services/database/firebase_database_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'test_data.dart';
import 'test_helper.dart';

final testLocator = GetIt.instance;
void main() {
  final mockFirestoreInstance = MockFirestore();
  final mockCollectionReference = MockCollectionReference();
  final mockDocumentReference = MockDocumentReference();
  final mockDocumentSnapshot = MockDocumentSnapshot();
  final _fakeResponse = fakeData();
  final _fakeAtrResponse = fakeATR();
  DatabaseService dbService;
  group('Database Service -', () {
    setUpAll(() async {
      testLocator.registerFactory<DatabaseInterface>(
          () => FirebaseDatabaseInterface(mockFirestoreInstance));
      dbService = DatabaseService(testLocator<DatabaseInterface>());
    });
    test('Should get user from firestore', () async {
      final userModel = FirestoreUser.fromJSON(_fakeResponse);

      when(mockFirestoreInstance.collection('users'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      // Note: Then answer is used in async
      when(mockDocumentReference.get())
          .thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.data()).thenReturn(_fakeResponse);
      final result = await dbService.getUser('userId');

      expect(result, userModel);
    });

    test('Should not get user from firestore', () async {
      when(mockFirestoreInstance.collection('users'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get())
          .thenAnswer((_) async => Future.error('Error here'));
      try {
        await dbService.getUser('userId');
      } catch (e) {
        expect(e, 'Error here');
      }
    });

    test('should add new user to firestore', () async {
      final userModel = FirestoreUser.fromJSON(_fakeResponse);
      when(mockFirestoreInstance.collection(any))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(userModel.userId))
          .thenReturn(mockDocumentReference);
      await dbService.newUser(userModel);
      verify(mockDocumentReference.set(userModel.toJSON()));
    });

    test('should add new atr to firestore', () async {
      final userModel = AnimalTransportRecord.fromJSON(_fakeAtrResponse);
      when(mockFirestoreInstance.collection(any))
          .thenReturn(mockCollectionReference);
      await dbService.newRecord(userModel);
      verify(mockCollectionReference.add(userModel.toJSON()));
    });
  });
}
