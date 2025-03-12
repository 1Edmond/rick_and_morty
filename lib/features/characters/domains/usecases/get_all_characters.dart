import 'package:rick_and_morty/core/constants/api_constants.dart';
import 'package:rick_and_morty/features/characters/data/models/character_response.dart';
import 'package:rick_and_morty/features/characters/domains/repositories/characters_repository.dart';

class GetAllCharacters {
  final CharactersRepository repository;


  GetAllCharacters(this.repository);


  Future<CharacterResponse> call([String url = '${ApiConstants.API_LINK}character' ]) async {
    var data = await repository.getAllCharacters(url);
    return data;
  }
}