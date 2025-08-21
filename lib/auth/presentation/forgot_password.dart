import 'package:flutter/material.dart';
import 'package:murza_app/auth/presentation/widgets/welcome_text.dart';
import 'package:murza_app/core/presentation/buttons/app_elevated_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Забыли пароль"),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WelcomeText(
              title: "Восстановление пароля",
              text:
                  "Введите вашу электронную почту и мы отправим вам \nкод с подтверждением для сброса пароля.",
            ),
            SizedBox(height: 16),
            ForgotPassForm(),
          ],
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({super.key});

  @override
  State<ForgotPassForm> createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Email Field
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "Введите вашу электронную почту.";
              }
              return null;
            },
            onSaved: (value) {},
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "Email"),
          ),
          const SizedBox(height: 32),

          AppElevatedButton(
            title: "Сбросить пароль",
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // If all data are correct then save data to out variables
                _formKey.currentState!.save();
              }
            },
          ),
        ],
      ),
    );
  }
}
