import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

const String createDB = '''create table if not exists 
    db  (
            color1 TEXT,
            color2 TEXT,
            color3 TEXT,
            diceAmount int
            )''';

class MainDatabaseProvider extends StateNotifier<void> {
  MainDatabaseProvider() : super(null);

  late Database _database;

  Database get database => _database;

  Future<Database> initDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    _database = await sql.openDatabase(
      path.join(dbPath, 'local_db.db'),
      onCreate: (db, version) async {
        // Criação das tabelas
        await db.execute(createDB);
      },
      version: 1,
    );
    return _database;
  }

  Future<void> closeDB() async {
    _database.close();
    state = null;
  }
}

final initdbProvider = StateNotifierProvider<MainDatabaseProvider, void>(
    (ref) => MainDatabaseProvider());
