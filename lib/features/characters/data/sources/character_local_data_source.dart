import 'package:rick_and_morty/features/characters/data/databases/character_database.dart';
import 'package:rick_and_morty/features/characters/data/models/character_response.dart';
import 'package:rick_and_morty/features/characters/data/sources/character_data_source.dart';
import '../models/character.dart';


class CharactersLocalDataSourceImpl implements CharactersLocalDataSource {

  final CharacterDatabase localDatabase;

  CharactersLocalDataSourceImpl(this.localDatabase);


  Future<CharacterResponse> getCachedCharacters() async {

    var response = CharacterResponse();
    response.data = await localDatabase.getAllCharacters();
    return response;

  }

  @override
  Future<void> cacheCharacters(List<CharacterModel> characters) async {
   await localDatabase.insertCharacters(characters);
  }
}
