import '../models/character.dart';


abstract class CharactersRemoteDataSource {
  Future<List<CharacterModel>> getAllCharacters();
}

abstract class CharactersLocalDataSource {
  Future<List<CharacterModel>> getCachedCharacters();
  Future<void> cacheCharacters(List<CharacterModel> characters);
}