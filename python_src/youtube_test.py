from youtube_handler import youtubeHandler
from key import youtube_api_key, video_id
import requests
import json
youtube_handler = youtubeHandler()
# Fetch live comments
live_comments_data = youtube_handler.fetch_live_comments(youtube_api_key, video_id)
comment_data_list = youtube_handler.extract_comment_data(live_comments_data)

# Process comment data
for comment_data in comment_data_list:
    print(f"User: {comment_data['user']}")
    print(f"Comment: {comment_data['question']}")

# Process comments (for now, just print them)
if live_comments_data:
    for item in live_comments_data['items']:
        print(item)
        print(item['snippet']['displayMessage'])
        print(youtube_handler.get_public_username(item['snippet']['authorChannelId']))
        

def youtube_test(page_token=None):
    url = "https://www.googleapis.com/youtube/v3/liveChat/messages"
    
    params = {
        "key": youtube_api_key,
        "part": "snippet",
        "liveChatId": youtube_handler.get_live_chat_id(youtube_api_key, video_id),
        "maxResults": 100,
    }
    
    if page_token:
        params["pageToken"] = page_token
    
    response = requests.get(url, params=params)
    print(response)
    if response.status_code == 200:
        return json.loads(response.text)
    else:
        
        return None