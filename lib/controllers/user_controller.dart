import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserController extends GetxController {
  Future<String> authenticateUser(String email, String password) async {
    // Remplace cette URL par l'URL de ton API
    final response =
        await http.get(Uri.parse('https:localhost:8080/api/utilisateurs/all'));

    if (response.statusCode == 200) {
      List<dynamic> users = json.decode(response.body);

      // Rechercher l'utilisateur correspondant à l'email et au mot de passe
      final user = users.firstWhere(
        (user) => user['email'] == email && user['password'] == password,
        orElse: () => {},
      );

      if (user.isEmpty) {
        throw Exception('Identifiants incorrects');
      }

      // Récupérer le rôle
      return user['roles'][0]['name']; // Retourne le nom du premier rôle
    } else {
      throw Exception('Erreur lors de la récupération des utilisateurs');
    }
  }
}
