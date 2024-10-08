import 'package:flutter/material.dart';
import 'package:gestion_boutique_mobile/controllers/client_controllers.dart';
import 'package:gestion_boutique_mobile/views/auth/LoginPage.dart';
import 'package:gestion_boutique_mobile/views/boutiquier/boutiquier.page.dart';
import 'package:gestion_boutique_mobile/views/client/client.page.dart';
import 'package:gestion_boutique_mobile/views/home.page.dart';
import 'package:get/get.dart';

void main() {
  Get.put(ClientController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Boutique 225',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 6, 2, 255),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomePage()),
        GetPage(name: '/boutiquier', page: () => BoutiquierHomePage()),
        GetPage(name: '/client', page: () => ClientHomePage())
      ],
    );
  }
}
