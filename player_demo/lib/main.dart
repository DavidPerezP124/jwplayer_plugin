import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/pages/details_page.dart';
import 'src/pages/home_page.dart';
import 'src/providers/videos_provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => VideoProvider(), lazy: false,)
      ],
      child: MyApp(),
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
          'home': ( _ ) => HomePage(), 
          'details': ( _ ) => DetailsPage(),
        },
        // theme: ThemeData.dark(),
        theme: ThemeData.light()
            .copyWith(appBarTheme: AppBarTheme(color: Colors.black87))
    );
  }
}
