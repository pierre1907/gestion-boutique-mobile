import 'package:gestion_boutique_mobile/models/Dette.dart';

class Paiement {
  final int? id;
  DateTime date;
  double montant;
  Dette dette;

  Paiement({
    this.id,
    required this.date,
    required this.montant,
    required this.dette,
  });

  // Méthode pour créer un Paiement à partir d'un JSON
  factory Paiement.fromJson(Map<String, dynamic> json) {
    return Paiement(
      id: json['id'],
      date: DateTime.parse(
          json['date']), // Assurez-vous que la date est au format ISO 8601
      montant: json['montant'],
      dette: Dette.fromJson(json['dette']),
    );
  }

  // Méthode pour convertir un Paiement en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': 'yyyy-mm-dd',
      'montant': montant,
      'dette': dette.toJson(),
    };
  }
}
