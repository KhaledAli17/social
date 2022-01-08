class UserModel {
  String name;
  String email;
  String phone;
  String uId;
  String image;
  String cover;
  String bio;
  bool isEmailVerify;

  UserModel({this.name, this.email, this.phone, this.uId, this.image, this.cover,
      this.bio, this.isEmailVerify,});


  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    isEmailVerify = json['isEmailVerify'];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "uId": uId,
      "image" : image,
      "cover" : cover,
      "bio" : bio,
      "isEmailVerify": isEmailVerify,
    };
  }
}
