import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_social_app/bloc.dart';
import 'package:firebase_social_app/layout/home.dart';
import 'package:firebase_social_app/shared/components/component.dart';
import 'package:firebase_social_app/shared/components/const.dart';
import 'package:firebase_social_app/shared/cubit/cubit.dart';
import 'package:firebase_social_app/shared/cubit/state.dart';
import 'package:firebase_social_app/shared/network/local/cache_helper.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_social_app/moduels/sign/login_screen.dart';
import 'bloc.dart';
import 'package:flutter/material.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
 print('onBackgroundMessaging');
 print(message.data.toString());
 showToast('onBackgroundMessaging', ToastState.SUCCESS);
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  print('token is : ' + token);
// when app is open
  FirebaseMessaging.onMessage.listen((event) {
    print('onMessage');
    print(event.data.toString());
    showToast('onMessage', ToastState.SUCCESS);
  });
 // when click notification
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('onMessageOpenedApp');
    print(event.data.toString());
    showToast('onMessageOpenedApp', ToastState.SUCCESS);
  });
  // when app in background
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  await CacheHelper.init();
  Widget widget;
  uId = CacheHelper.getData(key: 'uId');
  if(uId != null){
    widget = HomeScreen();
  }else{
    widget = LoginScreen();
  }

  BlocOverrides.runZoned(
        () {
      runApp( FirebaseSocialApp(startWidget: widget,));
    },
    blocObserver: MyBlocObserver(),
  );
}

class FirebaseSocialApp extends StatelessWidget {
  const FirebaseSocialApp({Key key, this.startWidget}) : super(key: key);
  final Widget startWidget;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit()..getUserData()..getPosts(),
      child: BlocConsumer<SocialCubit , SocialStates>(
        listener: (context , state){},
        builder: (contex , state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              primarySwatch: kPrimaryColor,
              appBarTheme: const AppBarTheme(
                titleSpacing: 20.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  fontFamily: 'BerthaMelanie',
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),


            ),
            home: startWidget,
          );
        },
      ),
    );
  }
}
