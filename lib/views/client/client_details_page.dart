import 'package:flutter/material.dart';
import 'package:gestion_boutique_mobile/controllers/client_details_controller.dart';
import 'package:gestion_boutique_mobile/models/Client.dart';
import 'package:gestion_boutique_mobile/models/Dette.dart';
import 'package:get/get.dart';

class ClientDetailsPage extends StatelessWidget {
  final ClientDetailController clientDetailController =
      Get.put(ClientDetailController());
  final Client client;

  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();

  ClientDetailsPage({required this.client}) {
    clientDetailController.client.value = client;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du client ${client.surname}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nom: ${client.surname}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Téléphone: ${client.phone}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Adresse: ${client.address}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('Dettes non soldées', style: TextStyle(fontSize: 20)),
            Expanded(
              child: Obx(() {
                final debts = clientDetailController.client.value.debts
                    .where((debt) => !debt.isPaid)
                    .toList();
                return ListView.builder(
                  itemCount: debts.length,
                  itemBuilder: (context, index) {
                    final unpaidDebt = debts[index];
                    return ListTile(
                      title: Text(
                          'Montant: ${unpaidDebt.amount.toStringAsFixed(0)} FCFA'),
                      subtitle: Text('Date: ${unpaidDebt.date}'),
                      trailing: IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () {
                          clientDetailController.markDebtAsPaid(unpaidDebt);
                          Get.snackbar('Succès', 'Dette soldée');
                        },
                      ),
                    );
                  },
                );
              }),
            ),
            SizedBox(height: 20),
            Text('Ajouter une dette', style: TextStyle(fontSize: 20)),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _amountController,
                    decoration: InputDecoration(labelText: 'Montant'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un montant';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(labelText: 'Date (AAAA-MM-JJ)'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer une date';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final newDebt = Dette(
                          date: _dateController.text,
                          amount: double.parse(_amountController.text),
                        );
                        clientDetailController.addDebt(newDebt);

                        // Réinitialiser le formulaire
                        _amountController.clear();
                        _dateController.clear();

                        // Afficher un message de succès
                        Get.snackbar('Succès', 'Dette ajoutée avec succès');
                      }
                    },
                    child: Text('Ajouter la dette'),
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
