import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty/features/characters/data/models/character.dart';
import 'package:rick_and_morty/features/characters/domains/usecases/get_all_characters.dart';
import 'package:rick_and_morty/features/characters/presentation/controllers/characters_list_screens_controller.dart';
import 'package:rick_and_morty/features/characters/presentation/screens/characters_item.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_item_header.dart';
import 'package:get/get.dart';

class CharactersListScreens extends StatefulWidget {
  const CharactersListScreens({super.key});

  @override
  State<CharactersListScreens> createState() => _CharactersListScreensState();
}

class _CharactersListScreensState extends State<CharactersListScreens> {


  @override
  void initState() {
    //_loadCharacters();
    super.initState();
  }

 //
  @override
  Widget build(BuildContext context) {

    final characterController = Get.put(CharactersListScreensController());
    final ScrollController scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        characterController.loadNextPage();
      }
    });

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
              controller: scrollController,
              itemCount: characterController.characters.length + 1,
              itemBuilder: (context, index) {
                if (index < characterController.characters.length) {
                  final character = characterController.characters[index];
                  return CharactersItem(
                    title: character.name,
                    imageUrl: character.image,
                    tag: character.gender,
                    time: character.type,
                    characterId:  character.id,
                  );
                } else {
                  return characterController.isLoading.value
                      ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                      : SizedBox();
                }
              },
            )),
          ),
        ],
      ),
    );

  }
}
