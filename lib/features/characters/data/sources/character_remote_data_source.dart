import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty/core/constants/api_constants.dart';
import 'package:rick_and_morty/features/characters/data/sources/character_data_source.dart';
import '../models/character.dart';


class CharactersRemoteDataSourceImpl implements CharactersRemoteDataSource {
  final http.Client client;

  CharactersRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CharacterModel>> getAllCharacters() async {
    final response = await client.get(Uri.parse('${ApiConstants.API_LINK}character'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((character) => CharacterModel.fromJson(character)).toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }
}
