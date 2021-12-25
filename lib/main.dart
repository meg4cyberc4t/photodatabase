import 'package:flutter/material.dart';
import 'package:photodatabase/configs/build_text_theme.dart';
import 'package:photodatabase/screens/create_folder_page.dart';
import 'package:photodatabase/screens/router_page.dart';

void main() {
  // GoogleFonts.config.allowRuntimeFetching = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'photo_database',
      title: 'Photo Database',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      theme: buildTheme(),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => const RouterPage(),
        '/CreateFolderPage': (context) => const CreateFolderPage(),
      },
      // home: const HomePage(),
    );
  }
}
