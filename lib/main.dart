import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rick_and_morty/core/configs/app_routes.dart';
import 'package:rick_and_morty/features/characters/presentation/screens/characters_list_screens.dart';
import 'package:rick_and_morty/shared/themes/theme_data.dart';
import 'dependencies_injection.dart' as di;
import 'package:flutter/scheduler.dart' show timeDilation;

var isDarkMode = false;

void main() async  {

  WidgetsFlutterBinding.ensureInitialized();
  timeDilation = 3.0;
  await di.init();
  await GetStorage.init();

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _box = GetStorage();
    final initTheme = _box.read("isDarkMode") != null ?
    _box.read("isDarkMode") as bool ? darkTheme : lightTheme : lightTheme;
    isDarkMode = initTheme == darkTheme ;
    return ThemeProvider(
      initTheme: initTheme,
      builder: (_, myTheme) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          theme: myTheme,
          initialRoute: AppRoutes.home,
          getPages: AppRoutes.pages,
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _index = 0;
 final pages = [
   CharactersListScreens(),
   Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {
    final _box = GetStorage();
    return ThemeSwitchingArea(
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Dynamique
          color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor ?? Colors.blueAccent,
          items: <Widget>[
            Icon(Icons.home, size: 30, color: Theme.of(context).iconTheme.color),
            Icon(Icons.favorite, size: 30, color: Theme.of(context).iconTheme.color),
          ],
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
        ),
        appBar: AppBar(
          title: const Text(
            'Flutter Demo Home Page',
          ),
        ),
        body: pages[_index],
        floatingActionButton: ThemeSwitcher.withTheme(
          builder: (_, switcher, theme) {
            return FloatingActionButton(
              onPressed: () {
                _box.write('isDarkMode', !isDarkMode);
                return switcher.changeTheme(
                theme: theme.brightness == Brightness.light
                    ? darkTheme
                    : lightTheme,
                );
                },
              child: Icon(theme.brightness == Brightness.light
                  ? Icons.brightness_3
                  : Icons.wb_sunny),
            );
          },
        ),
      ),
    );
  }
}
