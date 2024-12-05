import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:enfiletesbasket/services/auth_provider.dart';
import 'package:enfiletesbasket/widgets/custom_text_field.dart';
import 'package:enfiletesbasket/widgets/primary_button.dart';
import 'package:enfiletesbasket/screens/register_screen.dart';
import 'package:enfiletesbasket/screens/reset_password._screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  // États pour gérer les erreurs visuelles
  bool isEmailEmpty = false;
  bool isPasswordEmpty = false;

  Future<void> _login(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    setState(() {
      isEmailEmpty = email.isEmpty;
      isPasswordEmpty = password.isEmpty;
    });

    if (isEmailEmpty || isPasswordEmpty) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await Provider.of<AuthProvider>(context, listen: false).login(email, password);
      print("Connexion réussie !");
      //Navigator.pushReplacementNamed(context, '/home'); // Redirection vers l'écran principal
    } catch (e) {
      print("Erreur de connexion : $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
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
                'Connexion',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 32),

              CustomTextField(
                labelText: 'adresse e-mail *',
                controller: emailController,
                borderColor: isEmailEmpty ? Colors.red : null,
              ),

              const SizedBox(height: 24),

              CustomTextField(
                labelText: 'mot de passe *',
                obscureText: true,
                controller: passwordController,
                borderColor: isPasswordEmpty ? Colors.red : null,
              ),

              const SizedBox(height: 32),
              Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : PrimaryButton(
                  text: 'Se connecter',
                  onPressed: () => _login(context),
                ),
              ),

              const SizedBox(height: 24),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ResetPassword()),
                    );
                  },
                  child: const Text(
                    'mot de passe oublié',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFC8A14E),
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Vous n'avez pas de compte ? ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterScreen()),
                        );
                      },
                      child: const Text(
                        "S'inscrire",
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
