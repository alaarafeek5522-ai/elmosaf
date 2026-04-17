import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:elmosaf/providers/favorites_provider.dart';
import 'package:elmosaf/screens/home_screen.dart';
import 'package:elmosaf/theme/app_theme.dart';

void main() {
  runApp(const ElMosafApp());
}

class ElMosafApp extends StatelessWidget {
  const ElMosafApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavoritesProvider()..loadFavorites(),
      child: MaterialApp(
        title: 'الموسعف - ElMosaf',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const HomeScreen(),
      ),
    );
  }
}
