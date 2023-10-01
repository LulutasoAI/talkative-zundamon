class FlutterInformationCapsule:
    def __init__(self, text, question, questioner, wav_path, emotion=None, image_url=None):
        self.text = text
        self.question = question
        self.questioner = questioner
        self.wav_path = wav_path
        self.emotion = emotion
        self.image_url = image_url,

    def __str__(self):
        return f"{self.name}"
    
    def __json__(self):
        return {
            "text": self.text,
            "questioner": self.questioner,
            "question": self.question,
            "wav_path": self.wav_path,
            "emotion": self.emotion,
            "image_url": self.image_url,
            "result" : True,
        }