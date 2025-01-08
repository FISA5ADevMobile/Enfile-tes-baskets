import 'package:flutter/material.dart';
import 'package:enfiletesbasket/services/auth_service.dart';
import 'package:enfiletesbasket/widgets/custom_text_field.dart';
import 'package:enfiletesbasket/widgets/primary_button.dart';
import 'package:enfiletesbasket/utils/validators.dart';
import '../widgets/custom_popup.dart';



class RequestResetPassword extends StatefulWidget {
  const RequestResetPassword({Key? key}) : super(key: key);

  @override
  _RequestResetPasswordState createState() => _RequestResetPasswordState();
}

class _RequestResetPasswordState extends State<RequestResetPassword> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final AuthService authService = AuthService();

  bool isLoading = false;
  bool isEmailEmpty = false;
  bool isEmailInvalid = false;
  bool isCodeEmpty = false;
  bool isCodeInvalid = false;
  bool isReinitError = false;
  Future<void> _validateResetCode(BuildContext context) async {
    final email = emailController.text.trim();
    final code = codeController.text.trim();

    setState(() {
      isCodeEmpty = code.isEmpty;
      isEmailEmpty = email.isEmpty;
      isEmailInvalid = !isEmailEmpty && !Validators.isValidEmail(email);
      isCodeInvalid = false;
      isReinitError = false;
    });

    if (isEmailEmpty || isEmailInvalid || isCodeEmpty) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await authService.validateResetCode(email, code);
      showDialog(
        context: context,
        builder: (context) {
          return CustomPopup(
            title: "Succès",
            description: "Le code a été validé avec succès. Vous pouvez maintenant réinitialiser votre mot de passe.",
            actions: [
              PrimaryButton(
                text: "Ok",
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(context, '/reset-password');
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
                    "L'adresse e-mail est invalide ou utilisateur introuvable.",
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
              const SizedBox(height: 32),

              CustomTextField(
                labelText: 'code *',
                controller: codeController,
                borderColor: (isCodeEmpty) ? Colors.red : null,
              ),
              if (isCodeEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Le code est requis.",
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                )
              else if (isCodeInvalid)
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  "Le code est incorrect.",
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),


    const SizedBox(height: 50),

              Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : PrimaryButton(
                  text: 'Réinitialiser le mot de passe',
                  onPressed: () => _validateResetCode(context),
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
