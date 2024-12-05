import 'package:flutter/material.dart';
import 'package:enfiletesbasket/services/auth_service.dart';
import 'package:enfiletesbasket/widgets/custom_text_field.dart';
import 'package:enfiletesbasket/widgets/primary_button.dart';
import 'package:enfiletesbasket/screens/login_screen.dart';

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
  bool isEmailEmpty = false;
  bool isPasswordEmpty = false;
  bool isConfirmPasswordEmpty = false;
  bool isPasswordMismatch = false;

  Future<void> _resetPassword() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    setState(() {
      isEmailEmpty = email.isEmpty;
      isPasswordEmpty = password.isEmpty;
      isConfirmPasswordEmpty = confirmPassword.isEmpty;
      isPasswordMismatch = password != confirmPassword;
    });

    if (isEmailEmpty || isPasswordEmpty || isConfirmPasswordEmpty || isPasswordMismatch) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await authService.resetPassword(email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Un lien de réinitialisation a été envoyé à votre adresse e-mail."),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } catch (e) {
      print("Erreur lors de la réinitialisation : $e");
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
                borderColor: isEmailEmpty ? Colors.red : null,
              ),

              const SizedBox(height: 24),

              CustomTextField(
                labelText: 'Nouveau mot de passe *',
                controller: passwordController,
                obscureText: true,
                borderColor: isPasswordEmpty ? Colors.red : null,
              ),

              const SizedBox(height: 24),

              CustomTextField(
                labelText: 'Confirmer le mot de passe *',
                controller: confirmPasswordController,
                obscureText: true,
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

              const SizedBox(height: 50),
              Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : PrimaryButton(
                  text: 'Réinitialiser le mot de passe',
                  onPressed: _resetPassword,
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
