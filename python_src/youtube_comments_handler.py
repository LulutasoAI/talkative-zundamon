class YoutubeCommentsHandler:
    """self.comments_processed,
    self.all_comments"""
    def __init__(self):
        self.comments_processed = []
        self.all_comments = []

    def get_new_comments(self):
        new_comments = self.all_comments
        self.comments_processed.extend(new_comments)
        self.all_comments = []
        return new_comments

    def add_comments(self, new_comments):
        for new_comment in new_comments:
            if new_comment not in self.comments_processed:
                self.all_comments.append(new_comment)
