

import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_social_app/models/user_model.dart';
import 'package:firebase_social_app/moduels/pages/chat_details.dart';
import 'package:firebase_social_app/shared/components/component.dart';
import 'package:firebase_social_app/shared/cubit/cubit.dart';
import 'package:firebase_social_app/shared/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit , SocialStates>(
      listener: (context , state) {},
      builder: (context , state){
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.length > 0,
          builder: (context) =>  ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context , index) => buildChatItem(SocialCubit.get(context).users[index],context),
              separatorBuilder: (context , index) => diverItem(),
              itemCount: SocialCubit.get(context).users.length),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },

    );
  }

  Widget buildChatItem(UserModel model,context) => InkWell(
    onTap: (){
      moveTo(context, ChatDetailsMessage(
        userModel: model,
      ));
    },
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                '${model.image}'),
            radius: 25.0,
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            '${model.name}',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    ),
  );
}

