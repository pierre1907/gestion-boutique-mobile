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
