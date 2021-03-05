import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/models/transporter.dart';

abstract class DatabaseInterface {
  Future<void> setNewTransporter(Transporter newTransporter);

  Future<Transporter> getTransporter(String userId);

  Future<void> removeTransporter(String userId);

  Future<AnimalTransportRecord> setNewAtr(String userId);

  Future<void> updateAtr(AnimalTransportRecord atr);

  Future<void> removeAtr(String atrId);

  Future<List<AnimalTransportRecord>> getCompleteRecords();

  Future<List<AnimalTransportRecord>> getActiveRecords();

  Stream<List<AnimalTransportRecord>> getUpdatedCompleteATRs();

  Stream<List<AnimalTransportRecord>> getUpdatedActiveATRs();
}
