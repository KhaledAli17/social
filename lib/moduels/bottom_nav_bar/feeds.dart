import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_social_app/models/comment_model.dart';
import 'package:firebase_social_app/models/post_model.dart';
import 'package:firebase_social_app/shared/cubit/cubit.dart';
import 'package:firebase_social_app/shared/cubit/state.dart';
import 'package:firebase_social_app/shared/styles/icons_font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedScreen extends StatelessWidget {
   FeedScreen({Key key}) : super(key: key);
   var commentController = TextEditingController();
   CommentModel commentModel = CommentModel();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context , state){},
      builder: (context , state){

        return  ConditionalBuilder(
          condition: SocialCubit.get(context).posts.length > 0  ,
          builder: (context)=> SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(

                children: [
                  SizedBox(width : double.infinity),
                  Card(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Image(
                          image: NetworkImage(
                              'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg'),
                          fit: BoxFit.cover,
                          height: 200.0,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Communication with friends',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5.0,
                    margin: EdgeInsets.all(8.0),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index)=> buildItem(SocialCubit.get(context).posts[index] , context, index),
                    itemCount: SocialCubit.get(context).posts.length,

                  ),

                ],
              )
          ),
       fallback: (context) => Center(child: CircularProgressIndicator()),
        );

      },

    );
  }


  Widget buildItem(PostModel model , context , index)=>Card(
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    '${model.image}'),
                radius: 25.0,
              ),
              SizedBox(
                width: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${model.name}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Icon(
                        Icons.check_circle,
                        size: 18.0,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  Text('${model.dateTime}',
                      style: Theme.of(context).textTheme.caption),
                ],
              ),
              Spacer(),
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.more_horiz)),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
              '${model.text} '),
          SizedBox(height: 20.0,),
          /*Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              width: double.infinity,
              child: Wrap(
                children: [
                  Container(
                    height: 25.0,
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text(
                        '#Programming',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      minWidth: 1.0,
                      padding: EdgeInsets.all(0.0),
                    ),
                  ),
                  Container(
                    height: 25.0,
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text(
                        '#Flutter',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      minWidth: 1.0,
                      padding: EdgeInsets.all(0.0),
                    ),
                  ),
                ],
              ),
            ),
          ),*/
          if(model.postImg != "")
             Image(
            image: NetworkImage(
                '${model.postImg}'),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        IconBroken.Heart,
                        color: Colors.red,
                      ),
                      Text('${SocialCubit.get(context).likes[index]}'),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        IconBroken.Chat,
                        color: Colors.grey,
                      ),
                      Text('0 comment'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Container(
            height: 1.0,
            width: double.infinity,
            color: Colors.grey[300],
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            height: 60.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.grey[100],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              '${SocialCubit.get(context).userModel.image}'),
                          radius: 25.0,
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: commentController,
                            decoration: InputDecoration(
                              hintText: 'Write a comment...',
                              border: InputBorder.none,
                            ),

                           ),
                        ),


                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      SocialCubit.get(context).sendComment();
                      commentController.clear();
                    },
                    child: Row(
                      children: [
                        Icon(IconBroken.Send),
                      ],
                    ),
                  ),
                  SizedBox(width: 5.0,),
                  InkWell(
                    onTap: () {
                      SocialCubit.get(context).getLikes(SocialCubit.get(context).postsId[index]);
                    },
                    child: Row(
                      children: [
                        Icon(IconBroken.Heart),
                        Text('Like'),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    margin: EdgeInsets.all(8.0),
  );
}
// SocialCubit.get(context).posts.length > 0  && SocialCubit.get(context).userModel != null,