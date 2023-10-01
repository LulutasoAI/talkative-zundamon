import openai
import key
from long_string_data import default_system_message

openai.api_key = key.secret_key
class gptHandler:
    def __init__(self) -> None:
        self.system_message = default_system_message

    def callChatGPT(self,text,user_name):
        # ChatGPTに対して与えた設定に沿った回答を行うように指定
        print("going to call chat gpt")
        completion = openai.ChatCompletion.create(
            model="gpt-3.5-turbo", 
            messages=[
                {"role":"system","content":default_system_message},
                {"role": user_name, "content": text}
                ]
            )
        # ChatGPTからの回答をreturn
        return completion["choices"][0]["message"]["content"]