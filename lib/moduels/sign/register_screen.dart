
import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_social_app/layout/home.dart';
import 'package:firebase_social_app/shared/components/component.dart';
import 'package:firebase_social_app/shared/cubit/cubit.dart';
import 'package:firebase_social_app/shared/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  // bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit(),
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {
          if(state is SuccessUserCreate){
            moveAndRemove(context, HomeScreen());
          }if(state is FaieldUserCreate){
            showToast(state.error, ToastState.ERROR);
          }
        },
        builder: (context, state) {
          return Scaffold(
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

                        children: [
                          const Text(
                            'Register',
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
                            controller: nameController,
                            type: TextInputType.name,
                            label: 'name',
                            prefix: Icons.person,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'enter your name';
                              }
                              return null;
                            },
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
                          textFieldForm(
                            controller: phoneController,
                            type: TextInputType.phone,
                            label: 'phone',
                            prefix: Icons.phone,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your phone';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! LoadingUserRegister,
                            builder: (context) => defaultButton(
                              width: double.infinity,
                              background: Colors.blue,
                                function: () {
                                  if (formKey.currentState.validate()) {
                                    SocialCubit.get(context).userRegister(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text);
                                  }
                                },
                                text: 'Register'),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator()),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Have an account?',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                  onPressed: () {

                                  },
                                  child: const Text(
                                    'login with account',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ))
                            ],
                          ),
                        ]),
                  ),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
