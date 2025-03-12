import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty/features/characters/data/databases/character_database.dart';
import 'package:rick_and_morty/features/characters/domains/usecases/get_all_characters.dart';
import 'package:rick_and_morty/features/characters/presentation/interfaces/characters_screem_interface.dart';

class Charactersfavlistscreenscontroller extends CharactersScreemInterface {
  final GetAllCharacters getAllCharacters = GetIt.instance<GetAllCharacters>();
  final CharacterDatabase characterDatabase = GetIt.instance<CharacterDatabase>();


  @override
  bool isFavorite(int characterId) {
    return favorites.contains(characterId);
  }


  @override
  void onInit() {
    super.onInit();
    loadCharacters();
  }

  @override
  void onClose() {
    characters.clear();
    favorites.clear();
    allCharacters.clear();

    super.onClose();
  }

  @override
  Future<void> toggleFavorite(int characterId) async {
    if (isFavorite(characterId)) {
      favorites.remove(characterId);
      await characterDatabase.removeFavorite(characterId);
      await loadCharacters();

    }

  }

  @override
  Future<void> loadCharacters() async {
    if (isLoading.value) return;

    isLoading.value = true;
    var data = await getAllCharacters.call();
    var favoritesData = await characterDatabase.getFavorites();

    favorites.assignAll(favoritesData);
    allCharacters.assignAll(data.data.where((c)=> isFavorite(c.id)));

    allCharacters.sort((a, b) => a.name.compareTo(b.name));
    characters.assignAll(allCharacters.take(pageCount.value));

    isLoading.value = false;

  }



  @override
  Future<void> loadNextPage() async {
    if (isLoading.value || characters.length < pageCount.value ) return;
    isLoading.value = true;

    try {
      var tempData =  allCharacters.skip(characters.length).take(pageCount.value);
      characters.addAll(tempData);
    } catch (e) { }

    isLoading.value = false;
  }
}