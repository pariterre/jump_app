import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jump_app/screens/terms_and_services_screen.dart';
import 'package:provider/provider.dart';

import '/providers/app_parameters.dart';
import '/providers/biomechanics.dart';
import '/providers/locale_text.dart';
import '/screens/jump_screen.dart';

void main() async {
  // Turn off portrait mode
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final app = AppParameters();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => LocaleText(language: 'Fr')),
          ChangeNotifierProvider(
              create: (ctx) =>
                  Biomechanics(app.jumpDescription.bounds.initial)),
          ChangeNotifierProvider(create: (ctx) => app),
        ],
        child: MaterialApp(
          title: 'Jump app',
          routes: {
            TermsAndServicesScreen.route: (context) =>
                const TermsAndServicesScreen(),
            JumpScreen.route: (context) => const JumpScreen()
          },
          initialRoute: TermsAndServicesScreen.route,
        ));
  }
}
