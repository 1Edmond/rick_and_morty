import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/characters/presentation/controllers/characters_fav_list_screens_controller.dart';
import 'package:rick_and_morty/features/characters/presentation/interfaces/characters_screem_interface.dart';
import 'package:rick_and_morty/features/characters/presentation/screens/characters_item.dart';
import 'package:get/get.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_loading_indicator.dart';


class CharactersFavListScreens extends StatefulWidget {
  const CharactersFavListScreens({super.key});

  @override
  State<CharactersFavListScreens> createState() => _CharactersFavListScreensState();
}

class _CharactersFavListScreensState extends State<CharactersFavListScreens> with WidgetsBindingObserver {
  late CharactersScreemInterface characterController;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    characterController = Get.put<CharactersScreemInterface>(
      Charactersfavlistscreenscontroller(),
      tag: 'fav',
    );


    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        await characterController.loadNextPage();
      }
    });


    characterController.loadCharacters();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    if (state == AppLifecycleState.resumed) {
      characterController.loadCharacters();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Obx(() => ListView.builder(
                  controller: scrollController,
                  itemCount: characterController.characters.length,
                  itemBuilder: (context, index) {
                    final character = characterController.characters[index];
                    return CharactersItem(
                      title: character.name,
                      imageUrl: character.image,
                      tag: character.gender,
                      time: character.type,
                      page: "fav",
                      characterId: character.id,
                    );
                  },
                )),
              ),
            ],
          ),
          Obx(() => Visibility(
            visible: !characterController.isLoading.value,
            child: characterController.characters.isEmpty ? Center(
              child: Text("Нет данных", style: TextStyle(fontSize: 25),),
            ) : SizedBox(),
          )),
          Obx(() => Visibility(
            visible: characterController.isLoading.value,
            child: CharacterLoadingIndicator(),
          )),
        ],
      ),
    );
  }
}