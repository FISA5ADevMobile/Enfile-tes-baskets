import 'package:flutter/material.dart';
import 'package:enfiletesbasket/services/auth_service.dart';
import 'package:enfiletesbasket/widgets/custom_text_field.dart';
import 'package:enfiletesbasket/widgets/primary_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/validators.dart';
import '../widgets/custom_popup.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final AuthService authService = AuthService();

  bool isLoading = false;
  bool isPasswordEmpty = false;
  bool isConfirmPasswordEmpty = false;
  bool isPasswordMismatch = false;
  bool isPasswordNotSecure = false;

  @override
  void initState() {
    super.initState();
    _loadEmail();
  }

  Future<void> _loadEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final storedEmail = prefs.getString('reset_email');
    print(storedEmail);
    if (storedEmail != null) {
      emailController.text = storedEmail;
    } else {
      emailController.text = 'Adresse e-mail introuvable';
    }
    setState(() {});
  }

  Future<void> _validatePassword(BuildContext context) async {
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    setState(() {
      isPasswordEmpty = password.isEmpty;
      isConfirmPasswordEmpty = confirmPassword.isEmpty;
      isPasswordNotSecure = !isPasswordEmpty && !Validators.isSecurePassword(password);
      isPasswordMismatch = !isConfirmPasswordEmpty && password != confirmPassword;
    });

    if (isPasswordEmpty || isConfirmPasswordEmpty || isPasswordNotSecure || isPasswordMismatch) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final code = prefs.getString('reset_code');
      if (code != null) {
        await authService.resetPassword(emailController.text, password, code);
        showDialog(
          context: context,
          builder: (context) {
            return CustomPopup(
              title: "Succès",
              description: "Votre mot de passe a été réinitialisé avec succès !",
              actions: [
                PrimaryButton(
                  text: "Ok",
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                ),
              ],
            );
          },
        );
      } else {
        throw Exception("Aucun code de réinitialisation trouvé.");
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Erreur"),
            content: Text(e.toString().replaceFirst("Exception: ", "")),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Ok"),
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
              Center(
                child: Image.asset(
                  'assets/images/logo_enfiletesbaskets_transparent.png',
                  width: 300,
                  height: 300,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Réinitialisation du mot de passe',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Adresse e-mail',
                  border: OutlineInputBorder(),
                  filled: true,
                  enabled: false,
                ),
              ),
              const SizedBox(height: 24),
              CustomTextField(
                labelText: 'Mot de passe *',
                obscureText: true,
                controller: passwordController,
                borderColor: (isPasswordEmpty || isPasswordNotSecure) ? Colors.red : null,
              ),
              if (isPasswordEmpty)
                const Text(
                  "Le mot de passe est requis.",
                  style: TextStyle(color: Colors.red),
                )
              else if (isPasswordNotSecure)
                const Text(
                  "Le mot de passe doit contenir au moins 8 caractères, une majuscule, une minuscule, un chiffre et un symbole.",
                  style: TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 24),
              CustomTextField(
                labelText: 'Confirmer le mot de passe *',
                obscureText: true,
                controller: confirmPasswordController,
                borderColor: (isConfirmPasswordEmpty || isPasswordMismatch) ? Colors.red : null,
              ),
              if (isConfirmPasswordEmpty)
                const Text(
                  "La confirmation du mot de passe est requise.",
                  style: TextStyle(color: Colors.red),
                )
              else if (isPasswordMismatch)
                const Text(
                  "Les mots de passe ne correspondent pas.",
                  style: TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 50),
              Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : PrimaryButton(
                  text: 'Réinitialiser le mot de passe',
                  onPressed: () => _validatePassword(context),
                ),
              ),
              const SizedBox(height: 60),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text(
                    'Retour',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFC8A14E),
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
