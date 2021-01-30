import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'core/services/service_locator.dart';
import 'humane_transport_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setUpLocator();
  runApp(HumaneTransportApp());
}
