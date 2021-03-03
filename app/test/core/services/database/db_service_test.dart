import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/models/atr_identifier.dart';
import 'package:app/core/models/firestore_user.dart';
import 'package:app/core/services/database/database_interface.dart';
import 'package:app/core/services/database/database_service.dart';
import 'package:app/core/services/database/firebase_database_interface.dart';
import 'package:app/test/mock/test_mocks_for_firebase.dart';
import 'package:app/test/test_json.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

final testLocator = GetIt.instance;

void main() {
  final mockFirestoreInstance = MockFirestore();
  final mockCollectionReference = MockCollectionReference();
  final mockDocumentReference = MockDocumentReference();
  final mockDocumentSnapshot = MockDocumentSnapshot();
  final testUserJson = testFireStoreUserJson();
  final testAtrIdJson = testAtrIdentifierJson();
  final testAnimalTransportRecordJson = testAtrJson();
  final mockQuerySnapshot = MockQuerySnapshot();
  final mockStream = MockStream();
  final mockDocSnap = MockDocSnap();
  final mockQuery = MockQuery();

  DatabaseService dbService;
  group('Database Service', () {
    setUpAll(() async {
      testLocator.registerFactory<DatabaseInterface>(
          () => FirebaseDatabaseInterface(mockFirestoreInstance));
      dbService = DatabaseService(testLocator<DatabaseInterface>());
    });

    test('Should get user from firestore', () async {
      final userModel = FirestoreUser.fromJSON(testUserJson);

      when(mockFirestoreInstance.collection('users'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get())
          .thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.data()).thenReturn(testUserJson);
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
      final userModel = FirestoreUser.fromJSON(testUserJson);
      when(mockFirestoreInstance.collection(any))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(userModel.userId))
          .thenReturn(mockDocumentReference);
      await dbService.newUser(userModel);
      verify(mockDocumentReference.set(userModel.toJSON())).called(1);
    });

    test('should set new initial atr to firestore', () async {
      final userModel = AnimalTransportRecord.defaultAtr();
      when(mockFirestoreInstance.collection(any))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.add(any))
          .thenAnswer((_) async => mockDocumentReference);
      await dbService.saveNewAtr(userModel.identifier.userId);
      verify(mockCollectionReference.add(userModel.toJSON())).called(1);
    });

    test('should delete atr to firestore', () async {
      final userModel = AtrIdentifier.fromJSON(testAtrIdJson, '123');
      when(mockFirestoreInstance.collection(any))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.delete())
          .thenAnswer((_) async => Future.value());
      final result = await dbService.removeAtr(userModel.atrDocumentId);
      expect(result, true);
    });

    test('should not delete', () async {
      final userModel = AtrIdentifier.fromJSON(testAtrIdJson, '123');
      when(mockFirestoreInstance.collection(any))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.delete())
          .thenAnswer((_) async => Future.error('Could not be deleted'));
      final result = await dbService.removeAtr(userModel.atrDocumentId);
      expect(result, false);
    });

    test('Should get active ATRs', () async {
      final userModel = [
        AnimalTransportRecord.fromJSON(testAnimalTransportRecordJson, "123")
      ];
      when(mockFirestoreInstance.collection('atr'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.where('identifier.isComplete',
              isEqualTo: false))
          .thenReturn(mockQuery);
      when(mockQuery.get()).thenAnswer((_) async => (mockQuerySnapshot));
      when(mockQuerySnapshot.docs).thenAnswer((_) => [mockDocSnap]);
      when(mockDocSnap.id).thenReturn("123");
      when(mockDocSnap.data()).thenReturn(testAnimalTransportRecordJson);
      final result = await dbService.getActiveRecords();
      expect(result, userModel);
    });

    test('Should not get active ATRs', () async {
      when(mockFirestoreInstance.collection('atr'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.where('identifier.isComplete',
              isEqualTo: false))
          .thenReturn(mockQuery);
      when(mockQuery.get()).thenAnswer((_) async => Future.error('Error here'));
      try {
        await dbService.getActiveRecords();
      } catch (e) {
        expect(e, 'Error here');
      }
    });

    test('Should get complete ATRs', () async {
      final userModel = [
        AnimalTransportRecord.fromJSON(testAnimalTransportRecordJson, "123")
      ];
      when(mockFirestoreInstance.collection('atr'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.where('identifier.isComplete',
              isEqualTo: true))
          .thenReturn(mockQuery);
      when(mockQuery.get()).thenAnswer((_) async => (mockQuerySnapshot));
      when(mockQuerySnapshot.docs).thenAnswer((_) => [mockDocSnap]);
      when(mockDocSnap.id).thenReturn("123");
      when(mockDocSnap.data()).thenReturn(testAnimalTransportRecordJson);
      final result = await dbService.getCompleteRecords();
      expect(result, userModel);
    });

    test('Should not get complete ATRs', () async {
      when(mockFirestoreInstance.collection('atr'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.where('identifier.isComplete',
              isEqualTo: false))
          .thenReturn(mockQuery);
      when(mockQuery.get()).thenAnswer((_) async => Future.error('Error here'));
      try {
        await dbService.getCompleteRecords();
      } catch (e) {
        expect(e, 'Error here');
      }
    });

    test('get active ATRs stream', () async {
      final testRecords = [
        AnimalTransportRecord.fromJSON(testAnimalTransportRecordJson, "123")
      ];
      when(mockFirestoreInstance.collection('atr'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.where('identifier.isComplete',
              isEqualTo: false))
          .thenReturn(mockQuery);

      // Mock stream and stream map return
      Stream<List<AnimalTransportRecord>> myStream() async* {
        yield [
          AnimalTransportRecord.fromJSON(testAnimalTransportRecordJson, "123")
        ];
      }

      when(mockQuery.snapshots()).thenAnswer((_) => mockStream);
      when(mockStream.map(any)).thenAnswer((_) => myStream());

      final stream = dbService.getUpdatedActiveATRs();
      stream.listen(expectAsync1<void, List<AnimalTransportRecord>>((records) {
        expect(records, testRecords);
      }));
    });

    test('get complete ATRs stream with no records', () async {
      // Expect no records for test
      final testRecords = [];
      when(mockFirestoreInstance.collection('atr'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.where('identifier.isComplete',
              isEqualTo: true))
          .thenReturn(mockQuery);

      // Mock stream and stream map return
      Stream<List<AnimalTransportRecord>> myStream() async* {
        yield [];
      }

      when(mockQuery.snapshots()).thenAnswer((_) => mockStream);
      when(mockStream.map(any)).thenAnswer((_) => myStream());

      final stream = dbService.getUpdatedCompleteATRs();
      stream.listen(expectAsync1<void, List<AnimalTransportRecord>>((records) {
        expect(records, testRecords);
      }));
    });
  });
}
