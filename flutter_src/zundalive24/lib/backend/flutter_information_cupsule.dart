class FlutterInformationCapsule {
  final String text;
  final String question;
  final String questioner;
  final String wavPath;
  final String? emotion;
  final String? image_url;

  FlutterInformationCapsule({
    required this.text,
    required this.question,
    required this.questioner,
    required this.wavPath,
    this.emotion,
    this.image_url,
  });

  factory FlutterInformationCapsule.fromJson(Map<String, dynamic> json) {
    return FlutterInformationCapsule(
      text: json['text'],
      question: json['question'],
      questioner: json['questioner'],
      wavPath: json['wav_path'],
      emotion: json['emotion'],
      image_url: json['image_url'][0],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "question": question,
      "questioner": questioner,
      "wav_path": wavPath,
      "emotion": emotion,
      "image_url": image_url,
    };
  }
}
