import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    // Remplace ceci par ta logique d'authentification
    String role = await authenticateUser(
      _emailController.text,
      _passwordController.text,
    );

    if (role == 'admin') {
      Navigator.pushReplacementNamed(context, '/adminDashboard');
    } else if (role == 'user') {
      Navigator.pushReplacementNamed(context, '/userDashboard');
    } else {
      // Gérer l'erreur de connexion
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Connexion')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Se connecter'),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> authenticateUser(String email, String password) async {
    // Logique d'authentification, retourne le rôle de l'utilisateur
    // Exemple : 'admin', 'user', etc.
    return 'user'; // Remplacer par le vrai rôle après authentification
  }
}
