import 'package:rick_and_morty/features/characters/data/models/character.dart';

abstract class CharactersRepository {
  Future<List<CharacterModel>> getAllCharacters();
}
