import 'package:flutter/material.dart';
import 'package:enfiletesbasket/services/auth_service.dart';
import 'package:enfiletesbasket/widgets/custom_text_field.dart';
import 'package:enfiletesbasket/widgets/primary_button.dart';
import 'package:enfiletesbasket/widgets/custom_popup.dart';
import 'package:enfiletesbasket/screens/login_screen.dart';
import 'package:enfiletesbasket/utils/validators.dart';


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
  bool isEmailInvalid = false;

  Future<void> _resetPassword(BuildContext context) async {
    final email = emailController.text.trim();

    setState(() {
      isEmailEmpty = email.isEmpty;
      isEmailInvalid = !isEmailEmpty && !Validators.isValidEmail(email);
    });

    if (isEmailEmpty || isEmailInvalid) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await authService.resetPassword(email);

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
                  Navigator.of(context).pop();
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
                  Navigator.of(context).pop();
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
              Center(
                child: Image.asset(
                  'assets/images/logo_enfiletesbaskets_transparent.png',
                  width: 300,
                  height: 300,
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Mot de passe oublié',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 32),

              CustomTextField(
                labelText: 'adresse e-mail *',
                controller: emailController,
                borderColor: (isEmailEmpty || isEmailInvalid) ? Colors.red : null,
              ),
              if (isEmailEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    "L'adresse e-mail est requise.",
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                )
              else if (isEmailInvalid)
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    "L'adresse e-mail est invalide.",
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),

              const SizedBox(height: 50),

              Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : PrimaryButton(
                  text: 'Réinitialiser le mot de passe',
                  onPressed: () => _resetPassword(context),
                ),
              ),

              const SizedBox(height: 60),

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
