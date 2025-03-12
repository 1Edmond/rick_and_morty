import 'package:rick_and_morty/features/characters/data/models/character_response.dart';


abstract class CharactersRepository {
  Future<CharacterResponse> getAllCharacters(String url);
}
