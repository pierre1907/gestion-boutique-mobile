import 'package:get/get.dart';

import '../models/Client.dart';

class ClientController extends GetxController {
  // Liste des clients (observable)
  var clients = <Client>[].obs;

  // Méthode pour ajouter un client
  void addClient(Client client) {
    clients.add(client);
  }

  // Méthode pour filtrer les clients avec ou sans compte
  List<Client> getClientsWithAccount() {
    return clients.where((client) => client.hasAccount).toList();
  }

  List<Client> getClientsWithoutAccount() {
    return clients.where((client) => !client.hasAccount).toList();
  }
}
