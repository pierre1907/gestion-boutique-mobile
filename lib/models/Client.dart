import 'package:gestion_boutique_mobile/models/Dette.dart';

class Client {
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
}
