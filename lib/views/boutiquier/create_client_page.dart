import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gestion_boutique_mobile/controllers/client_controllers.dart';
import 'package:gestion_boutique_mobile/models/Client.dart';
import 'package:gestion_boutique_mobile/models/CompteUtilisateur.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gestion_boutique_mobile/models/Role.dart';

class CreateClientPage extends StatefulWidget {
  @override
  _CreateClientPageState createState() => _CreateClientPageState();
}

class _CreateClientPageState extends State<CreateClientPage> {
  final ClientController clientController = Get.put(ClientController());
  final _formKey = GlobalKey<FormState>();

  final _surnameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  final _emailController = TextEditingController();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String? _photoPath;

  bool hasAccount = false;

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _photoPath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer un client'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Créer un client', style: TextStyle(fontSize: 24)),
              SizedBox(height: 20),
              TextFormField(
                controller: _surnameController,
                decoration: InputDecoration(labelText: 'Nom de famille'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Téléphone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un numéro de téléphone';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Adresse'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une adresse';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: hasAccount,
                    onChanged: (value) {
                      setState(() {
                        hasAccount = value ?? false;
                      });
                    },
                  ),
                  Text('Lier à un compte')
                ],
              ),
              if (hasAccount) ...[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _loginController,
                  decoration: InputDecoration(labelText: 'Login'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un login';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Mot de passe'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un mot de passe';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Choisir une photo'),
                ),
              ],
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Vérification des champs si le client a un compte
                    if (hasAccount &&
                        (_emailController.text.isEmpty ||
                            _loginController.text.isEmpty ||
                            _passwordController.text.isEmpty)) {
                      Get.snackbar('Erreur',
                          'Veuillez remplir tous les champs du compte utilisateur.');
                      return; // Arrête l'exécution si les champs sont vides
                    }

                    // Créer un objet CompteUtilisateur seulement si hasAccount est vrai
                    CompteUtilisateur? compteUtilisateur;

                    if (hasAccount) {
                      compteUtilisateur = CompteUtilisateur(
                        email: _emailController.text,
                        login: _loginController.text,
                        password: _passwordController.text,
                        photo: _photoPath,
                      );
                    }

                    // Créer l'objet Client
                    final newClient = Client(
                      surname: _surnameController.text,
                      phone: _phoneController.text,
                      address: _addressController.text,
                      asAccount: hasAccount,
                      compteUtilisateur: compteUtilisateur,
                      totalDue: 0.0,
                      debts: [],
                    );

                    // Appel à la méthode du contrôleur pour créer le client
                    print(
                        'Données envoyées : ${jsonEncode(newClient.toJson())}');
                    clientController.createClient(newClient);

                    // Réinitialiser le formulaire après la création du client
                    _surnameController.clear();
                    _phoneController.clear();
                    _addressController.clear();
                    _emailController.clear();
                    _loginController.clear();
                    _passwordController.clear();
                    setState(() {
                      hasAccount = false;
                      _photoPath = null;
                    });
                  }
                },
                child: Text('Ajouter le client'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
