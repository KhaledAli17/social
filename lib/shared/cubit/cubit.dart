import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_social_app/models/chat_model.dart';
import 'package:firebase_social_app/models/comment_model.dart';
import 'package:firebase_social_app/models/post_model.dart';
import 'package:firebase_social_app/models/user_model.dart';
import 'package:firebase_social_app/moduels/bottom_nav_bar/chat.dart';
import 'package:firebase_social_app/moduels/bottom_nav_bar/feeds.dart';
import 'package:firebase_social_app/moduels/bottom_nav_bar/profile.dart';
import 'package:firebase_social_app/moduels/bottom_nav_bar/settings.dart';
import 'package:image_picker/image_picker.dart';
import '../../moduels/pages/new_post.dart';
import 'package:firebase_social_app/shared/components/const.dart';
import 'package:firebase_social_app/shared/cubit/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(InitialState());

// object
  static SocialCubit get(context) => BlocProvider.of(context);
// user login
  void userLogin({
    @required String email,
    @required String password,
  }) {
    emit(LoadingUserLogin());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user.uid);
      print(value.user.email);
      emit(SuccessUserLogin(value.user.uid));
    }).catchError((error) {
      emit(FaieldUserLogin(error.toString()));
    });
  }

// user register
  void userRegister({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  }) {
    emit(LoadingUserRegister());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user.uid);
      print(value.user.email);
      userCreate(name: name, email: email, phone: phone, uId: value.user.uid);
    }).catchError((error) {
      print(error.toString());
      emit(FaieldUserRegister(error.toString()));
    });
  }

// user create
  void userCreate({
    @required String name,
    @required String email,
    @required String phone,
    @required String uId,
    @required String image,
    @required String cover,
    @required String bio,
    @required bool isEmailVerify,
  }) {
    UserModel model = UserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        image:
            'https://image.freepik.com/free-vector/mysterious-mafia-man-smoking-cigarette_52683-34828.jpg',
        cover:
            'https://img.freepik.com/free-photo/lamp-idea-concept-glowing-light-blac_41470-3704.jpg?size=338&ext=jpg',
        bio: 'write your bio...',
        isEmailVerify: false);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SuccessUserCreate());
    }).catchError((error) {
      print(error.toString());
      emit(FaieldUserCreate(error.toString()));
    });
  }

  UserModel userModel;
  // get Data
  void getUserData() {
    emit(LoadingGetUserData());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      //  print(value.data());
      userModel = UserModel.fromJson(value.data());
      emit(SuccessGetUserData());
    }).catchError((error) {
      print(error.toString());
      emit(FaieldGetUserData(error.toString()));
    });
  }

// visible password
  IconData suffix = Icons.visibility;
  bool isPassword = true;
  void changeVisibilty() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(ChangeVisiabilityPassword());
  }

// Bottom Nav Bar
  int currentIndex = 0;

  List<String> titles = [
    "Home",
    "Chat",
    "New Post",
    "Profile",
    "Setting",
  ];
  List<Widget> Screens = [
    FeedScreen(),
    ChatScreen(),
    NewPost(),
    ProfileScreen(),
    SettingsScreen(),
  ];
  void changeNavBar(int index) {
    if (index == 1) {
      getAllUsers();
    }
    if (index == 2) {
      emit(NewPostAdd());
    } else {
      currentIndex = index;
      emit(ChangeBottomNavBar());
    }
  }

// Img Picker
  File profileImg;
  File coverImg;
  File postImage;
  File chatImg;

  //String progileImgUrl = '';
  //String coverImgUrl = '' ;
  var picker = ImagePicker();
// profile Img
  Future<void> getProfileImg() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImg = File(pickedFile.path);
      emit(ChangeProfileImgSuccess());
    } else {
      print('No Image Selected');
      emit(ChangeProfileImgFailed());
    }
  }

// cover Img
  Future<void> getCoverImg() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImg = File(pickedFile.path);
      emit(ChangeCoverImgSuccess());
    } else {
      print('No Image Selected');
      emit(ChangeCoverImgFailed());
    }
  }

// post Img
  Future<void> getPostImg() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(GetPostImgSuccess());
    } else {
      print('No Image Selected');
      emit(GetPostImgFailed());
    }
  }

// chat Img
  Future<void> getChatImg() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      chatImg = File(pickedFile.path);
      emit(GetChatImgSuccess());
    } else {
      print('No Image Selected');
      emit(GetChatImgFailed());
    }
  }

// upload img profile
  void uploadProfileImg({
    @required String name,
    @required String bio,
    @required String phone,
  }) {
    emit(UpdateUserProfileImgLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImg.path).pathSegments.last}')
        .putFile(profileImg)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(UploadProfileImgSuccess());
        // progileImgUrl = value;
        print(value);
        updateUserData(name: name, bio: bio, phone: phone, image: value);
      }).catchError((error) {
        emit(UploadProfileImgFailed());
      });
    }).catchError((error) {
      emit(UploadProfileImgFailed());
    });
  }

