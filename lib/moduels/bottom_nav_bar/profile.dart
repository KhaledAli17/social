import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_social_app/moduels/pages/edit_profile.dart';
import 'package:firebase_social_app/moduels/sign/login_screen.dart';
import 'package:firebase_social_app/shared/components/component.dart';
import 'package:firebase_social_app/shared/cubit/cubit.dart';
import 'package:firebase_social_app/shared/cubit/state.dart';
import 'package:firebase_social_app/shared/styles/icons_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit , SocialStates>(
      listener: (context , state){},
      builder: (context , state){
        var model = SocialCubit.get(context).userModel;
        AlertDialog alertImgCover = AlertDialog(
          content: Image(
            image: NetworkImage('${model.cover}'),
          fit: BoxFit.cover,),
        );
        AlertDialog alertImgProfile = AlertDialog(
          content: Image(
            image: NetworkImage('${model.image}'),
            fit: BoxFit.cover,),
        );
        return Scaffold(
          body:  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 190,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: InkWell(
                          onTap: (){
                            showDialog(
                                context: context,
                                builder: (context) => alertImgCover);},
                          child: Container(
                            height: 160,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(4.0),
                                topLeft: Radius.circular(4.0),
                              ),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      '${model.cover}'),
                                  fit: BoxFit.cover ),
                            ),

                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 64,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        child: InkWell(
                          onTap: (){
                            showDialog(
                                context: context,
                                builder: (context) => alertImgProfile);
                          },
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage('${model.image}'),
                          ),
                        ),
                      ),
                    ],

                  ),
                ),
                SizedBox(height: 5.0,),
                Text(
                  '${model.name}',
                  style: Theme.of(context).textTheme.bodyText1,),
                Text(
                  '${model.bio}',
                  style: Theme.of(context).textTheme.caption,),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text('100',
                                style: Theme.of(context).textTheme.subtitle2,),
                              Text('Post',
                                style: Theme.of(context).textTheme.caption,),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text('500',
                                style: Theme.of(context).textTheme.subtitle2,),
                              Text('Photo',
                                style: Theme.of(context).textTheme.caption,),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text('30k',
                                style: Theme.of(context).textTheme.subtitle2,),
                              Text('Followers',
                                style: Theme.of(context).textTheme.caption,),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            children: [
                              Text('500',
                                style: Theme.of(context).textTheme.subtitle2,),
                              Text('Following',
                                style: Theme.of(context).textTheme.caption,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(onPressed: (){},
                          child: Text('Add Photos')),
                    ),
                    SizedBox(width: 10.0,),
                    OutlinedButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          moveAndRemove(context, LoginScreen());
                        },
                        child: Text('LogOut')),

                    SizedBox(width: 10.0,),
                    OutlinedButton(
                        onPressed: (){
                          moveTo(context, EditProfile());
                        },
                        child: Icon(
                          IconBroken.Edit,
                          size: 16,
                        )),
                  ],
                ),
              ],
            ),
          ),
        );
      },

    );
  }
}