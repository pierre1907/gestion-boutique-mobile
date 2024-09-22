import 'package:gestion_boutique_mobile/models/Role.dart';

class CompteUtilisateur {
  final int? id;
  String email;
  String login;
  String password;
  String? photo;
  Role role;

  CompteUtilisateur({
    this.id,
    required this.email,
    required this.login,
    required this.password,
    this.photo,
    Role? role,
  }) : role = role ?? Role(id: 2);

  // Méthode pour créer un Utilisateur à partir d'un JSON
  factory CompteUtilisateur.fromJson(Map<String, dynamic> json) {
    return CompteUtilisateur(
      id: json['id'],
      email: json['email'],
      login: json['login'],
      password: json['password'],
      photo: json['photo'],
      role: Role.fromJson(json['role']),
    );
  }

  // Méthode pour convertir un Utilisateur en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'login': login,
      'password': password,
      'photo': photo,
      'role': role.toJson(),
    };
  }
}
