import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/models/atr_identifier.dart';
import 'package:app/core/models/transporter.dart';
import 'package:app/core/services/database/database_interface.dart';
import 'package:app/core/services/database/database_service.dart';
import 'package:app/core/services/database/firebase_database_interface.dart';
import 'package:app/test/mock/test_mocks_for_firebase.dart';
import 'package:app/test/test_data.dart';
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
      when(mockCollectionReference.doc(transporterModel.userId))
          .thenReturn(mockDocumentReference);
      when(mockDocumentReference.get())
          .thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.data()).thenReturn(testTransporterJson());
      final result = await dbService.getTransporter(transporterModel.userId);
      expect(result, transporterModel);
    });

    test('Failed get transporter from firestore', () async {
      when(mockFirestoreInstance.collection('transporter'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc('userId'))
          .thenReturn(mockDocumentReference);
      when(mockDocumentReference.get())
          .thenAnswer((_) async => Future.error('Error here'));
      try {
        await dbService.getTransporter('userId');
      } catch (e) {
        expect(e, 'Error here');
      }
    });

    test('Should add new transporter to firestore', () async {
      final transporterModel = Transporter.fromJSON(testTransporterJson());
      when(mockFirestoreInstance.collection('transporter'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(transporterModel.userId))
          .thenReturn(mockDocumentReference);
      when(mockDocumentReference.set(transporterModel.toJSON()))
          .thenAnswer((_) => Future.value({}));
      await dbService.addTransporter(transporterModel);
      verify(mockDocumentReference.set(transporterModel.toJSON())).called(1);
    });

    test('Should delete transporter from firestore', () async {
      when(mockFirestoreInstance.collection('transporter'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc("test ID"))
          .thenReturn(mockDocumentReference);
      when(mockDocumentReference.delete())
          .thenAnswer((_) async => Future.value());
      await dbService.removeTransporter("test ID");
      verify(mockDocumentReference.delete()).called(1);
    });

    test('Should set new ATR to firestore', () async {
      when(mockFirestoreInstance.collection('atr'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.add(any))
          .thenAnswer((_) async => mockDocumentReference);
      await dbService.saveNewAtr(testAnimalTransportRecord());
      verify(mockCollectionReference.add(any)).called(1);
    });

    test('Should delete ATR in firestore', () async {
      final atrIdentifier =
          AtrIdentifier.fromJSON(testAtrIdentifierJson(), '123');
      when(mockFirestoreInstance.collection(any))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(atrIdentifier.atrDocumentId))
          .thenReturn(mockDocumentReference);
      when(mockDocumentReference.delete())
          .thenAnswer((_) async => Future.value());
      try {
        await dbService.removeAtr("123");
      } catch (e) {
        // Test Should succeed
        fail(e);
      }
    });

    test('Failed delete ATR in firestore', () async {
      final atrIdentifier =
          AtrIdentifier.fromJSON(testAtrIdentifierJson(), "123");
      when(mockFirestoreInstance.collection(any))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(atrIdentifier.atrDocumentId))
          .thenReturn(mockDocumentReference);
      when(mockDocumentReference.delete())
          .thenAnswer((_) async => Future.error('Could not be deleted'));
      try {
        await dbService.removeAtr("123");
      } catch (e) {
        // Test Should succeed
        expect(e, 'Could not be deleted');
      }
    });

    test('Should get active ATRs', () async {
      final transporterModel = [
        AnimalTransportRecord.fromJSON(testAtrJson(), "123")
      ];
      when(mockFirestoreInstance.collection('atr'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.where('identifier.userId', isEqualTo: "123"))
          .thenReturn(mockQuery);
      when(mockQuery.where('identifier.isComplete', isEqualTo: false))
          .thenReturn(mockQuery);
      when(mockQuery.get()).thenAnswer((_) async => (mockQuerySnapshot));
      when(mockQuerySnapshot.docs).thenAnswer((_) => [mockDocSnap]);
      when(mockDocSnap.id).thenReturn("123");
      when(mockDocSnap.data()).thenReturn(testAtrJson());
      final result = await dbService.getActiveRecords("123");
      expect(result, transporterModel);
    });

    test('Failed get active ATRs', () async {
      when(mockFirestoreInstance.collection('atr'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.where('identifier.userId',
              isEqualTo: "test ID"))
          .thenReturn(mockQuery);
      when(mockQuery.where('identifier.isComplete', isEqualTo: false))
          .thenReturn(mockQuery);
      when(mockQuery.get()).thenAnswer((_) async => Future.error('Error here'));
      try {
        await dbService.getActiveRecords("test ID");
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
      when(mockCollectionReference.where('identifier.userId', isEqualTo: "123"))
          .thenReturn(mockQuery);
      when(mockQuery.where('identifier.isComplete', isEqualTo: true))
          .thenReturn(mockQuery);
      when(mockQuery.get()).thenAnswer((_) async => (mockQuerySnapshot));
      when(mockQuerySnapshot.docs).thenAnswer((_) => [mockDocSnap]);
      when(mockDocSnap.id).thenReturn("123");
      when(mockDocSnap.data()).thenReturn(testAtrJson());
      final result = await dbService.getCompleteRecords("123");
      expect(result, transporterModel);
    });

    test('Failed get complete ATRs', () async {
      when(mockFirestoreInstance.collection('atr'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.where('identifier.userId',
              isEqualTo: "test ID"))
          .thenReturn(mockQuery);
      when(mockQuery.where('identifier.isComplete', isEqualTo: true))
          .thenReturn(mockQuery);
      when(mockQuery.get()).thenAnswer((_) async => Future.error('Error here'));
      try {
        await dbService.getCompleteRecords("test ID");
      } catch (e) {
        expect(e, 'Error here');
      }
    });

    test('Should get active ATRs stream', () async {
      final testRecords = [
        AnimalTransportRecord.fromJSON(testAtrJson(), "123")
      ];
      when(mockFirestoreInstance.collection('atr'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.where('identifier.userId', isEqualTo: "123"))
          .thenReturn(mockQuery);
      when(mockQuery.where('identifier.isComplete', isEqualTo: false))
          .thenReturn(mockQuery);

      // Mock stream and stream map return
      Stream<List<AnimalTransportRecord>> myStream() async* {
        yield [AnimalTransportRecord.fromJSON(testAtrJson(), "123")];
      }

      when(mockQuery.snapshots()).thenAnswer((_) => mockStream);
      when(mockStream.map(any)).thenAnswer((_) => myStream());

      final stream = dbService.getUpdatedActiveATRs("123");
      stream.listen(expectAsync1<void, List<AnimalTransportRecord>>((records) {
        expect(records, testRecords);
      }));
    });

    test('Should get complete ATRs stream with no records', () async {
      final testRecords = []; // Expect no records for test
      when(mockFirestoreInstance.collection('atr'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.where('identifier.userId',
              isEqualTo: "test ID"))
          .thenReturn(mockQuery);
      when(mockQuery.where('identifier.isComplete', isEqualTo: true))
          .thenReturn(mockQuery);

      // Mock stream and stream map return
      Stream<List<AnimalTransportRecord>> myStream() async* {
        yield [];
      }

      when(mockQuery.snapshots()).thenAnswer((_) => mockStream);
      when(mockStream.map(any)).thenAnswer((_) => myStream());

      final stream = dbService.getUpdatedCompleteATRs("test ID");
      stream.listen(expectAsync1<void, List<AnimalTransportRecord>>((records) {
        expect(records, testRecords);
      }));
    });

    test('Should get all completed ATRs stream', () async {
      final testRecords = [
        AnimalTransportRecord.fromJSON(testAtrJson(), "123")
      ];
      when(mockFirestoreInstance.collection('atr'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.where('identifier.isComplete',
              isEqualTo: true))
          .thenReturn(mockQuery);

      // Mock stream and stream map return
      Stream<List<AnimalTransportRecord>> myStream() async* {
        yield [AnimalTransportRecord.fromJSON(testAtrJson(), "123")];
      }

      when(mockQuery.snapshots()).thenAnswer((_) => mockStream);
      when(mockStream.map(any)).thenAnswer((_) => myStream());

      final stream = dbService.getAllUpdatedCompleteATRs();
      stream.listen(expectAsync1<void, List<AnimalTransportRecord>>((records) {
        expect(records, testRecords);
      }));
    });
  });
}
