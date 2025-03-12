import 'package:rick_and_morty/features/characters/data/models/character_response.dart';
import '../models/character.dart';


abstract class CharactersRemoteDataSource {
  Future<CharacterResponse> getAllCharacters(String url);
}

abstract class CharactersLocalDataSource {
  Future<CharacterResponse> getCachedCharacters();
  Future<void> cacheCharacters(List<CharacterModel> characters);
}