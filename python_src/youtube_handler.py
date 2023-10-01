import requests
import json
from key import youtube_api_key as api_key
from key import video_id
from typing import Dict, List

class youtubeHandler:
    def __init__(self):
        self.api_key = api_key
        self.channel_details_url = "https://www.googleapis.com/youtube/v3/channels"
    
    def get_profile_picture_url(self, author_channel_id):
        params = {
            "part": "snippet",
            "id": author_channel_id,
            "key": self.api_key,
        }
        response = requests.get(self.channel_details_url, params=params)

        if response.status_code == 200:
            channel_data = response.json()
            # Extract the profile picture URL from the channel details
            profile_picture_url = channel_data["items"][0]["snippet"]["thumbnails"]["default"]["url"]
            return profile_picture_url
        else:
            return None
    def get_public_username(self, author_channel_id):
        params = {
            "part": "snippet",
            "id": author_channel_id,
            "key": self.api_key,
        }
        response = requests.get(self.channel_details_url, params=params)

        if response.status_code == 200:
            channel_data = response.json()
            # Extract the public username (channel name) from the channel details
            public_username = channel_data["items"][0]["snippet"]["title"]
            return public_username
        else:
            return None
        
    def fetch_live_comments(self,api_key, video_id, page_token=None):
        url = "https://www.googleapis.com/youtube/v3/liveChat/messages"
        
        params = {
            "key": api_key,
            "part": "snippet",
            "liveChatId": self.get_live_chat_id(api_key, video_id),
            "maxResults": 100,
        }
        
        if page_token:
            params["pageToken"] = page_token
        
        response = requests.get(url, params=params)
        
        if response.status_code == 200:
            return json.loads(response.text)
        else:
            return None

    def get_live_chat_id(self,api_key, video_id):
        url = f"https://www.googleapis.com/youtube/v3/videos"
        
        params = {
            "key": api_key,
            "id": video_id,
            "part": "liveStreamingDetails"
        }
        
        response = requests.get(url, params=params)
        
        if response.status_code == 200:
            video_data = json.loads(response.text)
            print(video_data)
            live_chat_id = video_data['items'][0]['liveStreamingDetails']['activeLiveChatId']
            return live_chat_id
        else:
            return None
    def extract_comment_data(self, live_comments_data: Dict) -> List[Dict[str, str]]:
        comment_data_list: List[Dict[str, str]] = []

        if live_comments_data:
            for item in live_comments_data['items']:
                author_channel_id = item['snippet']['authorChannelId']
                public_username = self.get_public_username(author_channel_id)
                profile_picture_url = self.get_profile_picture_url(author_channel_id)
                comment = item['snippet']['displayMessage']

                comment_data: Dict[str, str] = {
                    "user": public_username,
                    "question": comment,
                    "profile_picture_url": profile_picture_url,
                }
                comment_data_list.append(comment_data)

        return comment_data_list

