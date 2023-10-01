import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final String questionerName;
  final String questionText;
  final ImageProvider? iconImage;

  const QuestionWidget({
    Key? key,
    required this.questionerName,
    required this.questionText,
    this.iconImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent, // Set background color to transparent
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(22.0),
      margin: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (iconImage != null)
            CircleAvatar(
              backgroundImage: iconImage,
              radius: 44.0,
              backgroundColor: Colors.grey[200],
            ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  questionerName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  questionText,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
