class PostModel {
  String name;
  String text;
  String dateTime;
  String uId;
  String image;
  String postImg;


  PostModel({
      this.name, this.text, this.dateTime, this.uId, this.image, this.postImg});

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    text = json['text'];
    dateTime = json['dateTime'];
    uId = json['uId'];
    image = json['image'];
    postImg = json['postImg'];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "text": text,
      "dateTime": dateTime,
      "uId": uId,
      "image" : image,
      "postImg" : postImg,

    };
  }
}
