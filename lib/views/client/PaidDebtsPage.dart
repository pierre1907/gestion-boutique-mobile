import 'package:flutter/material.dart';
import 'package:gestion_boutique_mobile/controllers/client_details_controller.dart';
import 'package:get/get.dart';

class PaidDebtsPage extends StatelessWidget {
  final ClientDetailController clientDetailController =
      Get.find<ClientDetailController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dettes Soldées'),
      ),
      body: Obx(() {
        final paidDebts = clientDetailController.paidDebts;

        return ListView.builder(
          itemCount: paidDebts.length,
          itemBuilder: (context, index) {
            final debt = paidDebts[index];
            return ListTile(
              title: Text('Montant: ${debt.amount.toStringAsFixed(0)} FCFA'),
              subtitle: Text('Date: ${debt.date}'),
            );
          },
        );
      }),
    );
  }
}
