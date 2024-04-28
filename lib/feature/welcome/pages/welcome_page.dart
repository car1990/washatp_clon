import 'package:flutter/material.dart';
import 'package:whatsapp_clon/common/extension/custom_theme_extension.dart';
import 'package:whatsapp_clon/common/routes/routes.dart';
import 'package:whatsapp_clon/common/utils/coloors.dart';
import 'package:whatsapp_clon/common/widgets/custom_elevated_button.dart';
import 'package:whatsapp_clon/widgets/language_button.dart';
import 'package:whatsapp_clon/widgets/privacy_and_terms.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  navigateToLoginPage(context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      Routes.login,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Coloors.backgroundDark,
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: Image.asset(
                  'assets/images/circle_le.png',
                  color: context.theme.circleImageColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: Column(
              children: [
                Text(
                  'Welcome to WhatsApp',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const PrivacyAndTerms(),
                CustomElevatedButton(
                    onPressed: () => navigateToLoginPage(context),
                    text: 'AGREE AND CONTINUE'),
                const SizedBox(height: 50),
                const LanguageButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
