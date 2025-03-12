import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rick_and_morty/features/characters/presentation/controllers/characters_list_screens_controller.dart';


class CharactersItem extends StatefulWidget {
  CharactersItem({super.key, required this.title, required this.imageUrl,
    required this.characterId,
    required this.tag, required this.time, this.isAnimationEnable = false });
  String title, time, imageUrl, tag;
  bool isAnimationEnable;
  final int characterId;

  @override
  State<CharactersItem> createState() => _CharactersItemState();
}

class _CharactersItemState extends State<CharactersItem> {
  late ConfettiController _controllerCenterLeft;


  @override
  void initState() {
    super.initState();
    _controllerCenterLeft =
        ConfettiController(duration: const Duration(seconds: 5));

  }

  @override
  Widget build(BuildContext context) {

    final characterController = Get.find<CharactersListScreensController>();
    return Stack(
      children: [

        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.imageUrl),
            ),
            title: Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: widget.time != "" ? Text('${widget.tag} • ${widget.time}') : Text(widget.tag),
              trailing: Obx(() {

                return IconButton(
                  icon: Icon(
                    characterController.isFavorite(widget.characterId)
                        ? Icons.star
                        : Icons.star_border,
                    color: characterController.isFavorite(widget.characterId)
                        ? Colors.red
                        : Colors.grey,
                  ),
                  onPressed: () {
                    characterController.toggleFavorite(widget.characterId);
                    if(widget.isAnimationEnable && characterController.isFavorite(widget.characterId)){
                      _controllerCenterLeft.play();
                    }

                  },
                );
              })
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: ConfettiWidget(
            confettiController: _controllerCenterLeft,
            blastDirectionality: BlastDirectionality
                .explosive,
            shouldLoop: false,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ],
          ),
        ),
      ],
    );
  }
}
