import 'package:flutter/material.dart';
import 'package:gestion_boutique_mobile/controllers/client_controllers.dart';
import 'package:gestion_boutique_mobile/models/Client.dart';
import 'package:get/get.dart';

class CreateClientPage extends StatelessWidget {
  final ClientController clientController = Get.put(ClientController());
  final _formKey = GlobalKey<FormState>();

  final _surnameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer un client'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Créer un client', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
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
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Créer un nouveau client
                        final newClient = Client(
                          surname: _surnameController.text,
                          phone: _phoneController.text,
                          address: _addressController.text,
                        );
                        // Ajouter le client via le contrôleur
                        clientController.addClient(newClient);

                        // Réinitialiser le formulaire
                        _surnameController.clear();
                        _phoneController.clear();
                        _addressController.clear();

                        // Afficher un message de succès
                        Get.snackbar('Succès', 'Client créé avec succès');
                      }
                    },
                    child: Text('Ajouter le client'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
