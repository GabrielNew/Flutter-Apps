import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lista_de_contatos/helpers/contact_helper.dart';

class ContactPage extends StatefulWidget {

  final Contact contact;

  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  bool _userEdited = false;
  Contact _editedContact;

  @override
  void initState() {
    super.initState();

    if (widget.contact == null) {
      _editedContact = Contact();
    } else {
      _editedContact = Contact.fromMap(widget.contact.toMap());

      nameController.text = _editedContact.name;
      emailController.text = _editedContact.email;
      phoneController.text = _editedContact.phone;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(_editedContact.name ?? "Novo Contato"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.save),
        backgroundColor: Colors.red,
        ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: 140.0,
                height: 140.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: _editedContact.img != null ? FileImage(File(_editedContact.img)): AssetImage("assets/person.png"),
                  ),
                ),
              ),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Nome"),
              onChanged: (text){
                _userEdited = true;
                setState(() {
                  _editedContact.name = text;
                });
              },
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
              onChanged: (text){
                _userEdited = true;
                _editedContact.email = text;
              },  
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "Telefone"),
              onChanged: (text){
                _userEdited = true;
                _editedContact.phone = text;
              },
              keyboardType: TextInputType.phone,  
            ),
          ],
        ),
      ),
    );
  }
}