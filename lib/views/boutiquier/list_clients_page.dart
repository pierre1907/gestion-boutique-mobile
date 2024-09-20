import 'package:flutter/material.dart';
import 'package:gestion_boutique_mobile/controllers/client_controllers.dart';
import 'package:gestion_boutique_mobile/views/client/client_details_page.dart';
import 'package:get/get.dart';

class ListClientsPage extends StatelessWidget {
  final ClientController clientController = Get.put(ClientController());

  ListClientsPage() {
    // Appel pour récupérer les clients lors de l'initialisation
    clientController.fetchClients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des clients'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Clients', style: TextStyle(fontSize: 24)),
            Expanded(
              child: Obx(() {
                // Indication de chargement si la liste est vide
                if (clientController.clients.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  itemCount: clientController.clients.length,
                  itemBuilder: (context, index) {
                    final client = clientController.clients[index];
                    return ListTile(
                      title: Text(client.surname),
                      subtitle: Text(client.phone),
                      onTap: () {
                        // Rediriger vers la page de détails du client
                        Get.to(() => ClientDetailsPage(client: client));
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
