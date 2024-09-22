import 'package:gestion_boutique_mobile/models/Paiement.dart';
import 'package:gestion_boutique_mobile/models/Client.dart';

class Dette {
  final int? id;
  DateTime date;
  double montant;
  bool isPaid;
  final Client client;
  List<Paiement> paiements;

  Dette({
    this.id,
    required this.date,
    required this.montant,
    this.isPaid = false,
    required this.client,
    List<Paiement>? paiements,
  }) : this.paiements = paiements ?? [];

  // Méthode pour créer une Dette à partir d'un JSON
  factory Dette.fromJson(Map<String, dynamic> json) {
    return Dette(
      id: json['id'],
      date: DateTime.parse(json['date']),
      montant: json['montant'],
      isPaid: json['isPaid'] ?? false,
      client: Client.fromJson(json['client']),
      paiements: (json['paiements'] as List<dynamic>?)
              ?.map((payment) => Paiement.fromJson(payment))
              .toList() ??
          [],
    );
  }

  // Méthode pour convertir une Dette en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(), // Format de date correct
      'montant': montant,
      'isPaid': isPaid,
      'client': client.toJson(),
      'paiements': paiements.map((payment) => payment.toJson()).toList(),
    };
  }

  // Méthode pour obtenir les dates de paiement
  List<DateTime> getDatePaiement() {
    return paiements.map((paiement) => paiement.date).toList();
  }
}
