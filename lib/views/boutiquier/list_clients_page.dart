import 'package:flutter/material.dart';
import 'package:gestion_boutique_mobile/controllers/client_controllers.dart';
import 'package:gestion_boutique_mobile/views/client/client_details_page.dart';
import 'package:get/get.dart';

class ListClientsPage extends StatefulWidget {
  @override
  _ListClientsPageState createState() => _ListClientsPageState();
}

class _ListClientsPageState extends State<ListClientsPage> {
  final ClientController clientController = Get.put(ClientController());
  String filter = 'Tous';

  @override
  void initState() {
    super.initState();
    clientController
        .fetchClients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des clients'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                filter = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'Tous',
                child: Text('Tous les clients'),
              ),
              const PopupMenuItem(
                value: 'AvecCompte',
                child: Text('Clients avec compte'),
              ),
              const PopupMenuItem(
                value: 'SansCompte',
                child: Text('Clients sans compte'),
              ),
            ],
            icon: Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Clients', style: TextStyle(fontSize: 24)),
            Expanded(
              child: Obx(() {
                if (clientController.clients.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                }

                final filteredClients =
                    clientController.clients.where((client) {
                  if (filter == 'AvecCompte') {
                    return client.asAccount == true;
                  } else if (filter == 'SansCompte') {
                    return client.asAccount == false;
                  }
                  return true;
                }).toList();

                return ListView.builder(
                  itemCount: filteredClients.length,
                  itemBuilder: (context, index) {
                    final client = filteredClients[index];
                    return ListTile(
                      title: Text(client.surname),
                      subtitle: Text(client.phone),
                      onTap: () {
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
