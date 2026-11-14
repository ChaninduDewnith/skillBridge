import 'package:material_ui/material_ui.dart';

import 'landing_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: LC.bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: LC.violet,
          brightness: Brightness.dark,
        ),
      ),
      home: const LandingScreen(),
    );
  }
}
