import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty/features/characters/data/models/character_response.dart';
import 'package:rick_and_morty/features/characters/data/sources/character_data_source.dart';
import '../models/character.dart';


class CharactersRemoteDataSourceImpl implements CharactersRemoteDataSource {
  final http.Client client;

  CharactersRemoteDataSourceImpl({required this.client});

  @override
  Future<CharacterResponse> getAllCharacters(String url) async {
    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      var chractere_response = CharacterResponse();
      chractere_response.nextPage = data['info']['next'];
      chractere_response.data = results.map((character) => CharacterModel.fromJson(character)).toList();
      return chractere_response;
    } else {
      throw Exception('Failed to load characters');
    }
  }
}
