import 'package:flutter/material.dart';
import 'package:list_app/database/app_database.dart';
import 'package:list_app/models/contact.dart';
import 'package:list_app/screens/contacts_form.dart';

class ContactsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_call),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => ContactsForm(),
                ),
              )
              .then(
                (newContact) => debugPrint(newContact.toString()),
              ); // pegando as informações de retorno (pop) apos o push;
        },
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: List(),
        // vai executar o future e após isso vai executar o codigo do builder, onde fica o callback
        // o snapshot contem todas as informações do future: findAll()
        future:
            findAll(), // referencia do future que queremos que seja executada
        builder: (context, snapshot) {
          // if (snapshot.data != null) {
          switch (snapshot.connectionState) {
            // Future ainda nao foi executado
            case ConnectionState.none:
              break;
            // Verifica que o Future ainda está carregando
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text('Loading'),
                  ],
                ),
              );
              break;
            // tem dados disponíveis mas ainda não foi finalizado o Future (Stream)
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contact> contacts = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  var contact = contacts[index];
                  return _ContactList(contact);
                },
                itemCount: contacts.length,
              );
              break;
          }
          return Text('Undefined Error');
        },
      ),
    );
  }
}

class _ContactList extends StatelessWidget {
  final Contact contact;

  _ContactList(this.contact);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.perm_device_information),
        title: Text(
          contact.name,
          style: TextStyle(
            fontSize: 24.0,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
