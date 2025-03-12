

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty/features/characters/data/databases/character_database.dart';
import 'package:rick_and_morty/features/characters/data/models/character.dart';
import 'package:rick_and_morty/features/characters/domains/usecases/get_all_characters.dart';

class CharactersListScreensController extends GetxController {
  final GetAllCharacters getAllCharacters = GetIt.instance<GetAllCharacters>();

  final CharacterDatabase characterDatabase = GetIt.instance<CharacterDatabase>();

  var isLoading = false.obs;
  var nextPageUrl = "".obs;

  var characters = <CharacterModel>[].obs;
  var favorites = <int>[].obs;


  @override
  void onInit() {
    super.onInit();
    loadCharacters();
  }



  Future<void> toggleFavorite(int characterId) async {
    if (isFavorite(characterId)) {
      favorites.remove(characterId);
      await characterDatabase.removeFavorite(characterId);
    } else {
      favorites.add(characterId);
      await characterDatabase.addFavorite(characterId);
    }
    update();
  }


  bool isFavorite(int characterId) {
    return favorites.contains(characterId);
  }



  Future<void> loadCharacters() async {
    if (isLoading.value) return;

    isLoading.value = true;
    var data = await getAllCharacters.call();
    var favoritesData = await characterDatabase.getFavorites();

    favorites.assignAll(favoritesData);

    characters.assignAll(data.data);
    nextPageUrl.value = data.nextPage;
    isLoading.value = false;

  }


  void loadNextPage() async {
    if (isLoading.value || nextPageUrl.value.isEmpty) return;
    isLoading.value = true;

    try {
      final result = await getAllCharacters.call(nextPageUrl.value);
      characters.addAll(result.data);
      nextPageUrl.value = result.nextPage;
    } catch (e) {
      print("Erreur : $e");
    }

    isLoading.value = false;
  }

}