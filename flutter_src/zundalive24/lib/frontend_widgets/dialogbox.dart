import 'package:flutter/material.dart';

class VisualNovelDialogueBox extends StatelessWidget {
  final String dialogue;
  final String characterName;

  const VisualNovelDialogueBox({
    Key? key,
    required this.dialogue,
    this.characterName = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.8),
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.all(33.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (characterName.isNotEmpty)
                Text(
                  characterName,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              SizedBox(height: 8.0),
              Text(
                dialogue,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
