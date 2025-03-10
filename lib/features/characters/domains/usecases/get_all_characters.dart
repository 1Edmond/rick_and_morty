import 'package:rick_and_morty/features/characters/data/models/character.dart';
import 'package:rick_and_morty/features/characters/domains/repositories/characters_repository.dart';

class GetAllCharacters {
  final CharactersRepository repository;


  GetAllCharacters(this.repository);


  Future<List<CharacterModel>> call() async {
    return await repository.getAllCharacters();
  }
}