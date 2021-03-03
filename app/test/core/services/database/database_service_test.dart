import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/models/atr_identifier.dart';
import 'package:app/core/models/transporter.dart';
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
  final mockQuerySnapshot = MockQuerySnapshot();
  final mockStream = MockStream();
  final mockDocSnap = MockDocSnap();
  final mockQuery = MockQuery();

  DatabaseService dbService;
  group('Database Service (Firebase Database Interface)', () {
    setUpAll(() async {
      testLocator.registerFactory<DatabaseInterface>(
          () => FirebaseDatabaseInterface(mockFirestoreInstance));
      dbService = DatabaseService(testLocator<DatabaseInterface>());
    });

    test('Should get transporter from firestore', () async {
      final transporterModel = Transporter.fromJSON(testTransporterJson());
      when(mockFirestoreInstance.collection('transporter'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get())
          .thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.data()).thenReturn(testTransporterJson());
      final result = await dbService.getTransporter('userId');
      expect(result, transporterModel);
    });

    test('Should not get transporter from firestore', () async {
      when(mockFirestoreInstance.collection('transporter'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get())
          .thenAnswer((_) async => Future.error('Error here'));
      try {
        await dbService.getTransporter('userId');
      } catch (e) {
        expect(e, 'Error here');
      }
    });

    test('should add new transporter to firestore', () async {
      final transporterModel = Transporter.fromJSON(testTransporterJson());
      when(mockFirestoreInstance.collection(any))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(transporterModel.userId))
          .thenReturn(mockDocumentReference);
      await dbService.newTransporter(transporterModel);
      verify(mockDocumentReference.set(transporterModel.toJSON())).called(1);
    });

    test('should set new initial atr to firestore', () async {
      final atr = AnimalTransportRecord.defaultAtr();
      when(mockFirestoreInstance.collection(any))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.add(any))
          .thenAnswer((_) async => mockDocumentReference);
      await dbService.saveNewAtr(atr.identifier.userId);
      verify(mockCollectionReference.add(atr.toJSON())).called(1);
    });

    test('should delete atr in firestore', () async {
      final atrIdentifier =
          AtrIdentifier.fromJSON(testAtrIdentifierJson(), '123');
      when(mockFirestoreInstance.collection(any))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.delete())
          .thenAnswer((_) async => Future.value());
      try {
        await dbService.removeAtr(atrIdentifier.atrDocumentId);
      } catch (e) {
        // Test should succeed
        fail(e);
      }
    });

    test('should not delete in firestore', () async {
      final atrIdentifier =
          AtrIdentifier.fromJSON(testAtrIdentifierJson(), '123');
      when(mockFirestoreInstance.collection(any))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.delete())
          .thenAnswer((_) async => Future.error('Could not be deleted'));
      try {
        await dbService.removeAtr(atrIdentifier.atrDocumentId);
      } catch (e) {
        // Test should succeed
        expect(e, 'Could not be deleted');
      }
    });

    test('Should get active ATRs', () async {
      final transporterModel = [
        AnimalTransportRecord.fromJSON(testAtrJson(), "123")
      ];
      when(mockFirestoreInstance.collection('atr'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.where('identifier.isComplete',
              isEqualTo: false))
          .thenReturn(mockQuery);
      when(mockQuery.get()).thenAnswer((_) async => (mockQuerySnapshot));
      when(mockQuerySnapshot.docs).thenAnswer((_) => [mockDocSnap]);
      when(mockDocSnap.id).thenReturn("123");
      when(mockDocSnap.data()).thenReturn(testAtrJson());
      final result = await dbService.getActiveRecords();
      expect(result, transporterModel);
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
      final transporterModel = [
        AnimalTransportRecord.fromJSON(testAtrJson(), "123")
      ];
      when(mockFirestoreInstance.collection('atr'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.where('identifier.isComplete',
              isEqualTo: true))
          .thenReturn(mockQuery);
      when(mockQuery.get()).thenAnswer((_) async => (mockQuerySnapshot));
      when(mockQuerySnapshot.docs).thenAnswer((_) => [mockDocSnap]);
      when(mockDocSnap.id).thenReturn("123");
      when(mockDocSnap.data()).thenReturn(testAtrJson());
      final result = await dbService.getCompleteRecords();
      expect(result, transporterModel);
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
        AnimalTransportRecord.fromJSON(testAtrJson(), "123")
      ];
      when(mockFirestoreInstance.collection('atr'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.where('identifier.isComplete',
              isEqualTo: false))
          .thenReturn(mockQuery);

      // Mock stream and stream map return
      Stream<List<AnimalTransportRecord>> myStream() async* {
        yield [AnimalTransportRecord.fromJSON(testAtrJson(), "123")];
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
