import 'package:flutter/material.dart';
import 'package:gestion_boutique_mobile/views/boutiquier/create_client_page.dart';
import 'package:get/get.dart';
import 'list_clients_page.dart';

class BoutiquierHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil Boutiquier'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bienvenue, Boutiquier !',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.to(() => ListClientsPage());
              },
              child: Text('Lister les clients'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Get.to(() => CreateClientPage());
              },
              child: Text('Créer un client'),
            ),
          ],
        ),
      ),
    );
  }
}
