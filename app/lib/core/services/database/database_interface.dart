import 'package:app/core/models/animal_transport_record.dart';
import 'package:app/core/models/transporter.dart';

abstract class DatabaseInterface {
  Future<void> setNewTransporter(Transporter newTransporter);

  Future<Transporter> getTransporter(String userId);

  Future<void> removeTransporter(String userId);

  Future<AnimalTransportRecord> setNewAtr(String userId);

  Future<void> updateAtr(AnimalTransportRecord atr);

  Future<void> removeAtr(String atrId);

  Future<List<AnimalTransportRecord>> getCompleteRecords(String userId);

  Future<List<AnimalTransportRecord>> getActiveRecords(String userId);

  Stream<List<AnimalTransportRecord>> getUpdatedCompleteATRs(String userId);

  Stream<List<AnimalTransportRecord>> getUpdatedActiveATRs(String userId);
}
