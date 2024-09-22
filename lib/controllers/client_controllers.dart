import 'package:get/get.dart';
import 'package:gestion_boutique_mobile/models/Client.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ClientController extends GetxController {
  var clients = <Client>[].obs;

  // Méthode pour ajouter un client localement
  // void addClient(Client client) {
  //   clients.add(client);
  // }

  // Méthode pour récupérer les clients depuis l'API
  Future<void> fetchClients() async {
    final response = await http.get(Uri.parse('http://localhost:8080/clients'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      clients.value =
          jsonResponse.map((client) => Client.fromJson(client)).toList();
    } else {
      throw Exception('Failed to load clients');
    }
  }

  // Future<void> fetchClients() async {
  //   final response =
  //       await http.get(Uri.parse('http://localhost:8080/clients/liste'));

  //   if (response.statusCode == 200) {
  //     try {
  //       // S'assurer que la réponse est complète et valide
  //       String jsonString = response.body;

  //       // Vérifier si la longueur de la réponse est cohérente
  //       if (jsonString.isEmpty || jsonString[jsonString.length - 1] != '}') {
  //         print('Réponse JSON incomplète ou corrompue');
  //       } else {
  //         List jsonResponse = json.decode(jsonString);
  //         clients.value =
  //             jsonResponse.map((client) => Client.fromJson(client)).toList();
  //       }
  //     } catch (e) {
  //       print('Erreur de parsing JSON: $e');
  //     }
  //   } else {
  //     throw Exception('Failed to load clients');
  //   }
  // }

  // Méthode pour créer un client via l'API
  Future<void> createClient(Client newClient) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/clients'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(newClient.toJson()),
    );

    if (response.statusCode == 201) {
      Get.snackbar('Succès', 'Client créé avec succès');
      await fetchClients();
    } else {
      print(
          'Erreur : ${response.statusCode}, ${response.body}');
      Get.snackbar('Erreur', 'Échec de la création du client');
    }
  }

  // Méthode pour filtrer les clients avec ou sans compte
  List<Client> getClientsWithAccount() {
    return clients.where((client) => client.asAccount).toList();
  }

  List<Client> getClientsWithoutAccount() {
    return clients.where((client) => !client.asAccount).toList();
  }
}
