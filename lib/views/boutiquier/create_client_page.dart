import 'package:flutter/material.dart';
import 'package:gestion_boutique_mobile/controllers/client_controllers.dart';
import 'package:gestion_boutique_mobile/models/Client.dart';
import 'package:get/get.dart';

class CreateClientPage extends StatefulWidget {
  @override
  _CreateClientPageState createState() => _CreateClientPageState();
}

class _CreateClientPageState extends State<CreateClientPage> {
  final ClientController clientController = Get.put(ClientController());
  final _formKey = GlobalKey<FormState>();

  final _surnameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  final _emailController = TextEditingController();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  bool hasAccount = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer un client'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Créer un client', style: TextStyle(fontSize: 24)),
              SizedBox(height: 20),
              TextFormField(
                controller: _surnameController,
                decoration: InputDecoration(labelText: 'Nom de famille'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Téléphone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un numéro de téléphone';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Adresse'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une adresse';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: hasAccount,
                    onChanged: (value) {
                      setState(() {
                        hasAccount = value ?? false;
                      });
                    },
                  ),
                  Text('Lier à un compte')
                ],
              ),
              if (hasAccount) ...[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextFormField(
                  controller: _loginController,
                  decoration: InputDecoration(labelText: 'Login'),
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Mot de passe'),
                  obscureText: true,
                ),
              ],
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newClient = Client(
                      id: clientController.clients.length + 1,
                      surname: _surnameController.text,
                      phone: _phoneController.text,
                      address: _addressController.text,
                      hasAccount: hasAccount,
                      email: hasAccount ? _emailController.text : null,
                      login: hasAccount ? _loginController.text : null,
                      password: hasAccount ? _passwordController.text : null,
                    );

                    clientController.addClient(newClient);

                    // Réinitialiser le formulaire
                    _surnameController.clear();
                    _phoneController.clear();
                    _addressController.clear();
                    _emailController.clear();
                    _loginController.clear();
                    _passwordController.clear();
                    setState(() {
                      hasAccount = false;
                    });

                    Get.snackbar('Succès', 'Client créé avec succès');
                  }
                },
                child: Text('Ajouter le client'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
