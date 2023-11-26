import 'package:mysql1/mysql1.dart';


class DatabaseConnector {
  late MySqlConnection _connection;
  late String? _currentDatabase;

  DatabaseConnector();

  Future connect(String? dataBase) async {
    if (_currentDatabase == dataBase) {
      return;
    }

    _currentDatabase = dataBase;

    var settings = ConnectionSettings(
      host: 'localhost', 
      port: 3306,
      user: 'root',
      // password: 'wibble',
      db: dataBase
    );
    
    _connection = await MySqlConnection.connect(settings);
    print("Connected to $dataBase");
    // var results = await conn.query('select * from `companies`');
    // var dbs = await conn.query("show databases");
  }

  Future<Results> getCompanies() async {
    await connect(_currentDatabase);
    return await _connection.query('select * from `companies`');
  }
}