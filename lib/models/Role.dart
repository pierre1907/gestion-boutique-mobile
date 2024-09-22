class Role {
  final int? id;
  String? name;

  Role({
    this.id,
    this.name,
  });

  // Méthode pour créer un Role à partir d'un JSON
  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
    );
  }

  // Méthode pour convertir un Role en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
