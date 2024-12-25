import 'package:doctorapp/pages/Signup.dart';
import 'package:doctorapp/provider/theme_provider.dart';
import 'package:doctorapp/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
    // ChangeNotifierProvider(create: (context) => AuthProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // ThemeMode _themeMode = ThemeMode.light; // Default to light theme

  // void toggleTheme() {
  //   setState(() {
  //     _themeMode =
  //         _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // Get the current theme mode from ThemeProvider
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      theme: themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
      // AppThemes.lightTheme, // Define light theme
      // darkTheme: AppThemes.darkTheme, // Define dark theme
      // themeMode: ThemeMode.dark, // Choose theme mode dynamically
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      home: const SignUp(),
    );
  }
}
