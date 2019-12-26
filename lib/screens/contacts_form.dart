import 'package:flutter/material.dart';
import 'package:list_app/models/contact.dart';
import 'package:list_app/database/dao/contact_dao.dart';

class ContactsForm extends StatefulWidget {
// quando se pega estado e muda ele e necessario mudar de stateless para statefull
  @override
  _ContactsFormState createState() => _ContactsFormState();
}

class _ContactsFormState extends State<ContactsForm> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _accountNumberController =
      TextEditingController();

  var _dao = ContactDao();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Full Name'),
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _accountNumberController,
                keyboardType:
                    TextInputType.number, // adicionar teclado numerico
                decoration: InputDecoration(labelText: 'Account Number'),
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                // permite mudar as dimensões dos widgets
                width: double.maxFinite,
                child: RaisedButton(
                  child: Text(
                    'Create',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  color: Colors.green,
                  onPressed: () {
                    final String name = _nameController.text;
                    final int accountNumber =
                        int.tryParse(_accountNumberController.text);

                    final Contact newContact = Contact(0, name, accountNumber);
                    _dao.save(newContact).then((id) => Navigator.pop(context));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
