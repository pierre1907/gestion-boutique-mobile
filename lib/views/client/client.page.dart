import 'package:flutter/material.dart';
import 'package:gestion_boutique_mobile/controllers/client_details_controller.dart';
import 'package:gestion_boutique_mobile/models/Client.dart';
import 'package:gestion_boutique_mobile/models/Dette.dart';
import 'package:gestion_boutique_mobile/views/client/PaidDebtsPage.dart';
import 'package:gestion_boutique_mobile/views/client/UnpaidDebtsPage.dart';
import 'package:get/get.dart';

class ClientHomePage extends StatelessWidget {
  final ClientDetailController clientDetailController =
      Get.put(ClientDetailController());

  @override
  Widget build(BuildContext context) {
    // Exemple de client pour la démonstration
    final client = Client(
      id: 1,
      surname: 'John Doe',
      phone: '1234567890',
      address: '123 Main St',
      debts: [
        Dette(date: '2024-09-01', amount: 100.0, isPaid: false),
        Dette(date: '2024-09-02', amount: 150.0, isPaid: true),
        Dette(date: '2024-09-03', amount: 200.0, isPaid: false),
        Dette(date: '2024-09-04', amount: 250.0, isPaid: true),
        Dette(date: '2024-09-05', amount: 300.0, isPaid: false),
        Dette(date: '2024-09-06', amount: 350.0, isPaid: true),
        Dette(date: '2024-09-07', amount: 400.0, isPaid: false),
        Dette(date: '2024-09-08', amount: 450.0, isPaid: true),
        Dette(date: '2024-09-09', amount: 500.0, isPaid: false),
        Dette(date: '2024-09-10', amount: 550.0, isPaid: true),
        Dette(date: '2024-09-11', amount: 600.0, isPaid: false),
        Dette(date: '2024-09-12', amount: 650.0, isPaid: true),
        Dette(date: '2024-09-13', amount: 700.0, isPaid: false),
        Dette(date: '2024-09-14', amount: 750.0, isPaid: true),
        Dette(date: '2024-09-15', amount: 800.0, isPaid: false),
        Dette(date: '2024-09-16', amount: 850.0, isPaid: true),
        Dette(date: '2024-09-17', amount: 900.0, isPaid: false),
        Dette(date: '2024-09-18', amount: 950.0, isPaid: true),
        Dette(date: '2024-09-19', amount: 1000.0, isPaid: false),
        Dette(date: '2024-09-20', amount: 1050.0, isPaid: true),
        Dette(date: '2024-09-21', amount: 1100.0, isPaid: false),
        Dette(date: '2024-09-22', amount: 1150.0, isPaid: true),
        Dette(date: '2024-09-23', amount: 1200.0, isPaid: false),
        Dette(date: '2024-09-24', amount: 1250.0, isPaid: true),
        Dette(date: '2024-09-25', amount: 1300.0, isPaid: false),
        Dette(date: '2024-09-26', amount: 1350.0, isPaid: true),
        Dette(date: '2024-09-27', amount: 1400.0, isPaid: false),
        Dette(date: '2024-09-28', amount: 1450.0, isPaid: true),
        Dette(date: '2024-09-29', amount: 1500.0, isPaid: false),
        Dette(date: '2024-09-30', amount: 1550.0, isPaid: true),
        Dette(date: '2024-10-01', amount: 1600.0, isPaid: false),
        Dette(date: '2024-10-02', amount: 1650.0, isPaid: true),
        Dette(date: '2024-10-03', amount: 1700.0, isPaid: false),
        Dette(date: '2024-10-04', amount: 1750.0, isPaid: true),
        Dette(date: '2024-10-05', amount: 1800.0, isPaid: false),
        Dette(date: '2024-10-06', amount: 1850.0, isPaid: true),
      ],
    );

    // Mise à jour du client dans le contrôleur
    clientDetailController.client.value = client;

    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil Client'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              // Utilise `Future.delayed` pour éviter les mises à jour pendant la phase de construction
              Future.delayed(Duration.zero, () {
                Get.to(() => UnpaidDebtsPage());
              });
            },
            child: Text('Voir Dettes Non Soldées'),
          ),
          ElevatedButton(
            onPressed: () {
              // Utilise `Future.delayed` pour éviter les mises à jour pendant la phase de construction
              Future.delayed(Duration.zero, () {
                Get.to(() => PaidDebtsPage());
              });
            },
            child: Text('Voir Dettes Soldées'),
          ),
        ],
      ),
    );
  }
}
