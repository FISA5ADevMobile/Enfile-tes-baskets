import 'package:enfiletesbasket/screens/register_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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

              const CustomTextField(
                labelText: 'adresse e-mail *',
                obscureText: false,
              ),

              const SizedBox(height: 24),

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

              const SizedBox(height: 24),
              Center(
                child: TextButton(
                  onPressed: () {
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
                          MaterialPageRoute(builder: (context) => RegisterScreen()),
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
