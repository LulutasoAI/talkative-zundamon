import simpleaudio
import json
import requests
import time
from file_handler import create_folder



class TTSHandler:
    def __init__(self) -> None:
        self.folder_name = "wav_dir"
    def textToVoice(self,text):
        # ファイル名に用いるunix時間取得
        ut = time.time()

        # 音声合成処理
        # audio_query (音声合成用のクエリを作成するAPI)
        res1 = requests.post("http://localhost:50021/audio_query",
                            params={"text": text, "speaker": 1})
        # synthesis (音声合成するAPI)
        res2 = requests.post("http://localhost:50021/synthesis",
                            params={"speaker": 1},
                            data=json.dumps(res1.json()))
        # wavファイルに書き込み
        create_folder(self.folder_name)
        audio_file = f"{self.folder_name}/{ut}.wav"
        with open(audio_file, mode="wb") as f:
            f.write(res2.content)

        return audio_file

    def playWav(self,file):
        with open(file,"rb") as f:
            # wavファイル再生
            wav_obj = simpleaudio.WaveObject.from_wave_file(f)
            play_obj = wav_obj.play()
            play_obj.wait_done()
    
    def speak(self,text):
        # 音声合成
        audio_file = self.textToVoice(text)
        # wavファイル再生
        self.playWav(audio_file)
