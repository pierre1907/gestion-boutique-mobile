import 'package:gestion_boutique_mobile/models/Role.dart';
import 'package:get/get.dart';
import '../models/Client.dart';
import '../models/Dette.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ClientDetailController extends GetxController {
  var client = Rx<Client>(Client(
    id: 0,
    surname: '',
    phone: '',
    address: '',
    debts: [],
    totalDue: 0.0,
  ));

  // Méthode pour ajouter une dette
  void addDebt(Dette debt) {
    client.update((val) {
      val?.debts.add(debt);
    });
  }

  // Méthode pour marquer une dette comme payée
  void markDebtAsPaid(Dette debt) {
    client.update((val) {
      val?.debts.firstWhere((d) => d == debt).isPaid = true;
    });
  }

  // Méthode pour obtenir les dettes non payées
  List<Dette> get unpaidDebts {
    return client.value.debts.where((debt) => !debt.isPaid).toList();
  }

  // Méthode pour obtenir les dettes payées
  List<Dette> get paidDebts {
    return client.value.debts.where((debt) => debt.isPaid).toList();
  }

  // Méthode pour récupérer les détails du client par ID
  Future<void> fetchClientDetails(int id) async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/clients/$id/details'));
    if (response.statusCode == 200) {
      client.value = Client.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load client details');
    }
  }

  // Méthode pour récupérer les dettes d'un client par son ID
  Future<void> fetchDettes(int clientId) async {
    try {
      final response = await http
          .get(Uri.parse('http://localhost:8080/clients/$clientId/dettes'));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        List<Dette> dettes =
            jsonResponse.map((debt) => Dette.fromJson(debt)).toList();

        client.update((val) {
          val?.debts = dettes;
        });
      } else {
        throw Exception('Failed to load dettes');
      }
    } catch (e) {
      print('Error fetching dettes: $e');
    }
  }
}
