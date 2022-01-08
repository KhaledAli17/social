
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_social_app/moduels/app_bar/notification.dart';
import 'package:firebase_social_app/moduels/app_bar/search.dart';
import 'package:firebase_social_app/moduels/pages/new_post.dart';
import 'package:firebase_social_app/shared/components/component.dart';
import 'package:firebase_social_app/shared/cubit/cubit.dart';
import 'package:firebase_social_app/shared/cubit/state.dart';
import 'package:firebase_social_app/shared/styles/icons_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(IconBroken.Home , size: 30,),
      const Icon(IconBroken.Chat , size: 30,),
      const Icon(IconBroken.Paper_Plus, size: 30,),
      const Icon(IconBroken.Profile , size: 30,),
      const Icon(IconBroken.Setting , size: 30,),
    ];
    return BlocConsumer<SocialCubit , SocialStates>(
     listener: (context , state){
       if( state is NewPostAdd){
        moveTo(context, const NewPost());
       }
     },
      builder: (context , state){
       var cubit = SocialCubit.get(context);
       return  Scaffold(
         appBar: AppBar(
           title: Text(cubit.titles[cubit.currentIndex]),
           actions: [
             IconButton(
                 onPressed: (){
                   moveTo(context, const SearchScreen());
                 },
                 icon: const Icon(IconBroken.Search)),
             IconButton(
                 onPressed: (){
                   moveTo(context, const NotificationScreen());
                 },
                 icon: const Icon(IconBroken.Notification)),
           ],
         ),
         body:SafeArea(
           bottom: false,
           child: cubit.Screens[cubit.currentIndex],
         ),
         extendBody: true,

         bottomNavigationBar: CurvedNavigationBar(
           height: 60,
           color: Colors.greenAccent,
           backgroundColor: Colors.transparent,
           buttonBackgroundColor: Colors.green,
           items: items,
           index: cubit.currentIndex,
           onTap: (int index){
             cubit.changeNavBar(index);
           },
         ),

       );
      },
    );
  }
}


/*BottomAppBar(
elevation: 0.0,
shape: CircularNotchedRectangle(),
notchMargin: 13.0,
child:  BottomNavigationBar(
elevation: 0.0,
currentIndex: cubit.currentIndex,
onTap: (int index){
cubit.changeNavBar(index);
},
items: [
BottomNavigationBarItem(backgroundColor: Colors.deepPurpleAccent,
icon: Icon(IconBroken.Home),
label: 'Home'),
BottomNavigationBarItem(backgroundColor: Colors.deepPurpleAccent,
icon: Icon(IconBroken.Chat),
label: 'Chat'),
BottomNavigationBarItem(backgroundColor: Colors.deepPurpleAccent,
icon: Icon(IconBroken.Profile),
label: 'Profile'),
BottomNavigationBarItem(backgroundColor: Colors.deepPurpleAccent,
icon: Icon(IconBroken.Setting),
label: 'Setting'),
],
),
),*/

// Email Verify
/*ConditionalBuilder(
condition: SocialCubit.get(context).userModel != null,
builder: (context){
var model = SocialCubit.get(context).userModel;
return Column(
children: [
if(!FirebaseAuth.instance.currentUser.emailVerified)
Container(
width: double.infinity,
color: Colors.amber.withOpacity(0.6),
child: Padding(
padding: const EdgeInsets.symmetric(horizontal: 20.0),
child: Row(
children: [
Icon(Icons.info_outline),
SizedBox(width: 10.0,),
Text(
'please verify your email',
),
Spacer(),
TextButton(
onPressed: (){
FirebaseAuth.instance.currentUser
    .sendEmailVerification()
    .then((value){
showToast('check your email', ToastState.SUCCESS);
})
    .catchError((error){});
},
child: Text(
'send',
)),
],
),
),
),
],


);
},
fallback:(context)=> Center(child: CircularProgressIndicator()),
),*/
