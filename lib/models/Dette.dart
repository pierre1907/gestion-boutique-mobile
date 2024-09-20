class Dette {
  String date;
  double amount;
  bool isPaid;

  Dette({
    required this.date,
    required this.amount,
    this.isPaid = false,
  });

  // Méthode pour créer une Dette à partir d'un JSON
  factory Dette.fromJson(Map<String, dynamic> json) {
    return Dette(
      date: json['date'], // Assure-toi que cette clé existe dans le JSON
      amount: json['amount'],
      isPaid: json['isPaid'] ?? false,
    );
  }

  // Méthode pour convertir une Dette en JSON
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'amount': amount,
      'isPaid': isPaid,
    };
  }
}
