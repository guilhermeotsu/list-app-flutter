import 'package:list_app/database/dao/contact_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// config do db -- async faz com que todo o escopo trabalhe com Future
Future<Database> getDatabase() async {
  var path = join(await getDatabasesPath(), 'list_app.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ContactDao.tableSql);
    },
    version: 1,
    //  onDowngrade: onDatabaseDowngradeDelete
  );
}

