import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:enfiletesbasket/services/auth_provider.dart';
import 'package:enfiletesbasket/widgets/custom_text_field.dart';
import 'package:enfiletesbasket/widgets/primary_button.dart';
import 'package:enfiletesbasket/widgets/custom_popup.dart';
import 'package:enfiletesbasket/utils/validators.dart';

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
  bool isUsernameEmpty = false;
  bool isEmailEmpty = false;
  bool isEmailInvalid = false;
  bool isPasswordEmpty = false;
  bool isConfirmPasswordEmpty = false;
  bool isPasswordMismatch = false;
  bool isPasswordNotSecure = false;

  Future<void> _register(BuildContext context) async {
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    setState(() {
      isUsernameEmpty = username.isEmpty;
      isEmailEmpty = email.isEmpty;
      isEmailInvalid = !isEmailEmpty && !Validators.isValidEmail(email);
      isPasswordEmpty = password.isEmpty;
      isConfirmPasswordEmpty = confirmPassword.isEmpty;
      isPasswordNotSecure = !isPasswordEmpty && !Validators.isSecurePassword(password);
      isPasswordMismatch = !isConfirmPasswordEmpty && password != confirmPassword;
    });

    if (isUsernameEmpty ||
        isEmailEmpty ||
        isEmailInvalid ||
        isPasswordEmpty ||
        isConfirmPasswordEmpty ||
        isPasswordMismatch ||
        isPasswordNotSecure) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await Provider.of<AuthProvider>(context, listen: false).register(
        username: username,
        email: email,
        password: password,
      );

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
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(context, '/login');
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
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
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
                'Inscription',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),

              CustomTextField(
                labelText: 'pseudo *',
                controller: usernameController,
                borderColor: isUsernameEmpty ? Colors.red : null,
              ),
              if (isUsernameEmpty)
                const Text(
                  "Le pseudo est requis.",
                  style: TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 24),

              CustomTextField(
                labelText: 'adresse e-mail *',
                controller: emailController,
                borderColor: (isEmailEmpty || isEmailInvalid) ? Colors.red : null,
              ),
              if (isEmailEmpty)
                const Text(
                  "L'adresse e-mail est requise.",
                  style: TextStyle(color: Colors.red),
                )
              else if (isEmailInvalid)
                const Text(
                  "L'adresse e-mail est invalide.",
                  style: TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 24),

              CustomTextField(
                labelText: 'mot de passe *',
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
                labelText: 'confirmer le mot de passe *',
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

              const SizedBox(height: 32),

              Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : PrimaryButton(
                  text: 'S’inscrire',
                  onPressed: () => _register(context),
                ),
              ),
              const SizedBox(height: 40),

              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Vous avez déjà un compte ?",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
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
