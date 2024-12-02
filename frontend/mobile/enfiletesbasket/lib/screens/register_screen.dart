import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import 'package:enfiletesbasket/screens/login_screen.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
                'Inscription',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 32),

              const CustomTextField(
                labelText: 'pseudo *',
                obscureText: false,
              ),

              const SizedBox(height: 32),

              const CustomTextField(
                labelText: 'adresse e-mail *',
                obscureText: false,
              ),

              const SizedBox(height: 32),

              const CustomTextField(
                labelText: 'mot de passe *',
                obscureText: true,
              ),

              const SizedBox(height: 32),
              Center(
                child: PrimaryButton(
                  text: 'Se connecter',
                  onPressed: () {
                  },
                ),
              ),

              const SizedBox(height: 40),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
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
