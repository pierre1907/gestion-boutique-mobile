import 'package:get/get.dart';
import 'package:gestion_boutique_mobile/models/Client.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ClientController extends GetxController {
  var clients = <Client>[].obs;

  // Méthode pour ajouter un client
  void addClient(Client client) {
    clients.add(client);
  }

  // Méthode pour récupérer les clients depuis l'API
  Future<void> fetchClients() async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/clients/liste'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      clients.value =
          jsonResponse.map((client) => Client.fromJson(client)).toList();
    } else {
      throw Exception('Failed to load clients');
    }
  }

  // Méthode pour filtrer les clients avec ou sans compte
  List<Client> getClientsWithAccount() {
    return clients.where((client) => client.hasAccount).toList();
  }

  List<Client> getClientsWithoutAccount() {
    return clients.where((client) => !client.hasAccount).toList();
  }
}
