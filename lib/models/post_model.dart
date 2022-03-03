class Post {
  String userId;
  String username;
  String title;
  String content;
  String date;
  String? imgUrl;

  Post(this.userId, this.username, this.title, this.content, this.date, this.imgUrl);

  Post.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        username = json['username'],
        title = json['title'],
        content = json['content'],
        date = json['date'],
        imgUrl = json['imgUrl'];

  Map<String, dynamic> toJson() => {
    'userId' : userId,
    'username' : username,
    'title' : title,
    'content' : content,
    'date' : date,
    'imgUrl' : imgUrl,
  };
}