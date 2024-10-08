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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null && selectedDate != DateTime.now()) {
      final formattedDate =
          '${selectedDate.toLocal().year}-${selectedDate.toLocal().month.toString().padLeft(2, '0')}-${selectedDate.toLocal().day.toString().padLeft(2, '0')}';
      _dateController.text = formattedDate;
    }
  }

  void _showConfirmationDialog(Dette debt) {
    Get.defaultDialog(
      title: 'Confirmation',
      middleText: 'Êtes-vous sûr de marquer cette dette comme payée ?',
      confirm: ElevatedButton(
        onPressed: () {
          clientDetailController.markDebtAsPaid(debt);
          Get.back(); // Ferme la boîte de dialogue
          Get.snackbar('Succès', 'Dette soldée');
        },
        child: Text('Confirmer'),
      ),
      cancel: ElevatedButton(
        onPressed: () =>
            Get.back(), // Ferme la boîte de dialogue sans faire d'action
        child: Text('Annuler'),
      ),
    );
  }

  Widget _buildClientInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nom: ${client.surname}', style: TextStyle(fontSize: 20)),
        SizedBox(height: 10),
        Text('Téléphone: ${client.phone}', style: TextStyle(fontSize: 16)),
        SizedBox(height: 10),
        Text('Adresse: ${client.address}', style: TextStyle(fontSize: 16)),
        SizedBox(height: 10),
        // Affiche l'email, le login et la photo s'ils existent
        if (client.compteUtilisateur != null) ...[
          if (client.compteUtilisateur!.email != null &&
              client.compteUtilisateur!.email!.isNotEmpty) ...[
            Text('Email: ${client.compteUtilisateur!.email}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
          ],
          if (client.compteUtilisateur!.login != null &&
              client.compteUtilisateur!.login!.isNotEmpty) ...[
            Text('Login: ${client.compteUtilisateur!.login}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
          ],
          // if (client.compteUtilisateur?.photo != null &&
          //     client.compteUtilisateur!.photo!.isNotEmpty) ...[
          //   Text('Photo: ${client.compteUtilisateur?.photo}',
          //       style: TextStyle(fontSize: 16)),
          //   SizedBox(height: 10),
          // ],
        ],
      ],
    );
  }

  Widget _buildDebtList(List<Dette> debts, {bool unpaid = true}) {
    return Expanded(
      child: Obx(() {
        final debtList = unpaid
            ? clientDetailController.unpaidDebts
            : clientDetailController.paidDebts;
        return ListView.builder(
          itemCount: debtList.length,
          itemBuilder: (context, index) {
            final debt = debtList[index];
            return ListTile(
              title: Text('Montant: ${debt.montant.toStringAsFixed(0)} FCFA'),
              subtitle: Text('Date: ${debt.date}'),
              trailing: unpaid
                  ? IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () {
                        _showConfirmationDialog(debt);
                      },
                    )
                  : null,
            );
          },
        );
      }),
    );
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
            _buildClientInfo(),
            SizedBox(height: 20),
            Text('Dettes non soldées', style: TextStyle(fontSize: 20)),
            _buildDebtList(clientDetailController.unpaidDebts, unpaid: true),
            SizedBox(height: 20),
            Text('Dettes soldées', style: TextStyle(fontSize: 20)),
            _buildDebtList(clientDetailController.paidDebts, unpaid: false),
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
                      final amount = double.tryParse(value);
                      if (amount == null || amount <= 0) {
                        return 'Veuillez entrer un montant valide';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      labelText: 'Date (AAAA-MM-JJ)',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () => _selectDate(context),
                      ),
                    ),
                    readOnly: true,
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
                          date: DateTime.parse(_dateController.text),
                          montant: double.parse(_amountController.text),
                          client: client,
                        );
                        clientDetailController.addDebt(newDebt);
                        _amountController.clear();
                        _dateController.clear();
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
