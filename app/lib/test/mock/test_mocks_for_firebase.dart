import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';

class MockFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock implements CollectionReference {}

class MockDocumentReference extends Mock implements DocumentReference {}

class MockDocumentSnapshot extends Mock implements DocumentSnapshot {}

class MockQuerySnapshot extends Mock implements QuerySnapshot {}

class MockDocSnap extends Mock implements QueryDocumentSnapshot {}

class MockQuery extends Mock implements Query {}

class MockStream extends Mock implements Stream<QuerySnapshot> {}