// upload img cover
  void uploadCoverImg({
    @required String name,
    @required String bio,
    @required String phone,
  }) {
    emit(UpdateUserCoverImgLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImg.path).pathSegments.last}')
        .putFile(coverImg)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //  emit(UploadCoverImgSuccess());
        // coverImgUrl = value;
        print(value);
        updateUserData(name: name, bio: bio, phone: phone, cover: value);
      }).catchError((error) {
        emit(UploadCoverImgFailed());
      });
    }).catchError((error) {
      emit(UploadCoverImgFailed());
    });
  }

  // update user data
  void updateUser({
    @required String name,
    @required String bio,
    @required String phone,
  }) {
    emit(UpdateUserDataLoading());
    if (coverImg != null) {
      uploadCoverImg();
    } else if (profileImg != null) {
      uploadProfileImg();
    } else {
      updateUserData(name: name, bio: bio, phone: phone);
    }
  }

  // update with imgs
  void updateUserData({
    @required String name,
    @required String bio,
    @required String phone,
    String image,
    String cover,
  }) {
    UserModel model = UserModel(
      name: name,
      bio: bio,
      phone: phone,
      email: userModel.email,
      image: image ?? userModel.image,
      cover: cover ?? userModel.cover,
      uId: userModel.uId,
      isEmailVerify: false,
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      print(error.toString());
      emit(UpdateUserDataFailed());
    });
  }

  void uploadPostImg({
    @required String text,
    @required String dateTime,
  }) {
    emit(CreatePostLoasdingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          text: text,
          dateTime: dateTime,
          postImg: value,
        );
      }).catchError((error) {
        emit(CreatePostFailedState());
      });
    }).catchError((error) {
      emit(CreatePostFailedState());
    });
  }

  void createPost({
    @required String text,
    @required String dateTime,
    String postImg,
  }) {
    PostModel postModel = PostModel(
      name: userModel.name,
      text: text,
      dateTime: dateTime,
      uId: userModel.uId,
      image: userModel.image,
      postImg: postImg ?? '',
    );

    FirebaseFirestore.instance
        .collection("posts")
        .add(postModel.toMap())
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CreatePostFailedState());
    });
  }

  void removePostImg() {
    postImage = null;
    emit(RemovePostImg());
  }
  void removeChatImg() {
    chatImg = null;
    emit(RemovePostImg());
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<UserModel> users = [];

  void getPosts() {
    FirebaseFirestore.instance.collection("posts").get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection("likes").get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {
          emit(GetPostsFailedState(error.toString()));
        });
      });
      emit(GetPostsSuccessState());
    }).catchError((error) {
      emit(GetPostsFailedState(error.toString()));
    });
  }

  void getAllUsers() {
    if (users.length == 0) {
      FirebaseFirestore.instance.collection("users").get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel.uId)
            users.add(UserModel.fromJson(element.data()));
        });
        emit(GetUsersSuccessState());
      }).catchError((error) {
        emit(GetUsersFailedState(error.toString()));
      });
    }
  }

  void getLikes(String postId) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("likes")
        .doc(userModel.uId)
        .set({
      "Likes": true,
    }).then((value) {
      emit(GetPostsLikesSuccessState());
    }).catchError((error) {
      emit(GetPostsLikesFailedState());
    });
  }

  void sendMessage({
    @required String receiverId,
    @required String dateTime,
    @required String text,
  }) {
    ChatModel chatModel = ChatModel(
      text: text,
      dateTime: dateTime,
      receiverId: receiverId,
      senderId: userModel.uId,
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel.uId)
        .collection("chat")
        .doc(receiverId)
        .collection("message")
        .add(chatModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageFailedState());
    });

    FirebaseFirestore.instance
        .collection("users")
        .doc(receiverId)
        .collection("chat")
        .doc(userModel.uId)
        .collection("message")
        .add(chatModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageFailedState());
    });
  }

  List<ChatModel> message = [];
  void getMessage({
    @required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel.uId)
        .collection("chat")
        .doc(receiverId)
        .collection("message")
        .orderBy("dateTime")
        .snapshots()
        .listen((event) {

      message = [];
      event.docs.forEach((element) {
        message.add(ChatModel.fromJson(element.data()));
      });
      emit(ReceiveMessageSuccessState());

    });
  }
  void uploadChatImg({
    String receiverId,
    @required String dateTime,
     String text,
  }) {
    emit(CreateChatLoasdingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('chat/${Uri.file(chatImg.path).pathSegments.last}')
        .putFile(chatImg)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        sendMessage(
            receiverId: receiverId,
            dateTime: dateTime,
            text: text);
      }).catchError((error) {
        emit(CreateChatLoasdingState());
      });
    }).catchError((error) {
      emit(CreateChatLoasdingState());
    });
  }

  void sendComment({
    @required String receiverId,
    @required String dateTime,
    @required String text,
  }) {
    CommentModel commentModel = CommentModel(
      text: text,
      dateTime: dateTime,
      receiverId: receiverId,
      senderId: userModel.uId,
    );
    FirebaseFirestore.instance
        .collection("posts")
        .doc(userModel.uId)
        .collection("comment")
        .add(commentModel.toMap())
        .then((value) {
      emit(SendCommentSuccessState());
    }).catchError((error) {
      emit(SendCommentFailedState());
    });

    FirebaseFirestore.instance
        .collection("posts")
        .doc(receiverId)
        .collection("comment")
        .add(commentModel.toMap())
        .then((value) {
      emit(SendCommentSuccessState());
    }).catchError((error) {
      emit(SendCommentFailedState());
    });
  }

  List<CommentModel> comment = [];
  void getCommentss(String postId) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("comments")
        .doc(userModel.uId)
        .set({
      "comments": "",
    }).then((value) {
      emit(GetCommentsSuccessState());
    }).catchError((error) {
      emit(GetCommentsFailedState());
    });
  }

  void changeEmoji(){
    emit(ChangeEmoji());
  }
  void changeFocus(){
    emit(ChangeFocus());
  }
}
