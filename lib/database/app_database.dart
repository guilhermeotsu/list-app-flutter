import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// config do db
void createDatabase() {
  getDatabasesPath().then(
    (dbPath) {
      final String path = join(dbPath, 'list_app.db');
      openDatabase(
        path,
        onCreate: (db, version) {
          db.execute('CREATE TABLE contacts('
              'id INTEGER PRIMARY KEY,'
              'name TEXT,'
              'account_number INTEGER)');
        },
        version: 1,
      );
    },
  );
}
