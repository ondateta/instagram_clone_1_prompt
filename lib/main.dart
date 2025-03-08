import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:template/router.dart';
import 'package:template/src/views/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final lightTheme = ThemeData(
      fontFamily: 'Wanted Sans',
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: const Color(0xFF0A84FF),
        primary: const Color(0xFF0A84FF),
        surface: Colors.white,
        onSurface: Colors.black,
        inverseSurface: Colors.black,
        surfaceContainer: const Color(0xFFF1F1F1),
        surfaceTint: Colors.transparent,
        error: Colors.red,
      ),
      scaffoldBackgroundColor: Colors.white,
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(Colors.black),
        ),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      cardTheme: CardTheme(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        color: Color(0xFFF1F1F1),
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
    final darkTheme = ThemeData(
      fontFamily: 'Wanted Sans',
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: const Color(0xFF0A84FF),
        primary: const Color(0xFF0A84FF),
        surface: Colors.black,
        onSurface: Colors.white,
        inverseSurface: Colors.white,
        surfaceContainer: const Color(0xFF181818),
        surfaceTint: Colors.transparent,
        error: Colors.red,
      ),
      scaffoldBackgroundColor: const Color(0xFF000000),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(Colors.white),
        ),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      cardTheme: CardTheme(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        color: Color(0xFF181818),
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
    return AdaptiveTheme(
      debugShowFloatingThemeButton: true,
      initial: AdaptiveThemeMode.system,
      light: lightTheme.copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(
          lightTheme.textTheme,
        ),
      ),
      dark: darkTheme.copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(
          darkTheme.textTheme,
        ),
      ),
      builder: (lightTheme, darkTheme) {
        return MaterialApp.router(
          title: 'Instagram Clone',
          theme: lightTheme,
          darkTheme: darkTheme,
          routerConfig: router,
          builder: (context, child) => GateWay(
            child: child ?? SplashView(),
          ),
        );
      },
    );
  }
}

class GateWay extends StatefulWidget {
  const GateWay({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<GateWay> createState() => _GateWayState();
}

class _GateWayState extends State<GateWay> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}