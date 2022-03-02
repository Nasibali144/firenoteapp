class Post {
  String userId;
  String firstname;
  String lastname;
  String content;
  String date;
  String imgUrl;

  Post(this.userId, this.firstname, this.lastname, this.content, this.date, this.imgUrl);

  Post.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        firstname = json['firstname'],
        lastname = json['lastname'],
        content = json['content'],
        date = json['date'],
        imgUrl = json['imgUrl'];

  Map<String, dynamic> toJson() => {
    'userId' : userId,
    'firstname' : firstname,
    'lastname' : lastname,
    'content' : content,
    'date' : date,
    'imgUrl' : imgUrl,
  };
}