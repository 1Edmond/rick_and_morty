import 'package:get/get.dart';
import 'package:rick_and_morty/features/characters/presentation/screens/characters_list_screens.dart';
import 'package:rick_and_morty/main.dart';


class AppRoutes {
  static const String home = '/';
  static const String favorites = '/favorites';

  static List<GetPage> pages = [
    GetPage(name: home, page: () => MyHomePage()),
    GetPage(name: favorites, page: () => CharactersListScreens()),

  ];
}