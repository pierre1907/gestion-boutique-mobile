class CompteUtilisateur {
  final String email;
  final String login;
  final String password;
  

  CompteUtilisateur({
    required this.email,
    required this.login,
    required this.password,
  });

  // Méthode pour convertir un CompteUtilisateur en JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'login': login,
      'password': password,
    };
  }

  // Constructeur pour créer un CompteUtilisateur à partir d'un objet JSON
  factory CompteUtilisateur.fromJson(Map<String, dynamic> json) {
    return CompteUtilisateur(
      email: json['email'],
      login: json['login'],
      password: json['password'],
    );
  }
}
