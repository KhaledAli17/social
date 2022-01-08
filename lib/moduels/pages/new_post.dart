import 'package:firebase_social_app/shared/components/component.dart';
import 'package:firebase_social_app/shared/cubit/cubit.dart';
import 'package:firebase_social_app/shared/cubit/state.dart';
import 'package:firebase_social_app/shared/styles/icons_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPost extends StatelessWidget {
  const NewPost({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();
    return BlocConsumer<SocialCubit , SocialStates>(
      listener: (context , state){},
      builder:(context , state){
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'New Post',
            actions: [
              TextButton(
                onPressed: () {
                  var now = DateTime.now();
                  if(SocialCubit.get(context).postImage == null){
                    SocialCubit.get(context).createPost(
                        text: textController.text,
                        dateTime: now.toString());
                  }else{
                    SocialCubit.get(context).uploadPostImg(
                        text: textController.text,
                        dateTime: now.toString());
                  }
                },
                child: Text('POST'),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is CreatePostLoasdingState)
                   LinearProgressIndicator(),
                SizedBox(height: 15.0,),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage('${SocialCubit.get(context).userModel.image} '),
                    ),
                    SizedBox(width: 15.0,),
                    Text(
                      '${SocialCubit.get(context).userModel.name}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),

                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'What Happened....',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if(SocialCubit.get(context).postImage != null)
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 150.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0,),
                          image: DecorationImage(
                            image: FileImage(SocialCubit.get(context).postImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: (){
                            SocialCubit.get(context).removePostImg();
                          },
                          icon: Icon(Icons.close)),
                    ],
                  ),
                Row(

                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(IconBroken.Image),
                          SizedBox(width: 5.0,),
                          TextButton(
                            onPressed: () {
                              SocialCubit.get(context).getPostImg();
                            },
                            child: Text('Add Photo'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: (){},
                            child: Text('# Tags'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      } ,

    );
  }
}
