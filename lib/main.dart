import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clon/common/routes/routes.dart';
import 'package:whatsapp_clon/common/theme/dark_theme.dart';
import 'package:whatsapp_clon/common/theme/light_theme.dart';
import 'package:whatsapp_clon/feature/auth/controller/auth_controller.dart';
import 'package:whatsapp_clon/feature/home/pages/home_page.dart';
import 'package:whatsapp_clon/feature/welcome/pages/welcome_page.dart';
import 'package:whatsapp_clon/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsAPP Clon',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
      home: ref.watch(userInfoAuthProvider).when(
        data: (user) {
          if (user == null) return const WelcomePage();
          return const HomePage();
        },
        error: (error, trace) {
          return const Scaffold(
            body: Center(
              child: Text('Somthing wrong happened!'),
            ),
          );
        },
        loading: () {
          return const Scaffold(
            body: Center(
              child: Icon(
                Icons.whatshot,
                size: 30,
              ),
            ),
          );
        },
      ),
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
