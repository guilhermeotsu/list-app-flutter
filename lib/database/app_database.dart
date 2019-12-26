import 'package:list_app/models/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// config do db
Future<Database> createDatabase() {
  return getDatabasesPath().then(
    // retornar o getDatabase permite que tenhamos acesso ao Future<Database> dentro da função save
    (dbPath) {
      final String path = join(dbPath, 'list_app.db');
      return openDatabase(
        // openDatabase retorna o Future<Database>
        path,
        onCreate: (db, version) {
          db.execute('CREATE TABLE contacts('
              'id INTEGER PRIMARY KEY, '
              'name TEXT, '
              'account_number INTEGER)');
        },
        version: 1,
      );
    },
  );
}

Future<int> save(Contact contact) {
  return createDatabase().then(
    (db) {
      // valore retornado da função createDatabase onde tem as tabelas criadas etc
      // a função insert precisa receber como parametro um Map<String, dynamic> String: nome da tabela, dynamic: valores(primitivos)
      final Map<String, dynamic> contactMap = Map();
      // sqlite faz o incremento do id de forma automatica
      contactMap['name'] = contact.name;
      contactMap['account_number'] = contact.accountNumber;

      return db.insert('contacts', contactMap);
    },
  );
}

Future<List<Contact>> findAll() {
  return createDatabase().then(
    (db) {
      // query pega todos os valores de uma tabela
      return db.query('contacts').then(
        (maps) {
          final List<Contact> contacts = List();
          for (var map in maps) {
            var contact = Contact(
              map['id'],
              map['name'],
              map['account_number'],
            );
            contacts.add(contact);
          }
          return contacts;
        },
      );
    },
  );
}
