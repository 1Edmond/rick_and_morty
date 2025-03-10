// lib/features/characters/di/characters_injection.dart

import 'package:get_it/get_it.dart';
import 'package:rick_and_morty/features/characters/data/repositories/characters_repository_impl.dart';
import 'package:rick_and_morty/features/characters/data/sources/character_data_source.dart';
import 'package:rick_and_morty/features/characters/data/sources/character_local_data_source.dart';
import 'package:rick_and_morty/features/characters/data/sources/character_remote_data_source.dart';
import 'package:rick_and_morty/features/characters/domains/repositories/characters_repository.dart';
import 'package:rick_and_morty/features/characters/domains/usecases/get_all_characters.dart';
import 'package:http/http.dart' as http;

final GetIt getIt = GetIt.instance;

Future<void> init() async  {

  getIt.registerLazySingleton<http.Client>(() => http.Client());

  getIt.registerLazySingleton<CharactersLocalDataSource>(
        () => CharactersLocalDataSourceImpl(),
  );

  getIt.registerLazySingleton<CharactersRemoteDataSource>(
        () => CharactersRemoteDataSourceImpl(client: getIt<http.Client>()),
  );


  getIt.registerLazySingleton<CharactersRepository>(
        () => CharactersRepositoryImpl(
      localDataSource: getIt<CharactersLocalDataSource>(),
      remoteDataSource: getIt<CharactersRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<GetAllCharacters>(
        () => GetAllCharacters(getIt<CharactersRepository>()),
  );
}
