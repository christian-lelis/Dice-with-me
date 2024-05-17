import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sqflite/sqflite.dart';

class DatabaseProvider extends StateNotifier<List<Map<String, Object?>>> {
  DatabaseProvider() : super([]);

  Future<void> getdb(Database db) async {
    final data = await db.query('db');
    if (data.isEmpty) {
      await db.insert('db', {
        'color1': '0xFF9C27B0',
        'color2': '0xFFE91E63',
        'color3': '0xFFFF9800',
        'diceAmount': 1,
      });
    }
    state = await db.query('db');
  }

  void setcounter(Database db, int count) async {
    await db.update('db', {'diceAmount': count});
    state = await db.query('db');
  }
}

final dbProvider =
    StateNotifierProvider<DatabaseProvider, List<Map<String, Object?>>>(
        (ref) => DatabaseProvider());
