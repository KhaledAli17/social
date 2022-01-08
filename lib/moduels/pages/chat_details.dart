import 'package:conditional_builder/conditional_builder.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:firebase_social_app/models/chat_model.dart';
import 'package:firebase_social_app/models/user_model.dart';
import 'package:firebase_social_app/shared/components/component.dart';
import 'package:firebase_social_app/shared/cubit/cubit.dart';
import 'package:firebase_social_app/shared/cubit/state.dart';
import 'package:firebase_social_app/shared/styles/icons_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

class ChatDetailsMessage extends StatelessWidget {
  ChatDetailsMessage({Key key, this.userModel}) : super(key: key);

  UserModel userModel = UserModel();
  var messageController = TextEditingController();
  bool show = false;
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessage(receiverId: userModel.uId);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {
            focusNode.addListener(() {
              if(focusNode.hasFocus){
                show = false;
                SocialCubit.get(context).changeFocus();
              }
            });

          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('${userModel.image}'),
                      radius: 25.0,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      '${userModel.name}',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).message.length >= 0,
                builder: (context) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0,),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                var message =
                                    SocialCubit.get(context).message[index];
                                if (SocialCubit.get(context).userModel.uId ==
                                    message.senderId)
                                  return buildMyMessage(message);
                                return buildMessage(message);
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 15.0,
                                  ),
                              itemCount: SocialCubit.get(context).message.length),
                        ),
                      ),

                      WillPopScope(
                        onWillPop: (){
                          if(show){
                            show = false;
                            SocialCubit.get(context).changeEmoji();
                          }else{
                            Navigator.pop(context);
                          }
                          return Future.value(false);
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.grey[300],
                              ),
                              child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          focusNode.unfocus();
                                          focusNode.canRequestFocus = false;
                                          show = !show;
                                          SocialCubit.get(context).changeEmoji();
                                        },
                                        icon: Icon(Icons.emoji_emotions_sharp),
                                        color: Colors.black54,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: TextFormField(
                                            focusNode: focusNode ,
                                            controller: messageController,
                                            decoration: InputDecoration(
                                              hintText: 'write your message',
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () async {

                                          },
                                          icon: Icon(IconBroken.Image)),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(15.0),
                                              bottomRight: Radius.circular(15.0)),
                                          color: Colors.greenAccent,
                                        ),
                                        child: MaterialButton(
                                          minWidth: 1.0,
                                          onPressed: () {
                                            var now = DateTime.now();
                                            if (SocialCubit.get(context).chatImg ==
                                                null) {
                                              SocialCubit.get(context).sendMessage(
                                                  receiverId: userModel.uId,
                                                  dateTime: DateTime.now().toString(),
                                                  text: messageController.text);
                                            } else {
                                              SocialCubit.get(context).uploadChatImg(
                                                  dateTime: now.toString());
                                            }
                                            messageController.clear();
                                          },
                                          child: Icon(
                                            IconBroken.Send,
                                            size: 16.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                            ),
                            show ? emojiSelected(context) : Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      },
    );
  }

  Widget emojiSelected(context) {

    return  EmojiPicker(
          rows: 4,
          columns: 7,
          onEmojiSelected: (emoji, category) {
            print(emoji);
            messageController.text = messageController.text + emoji.emoji;
          });
  }

  Widget buildMessage(ChatModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          child: Text(model.text),
        ),
      );

  Widget buildMyMessage(ChatModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          child: Text(model.text),
        ),
      );
}
//if(model.image != "")
//Image(image: NetworkImage('${model.image}'))
