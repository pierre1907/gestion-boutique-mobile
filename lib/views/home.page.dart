import 'package:flutter/material.dart';
import 'package:gestion_boutique_mobile/views/boutiquier/boutiquier.page.dart';
import 'package:gestion_boutique_mobile/views/client/client.page.dart';
import 'package:gestion_boutique_mobile/widgets/btnCustom.dart';
import 'package:gestion_boutique_mobile/widgets/custom_app_bar.dart';
import 'package:gestion_boutique_mobile/widgets/custom_drawer.dart';
import 'package:get/get.dart';
// Import du widget personnalisé

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Accueil'),
      drawer: CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            btnCustom(
              text: 'Accès Boutiquier',
              onPressed: () {
                Get.to(() => BoutiquierHomePage());
              },
            ),
            SizedBox(height: 20),
            btnCustom(
              text: 'Accès Client',
              onPressed: () {
                Get.to(() => ClientHomePage());
              },
            ),
          ],
        ),
      ),
    );
  }
}
