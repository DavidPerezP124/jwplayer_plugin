import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'src/pages/details_page.dart';
import 'src/pages/home_page.dart';
import 'src/providers/videos_provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => VideoProvider(),
          lazy: false,
        )
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Video Demo',
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomePage(),
          'details': (_) => const DetailsPage(),
        },
        // theme: ThemeData.dark(),
        theme: ThemeData.light()
            .copyWith(appBarTheme: const AppBarTheme(color: Colors.black87)));
  }
}
