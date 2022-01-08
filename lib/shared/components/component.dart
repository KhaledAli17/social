import 'package:firebase_social_app/shared/styles/icons_font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// text form field
Widget textFieldForm({
  @required TextEditingController controller,
  @required TextInputType type,
  @required String label,
  @required IconData prefix,
  @required Function validate,
  Function onTap,
  IconData suffix,
  Function onSubmit,
  Function suffixPressed,
  bool isPassword = false,
  bool obsecure = true,
}) =>
    TextFormField(
      decoration: InputDecoration(
        labelStyle: TextStyle(color: Colors.grey),
        labelText: label,
        prefixIcon: Icon(
          prefix,
          color:Color(0xff69A03A) ,
        ),
        suffixIcon: suffix != null
            ? IconButton(
            onPressed:
              suffixPressed
            ,
            icon: Icon(
              suffix,
              color:Color(0xff69A03A) ,
            ))
            : null,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Color(0xff69A03A),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            25.0,
          ),
          borderSide: const BorderSide(
            color: Color(0xff69A03A),
          ),
        ),
      ),
      keyboardType: type,
      validator: validate ,
      controller: controller,
      onTap: onTap,
      onFieldSubmitted: onSubmit,
      obscureText: isPassword,
    );

// default button
Widget defaultButton({
  double width ,
  bool isUpper = true,
  Color background,
  @required Function function,
  @required String text,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed:function,

        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: background,
      ),
    );

// Default AppBar
Widget defaultAppBar({
  @required BuildContext context,
  String title,
  List<Widget> actions,
}) => AppBar(
  leading: IconButton(
    onPressed: (){
      Navigator.pop(context);
    },
    icon: Icon(IconBroken.Arrow___Left_2),
  ),
  title: Text(title),
  actions: actions,
);

// move in app
void moveAndRemove(context , widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context)=> widget),
        (route) => false);
void moveTo(context , widget) => Navigator.push(context, MaterialPageRoute(builder: (context)=> widget));

// toast

void showToast(
    @required String text,
    @required ToastState state,
    ){
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}
 enum ToastState  {SUCCESS , ERROR , WARNING}

 Color chooseToastColor(ToastState toastState){
   Color color;
   switch(toastState){
     case ToastState.SUCCESS:
      color = Colors.green;
      break;

     case ToastState.ERROR:
       color = Colors.red;
       break;
     case ToastState.WARNING:
       color = Colors.amber;
       break;
   }
   return color;
 }
 Widget diverItem() => Padding(
   padding: const EdgeInsets.only(left: 15.0, right: 15.0),
   child: Container(
     height: 1.0,
     width: double.infinity,
     color: Colors.grey[300],
   ),
 );
