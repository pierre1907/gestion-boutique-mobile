import 'package:gestion_boutique_mobile/models/Dette.dart';
import 'package:gestion_boutique_mobile/models/compteUtilisateur.dart';

class Client {
  final int? id;
  String surname;
  String phone;
  String address;
  bool hasAccount;
  // String? email;
  // String? login;
  // String? password;
  List<Dette> debts;
  final CompteUtilisateur? compteUtilisateur;

  Client({
    this.id,
    required this.surname,
    required this.phone,
    required this.address,
    this.hasAccount = false,
    // this.email,
    // this.login,
    // this.password,
    List<Dette>? debts,
    this.compteUtilisateur,
  }) : this.debts = debts ?? [];

  // Méthode pour créer un Client à partir d'un JSON
  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      surname: json['surname'],
      phone: json['phone'],
      address: json['address'],
      hasAccount: json['hasAccount'] ?? false,
      // email: json['email'],
      // login: json['login'],
      // password: json['password'],
      debts: (json['debts'] as List<dynamic>?)
              ?.map((debt) => Dette.fromJson(debt))
              .toList() ??
          [],
      compteUtilisateur: json['compteUtilisateur'] != null
          ? CompteUtilisateur.fromJson(json['compteUtilisateur'])
          : null,
    );
  }

  // Méthode pour convertir un Client en JSON

  Map<String, dynamic> toJson() {
    return {
      'surname': surname,
      'phone': phone,
      'address': address,
      'hasAccount': hasAccount,
      'debts': debts.map((debt) => debt.toJson()).toList(),
      'compteUtilisateur': compteUtilisateur?.toJson(),
    };
  }
}
