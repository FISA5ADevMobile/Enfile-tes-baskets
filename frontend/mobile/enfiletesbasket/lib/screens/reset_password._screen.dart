import 'package:flutter/material.dart';
import 'package:enfiletesbasket/services/auth_service.dart';
import 'package:enfiletesbasket/widgets/custom_text_field.dart';
import 'package:enfiletesbasket/widgets/primary_button.dart';
import 'package:enfiletesbasket/widgets/custom_popup.dart';
import 'package:enfiletesbasket/screens/login_screen.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController emailController = TextEditingController();
  final AuthService authService = AuthService();

  bool isLoading = false;
  bool isEmailEmpty = false;

  Future<void> _resetPassword(BuildContext context) async {
    final email = emailController.text.trim();

    setState(() {
      isEmailEmpty = email.isEmpty;
    });

    if (isEmailEmpty) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Appel à la méthode resetPassword
      await authService.resetPassword(email);

      // Affiche une popup de succès
      showDialog(
        context: context,
        builder: (context) {
          return CustomPopup(
            title: "Succès",
            description: "Un lien de réinitialisation a été envoyé à votre adresse e-mail.",
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
      // Affiche une popup d'erreur
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
                'Mot de passe oublié',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 32),

              // Champ e-mail
              CustomTextField(
                labelText: 'adresse e-mail *',
                controller: emailController,
                borderColor: isEmailEmpty ? Colors.red : null,
              ),

              const SizedBox(height: 50),

              // Bouton de réinitialisation ou indicateur de chargement
              Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : PrimaryButton(
                  text: 'Réinitialiser le mot de passe',
                  onPressed: () => _resetPassword(context),
                ),
              ),

              const SizedBox(height: 60),

              // Bouton retour
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
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
