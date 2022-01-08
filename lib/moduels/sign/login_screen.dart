import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_social_app/layout/home.dart';
import 'package:firebase_social_app/moduels/sign/register_screen.dart';
import 'package:firebase_social_app/shared/components/component.dart';
import 'package:firebase_social_app/shared/cubit/cubit.dart';
import 'package:firebase_social_app/shared/cubit/state.dart';
import 'package:firebase_social_app/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => SocialCubit(),
      child: BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {
            if(state is SuccessUserLogin){
              CacheHelper.saveData(key: 'uId', value: state.uId).then((value){
                moveAndRemove(context, HomeScreen());
              });

            }if(state is FaieldUserLogin){{
            showToast(state.error, ToastState.ERROR);}
            }
          }, builder: (context, state) {
        return Scaffold(
          // appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(children: [
              ClipPath(
                clipper: WaveClipperOne(),
                child: Container(
                  height: 200.0,
                  color: Colors.blue,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'BerthaMelanie',
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      textFieldForm(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        label: 'email',
                        prefix: Icons.email_outlined,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      textFieldForm(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        label: 'password',
                        prefix: Icons.lock,
                        suffix: SocialCubit.get(context).suffix,
                        isPassword: SocialCubit.get(context).isPassword,
                        suffixPressed: () {
                          SocialCubit.get(context).changeVisibilty();
                        },
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'enter correct password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! LoadingUserLogin,
                        builder: (context) => defaultButton(
                          width: double.infinity,
                          background: Colors.blue,
                            function: () {
                              if (formKey.currentState.validate()) {
                                SocialCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            text: 'LOGIN'),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t Have an account?',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterScreen()));
                              },
                              child: const Text(
                                'Create your account...',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        );
      }),
    );
  }
}
