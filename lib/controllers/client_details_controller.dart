import 'package:get/get.dart';
import '../models/Client.dart';
import '../models/Dette.dart';

class ClientDetailController extends GetxController {
  var client = Rx<Client>(Client(
    surname: '',
    phone: '',
    address: '',
    debts: [],
  ));

  // Méthode pour ajouter une dette
  void addDebt(Dette debt) {
    client.update((val) {
      val?.debts.add(debt);
    });
  }

  // Méthode pour marquer une dette comme payée
  void markDebtAsPaid(Dette debt) {
    client.update((val) {
      debt.isPaid = true;
    });
  }

  // Méthode pour obtenir les dettes non payées
  List<Dette> get unpaidDebts {
    return client.value.debts.where((debt) => !debt.isPaid).toList();
  }

  // Méthode pour obtenir les dettes payées
  List<Dette> get paidDebts {
    return client.value.debts.where((debt) => debt.isPaid).toList();
  }
}
