
import 'package:get/get.dart';
import 'package:rick_and_morty/features/characters/data/models/character.dart';

abstract class CharactersScreemInterface extends GetxController {
  Future<void> toggleFavorite(int characterId);
  var favorites = <int>[].obs;
  var characters = <CharacterModel>[].obs;
  var allCharacters = <CharacterModel>[];
  var isLoading = false.obs;
  var pageCount = 10.obs;
  bool isFavorite(int characterId);
  Future<void> loadCharacters();
  Future<void> loadNextPage();
}