import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rick_and_morty/features/characters/data/models/character.dart';
import 'package:rick_and_morty/features/characters/data/sources/character_data_source.dart';
import 'package:rick_and_morty/features/characters/domains/repositories/characters_repository.dart';



class CharactersRepositoryImpl implements CharactersRepository {
  final CharactersRemoteDataSource remoteDataSource;
  final CharactersLocalDataSource localDataSource;

  CharactersRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<CharacterModel>> getAllCharacters() async {
    try {

      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

        final characters = await remoteDataSource.getAllCharacters();

        await localDataSource.cacheCharacters(characters);
        return characters;
      } else {

        return await localDataSource.getCachedCharacters();
      }
    } catch (e) {

      return await localDataSource.getCachedCharacters();
    }
  }
}
