import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CharacterLoadingIndicator extends StatefulWidget {
  const CharacterLoadingIndicator({super.key});

  @override
  State<CharacterLoadingIndicator> createState() => _CharacterLoadingIndicatorState();
}

class _CharacterLoadingIndicatorState extends State<CharacterLoadingIndicator> {
  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? Colors.red : Colors.green,
          ),
        );
      },
    );
  }
}
