import 'package:flutter/material.dart';
import 'package:gestion_boutique_mobile/views/boutiquier/boutiquier.page.dart';
import 'package:gestion_boutique_mobile/views/client/client.page.dart';
import 'package:gestion_boutique_mobile/views/home.page.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Bienvenue sur Gestion de boutique',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Accueil'),
            onTap: () {
              Get.to(() => HomePage());
            },
          ),
          ListTile(
            leading: Icon(Icons.store),
            title: Text('Boutiquier'),
            onTap: () {
              Get.to(() => BoutiquierHomePage());
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Client'),
            onTap: () {
              Get.to(() => ClientHomePage());
            },
          ),
        ],
      ),
    );
  }
}
