import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rick_and_morty/features/characters/data/models/character_response.dart';
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
  Future<CharacterResponse> getAllCharacters(String url) async {
    try {

      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult != ConnectivityResult.none) {

        final characters = await remoteDataSource.getAllCharacters(url);

        await localDataSource.cacheCharacters(characters.data);

        return characters;
      } else {

        return await localDataSource.getCachedCharacters();
      }
    } catch (e) {

      return await localDataSource.getCachedCharacters();
    }
  }
}
