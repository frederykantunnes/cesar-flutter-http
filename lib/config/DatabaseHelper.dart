import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelper{
  static final _databaseName = "HMAIS.db";
  static final _databaseVersion = 1;
  static final table = 'user_table';

  static final columnId = '_id';
  static final idColumn = 'id';
  static final nomeColumn = 'nome';
  static final cnpjColumn = 'cnpj';
  static final senhaColumn = 'senha';
  static final enderecoColumn = 'endereco';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $idColumn INTEGER NOT NULL,
            $nomeColumn TEXT NOT NULL,
            $cnpjColumn TEXT NOT NULL,
            $senhaColumn TEXT NOT NULL,
            $enderecoColumn TEXT
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$idColumn = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }


}