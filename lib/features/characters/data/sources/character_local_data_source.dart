import 'package:rick_and_morty/features/characters/data/sources/character_data_source.dart';
import '../models/character.dart';


class CharactersLocalDataSourceImpl implements CharactersLocalDataSource {




  Future<List<CharacterModel>> getCachedCharacters() async {

    return [];
  }

  @override
  Future<void> cacheCharacters(List<CharacterModel> characters) async {

  }
}
