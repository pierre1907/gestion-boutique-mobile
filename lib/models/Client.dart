import 'package:gestion_boutique_mobile/models/CompteUtilisateur.dart';
import 'package:gestion_boutique_mobile/models/Dette.dart';

class Client {
  final int? id;
  final String surname;
  final String phone;
  final String address;
  final double totalDue;
  final bool asAccount;
  late final List<Dette> debts;
  final CompteUtilisateur? compteUtilisateur; // si tu veux l'inclure

  Client({
    this.id,
    required this.surname,
    required this.phone,
    required this.address,
    required this.totalDue,
    this.asAccount = false,
    required List debts,
    this.compteUtilisateur,
  }) : this.debts = debts.map((debt) => Dette.fromJson(debt)).toList();

  // Méthode pour créer un Client à partir d'un JSON
  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      surname: json['surname'],
      phone: json['phone'],
      address: json['address'],
      totalDue: json['totalDue'],
      asAccount: json['asAccount'] ?? false,
      debts: json['debts'],
    );
  }

  // Méthode pour convertir un Client en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'surname': surname,
      'phone': phone,
      'address': address,
      'totalDue': totalDue,
      'asAccount': asAccount,
    };
  }
}
