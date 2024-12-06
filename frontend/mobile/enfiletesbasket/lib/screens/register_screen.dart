import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:enfiletesbasket/services/auth_provider.dart';
import 'package:enfiletesbasket/widgets/custom_text_field.dart';
import 'package:enfiletesbasket/widgets/primary_button.dart';
import 'package:enfiletesbasket/screens/login_screen.dart';
import 'package:enfiletesbasket/widgets/custom_popup.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isLoading = false;

  // États pour gérer les erreurs visuelles
  bool isUsernameEmpty = false;
  bool isEmailEmpty = false;
  bool isPasswordEmpty = false;
  bool isConfirmPasswordEmpty = false;
  bool isPasswordMismatch = false;

  // Fonction d'inscription
  Future<void> _register(BuildContext context) async {
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    // Validation des champs
    setState(() {
      isUsernameEmpty = username.isEmpty;
      isEmailEmpty = email.isEmpty;
      isPasswordEmpty = password.isEmpty;
      isConfirmPasswordEmpty = confirmPassword.isEmpty;
      isPasswordMismatch = password != confirmPassword;
    });

    if (isUsernameEmpty || isEmailEmpty || isPasswordEmpty || isConfirmPasswordEmpty || isPasswordMismatch) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Appelle la méthode d'inscription
      await Provider.of<AuthProvider>(context, listen: false).register(
        username: username,
        email: email,
        password: password,
      );

      // Affiche la popup de succès
      showDialog(
        context: context,
        builder: (context) {
          return CustomPopup(
            title: "Inscription réussie",
            description: "Votre compte a été créé avec succès !",
            actions: [
              PrimaryButton(
                text: "Ok",
                onPressed: () {
                  Navigator.of(context).pop(); // Ferme la popup
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Affiche la popup d'erreur
      showDialog(
        context: context,
        builder: (context) {
          return CustomPopup(
            title: "Erreur",
            description: e.toString().replaceFirst("Exception: ", ""),
            actions: [
              PrimaryButton(
                text: "Ok",
                onPressed: () {
                  Navigator.of(context).pop(); // Ferme la popup
                },
              ),
            ],
          );
        },
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo
              Center(
                child: Image.asset(
                  'assets/images/logo_enfiletesbaskets_transparent.png',
                  width: 300,
                  height: 300,
                ),
              ),

              const SizedBox(height: 16),

              // Titre
              const Text(
                'Inscription',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 32),

              // Champ pseudo
              CustomTextField(
                labelText: 'pseudo *',
                controller: usernameController,
                borderColor: isUsernameEmpty ? Colors.red : null,
              ),

              const SizedBox(height: 24),

              // Champ email
              CustomTextField(
                labelText: 'adresse e-mail *',
                controller: emailController,
                borderColor: isEmailEmpty ? Colors.red : null,
              ),

              const SizedBox(height: 24),

              // Champ mot de passe
              CustomTextField(
                labelText: 'mot de passe *',
                obscureText: true,
                controller: passwordController,
                borderColor: isPasswordEmpty ? Colors.red : null,
              ),

              const SizedBox(height: 24),

              // Champ confirmation mot de passe
              CustomTextField(
                labelText: 'confirmer le mot de passe *',
                obscureText: true,
                controller: confirmPasswordController,
                borderColor: isConfirmPasswordEmpty || isPasswordMismatch ? Colors.red : null,
              ),

              if (isPasswordMismatch)
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Les mots de passe ne correspondent pas.",
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),

              const SizedBox(height: 32),

              // Bouton d'inscription ou indicateur de chargement
              Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : PrimaryButton(
                  text: 'S’inscrire',
                  onPressed: () => _register(context),
                ),
              ),

              const SizedBox(height: 40),

              // Lien vers l'écran de connexion
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Vous avez déjà un compte ?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                      child: const Text(
                        "Se connecter",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF0081A1),
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
