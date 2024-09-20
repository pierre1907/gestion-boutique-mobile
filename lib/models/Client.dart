import 'package:gestion_boutique_mobile/models/Dette.dart';

class Client {
  final int id;
  String surname;
  String phone;
  String address;
  bool hasAccount;
  String? email;
  String? login;
  String? password;
  String? photo;
  List<Dette> debts;

  Client({
    required this.id,
    required this.surname,
    required this.phone,
    required this.address,
    this.hasAccount = false,
    this.email,
    this.login,
    this.password,
    this.photo,
    List<Dette>? debts,
  }) : this.debts = debts ?? [];

  // Méthode pour créer un Client à partir d'un JSON
  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      surname: json['surname'],
      phone: json['phone'],
      address: json['address'],
      hasAccount: json['hasAccount'] ?? false,
      email: json['email'],
      login: json['login'],
      password: json['password'],
      photo: json['photo'],
      debts: (json['debts'] as List<dynamic>?)
              ?.map((debt) => Dette.fromJson(debt))
              .toList() ??
          [],
    );
  }

  // Méthode pour convertir un Client en JSON

  Map<String, dynamic> toJson() {
    return {
      'surname': surname,
      'phone': phone,
      'address': address,
      'hasAccount': hasAccount,
      'email': email,
      'login': login,
      'password': password,
      'photo': photo,
      'debts': debts.map((debt) => debt.toJson()).toList(),
    };
  }
}
