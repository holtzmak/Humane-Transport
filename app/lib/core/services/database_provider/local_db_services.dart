import 'dart:async';
import 'dart:io' as io;
import 'package:app/core/models/transporter_info.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class LocalDB{
  static Database _database;
  static const String TRANSPORTER = 'TransporterInfo';
  static const String SHIPPER = 'ShipperInfo';
  static const String DELIVERY = 'DeliveryInfo';
  static const String FWR = 'FwrInfo';
  static const String VEHICLE = 'VehicleLoadingInfo';
  static const String CONTINGENCY = 'ContingencyPlan';
  static const String ACKNOWLEDGMENTS = 'AckInfo';
  static const String DB_NAME = 'humane_transport.db';

  Future<Database> get db async {
    if (_database != null)
      return _database;
    else
    _database = await initDB();
    return _database;
  }

  initDB() async {
    io.Directory databaseDirectory = await getApplicationDocumentsDirectory();
    String path = join(databaseDirectory.path, DB_NAME);
    var  db = await openDatabase(path, version: 1, onCreate: _setup);
    return db;
  }

  _setup(Database db, int version) async{
    await db.execute('''
        CREATE TABLE $TRANSPORTER(CompanyName varchar(255), CompanyAddress varchar(255), driverNames varchar(255), vehicleProvince varchar(255), vehicleLicense varchar(255),
        trailerProvince varchar(255), trailerLicense varchar(255), dateLastCleaned Date , addressLastCleaned varchar(255), driversAreBriefed bool, driversHaveTraining bool,
        trainingType varchar(255), trainingExpiryDate date, FormId varchar(255))''');

  }

  Future<dynamic> saveTransporter(TransporterInfo tranRecord, String formId)async {
    var getDb = await db;
    var tranQuery = await getDb.insert(TRANSPORTER, tranRecord.toMap());
    return tranQuery;
  }

  Future<dynamic> getTransporter(String formId) async {
    var getDb = await db;
    var result = await getDb.query(TRANSPORTER, where: formId,);
    return result;
  }

  Future<dynamic> updateTransporter(String formId, TransporterInfo updateRecord) async{
    var getDb = await db;
    var result = await getDb.update(TRANSPORTER, updateRecord.toMap());
    return result;
  }
}