import 'package:flutter/material.dart';
import 'package:gestion_boutique_mobile/controllers/client_details_controller.dart';
import 'package:get/get.dart';

class UnpaidDebtsPage extends StatelessWidget {
  final ClientDetailController clientDetailController =
      Get.find<ClientDetailController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dettes Non Soldées'),
      ),
      body: Obx(() {
        final unpaidDebts = clientDetailController.unpaidDebts;

        return ListView.builder(
          itemCount: unpaidDebts.length,
          itemBuilder: (context, index) {
            final debt = unpaidDebts[index];
            return ListTile(
              title: Text('Montant: ${debt.montant.toStringAsFixed(0)} FCFA'),
              subtitle: Text('Date: ${debt.date}'),
            );
          },
        );
      }),
    );
  }
}
