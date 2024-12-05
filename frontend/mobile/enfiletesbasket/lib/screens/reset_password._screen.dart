import 'package:enfiletesbasket/screens/login_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({Key? key}) : super(key: key);

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

              const CustomTextField(
                labelText: 'adresse e-mail *',
                obscureText: false,
              ),

              const SizedBox(height: 50),
              Center(
                child: PrimaryButton(
                  text: 'Réinitialiser le mot de passe',
                  onPressed: () {
                  },
                ),
              ),

              const SizedBox(height: 60),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
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
