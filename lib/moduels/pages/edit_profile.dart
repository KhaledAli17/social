import 'dart:io';

import 'package:firebase_social_app/shared/components/component.dart';
import 'package:firebase_social_app/shared/cubit/cubit.dart';
import 'package:firebase_social_app/shared/cubit/state.dart';
import 'package:firebase_social_app/shared/styles/icons_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var bioController = TextEditingController();
    var phoneController = TextEditingController();

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImg;
        var coverImage = SocialCubit.get(context).coverImg;
        nameController.text = model.name;
        bioController.text = model.bio;
        phoneController.text = model.phone;
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              TextButton(
                onPressed: () {
                  SocialCubit.get(context).updateUserData(
                      name: nameController.text,
                      bio: bioController.text,
                      phone: phoneController.text);
                },
                child: Text('Update'),
              ),
              SizedBox(
                width: 15.0,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is UpdateUserDataLoading)
                      LinearProgressIndicator(),

                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 160,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(4.0),
                                    topLeft: Radius.circular(4.0),
                                  ),
                                  image: DecorationImage(
                                      image: coverImage == null
                                          ? NetworkImage('${model.cover}')
                                          : FileImage(coverImage),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 20.0,
                                  backgroundColor: Colors.greenAccent,
                                  child: IconButton(
                                      onPressed: () {
                                        SocialCubit.get(context).getCoverImg();
                                      },
                                      icon: Icon(IconBroken.Camera)),
                                ),
                              )
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${model.image}')
                                    : FileImage(profileImage),
                              ),
                            ),
                            CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.greenAccent,
                              child: IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getProfileImg();
                                  },
                                  icon: Icon(IconBroken.Camera)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  if (SocialCubit.get(context).profileImg != null ||
                      SocialCubit.get(context).coverImg != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImg != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                    function: () {
                                      SocialCubit.get(context).uploadProfileImg(
                                          name: nameController.text,
                                          bio: bioController.text,
                                          phone: phoneController.text);
                                    },
                                    text: 'update Image',
                                    width: double.infinity,
                                    isUpper: false,
                                    background: Colors.greenAccent),
                                if (state is UpdateUserProfileImgLoading)
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                if (state is UpdateUserProfileImgLoading)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        SizedBox(
                          width: 10.0,
                        ),
                        if (SocialCubit.get(context).coverImg != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                    function: () {
                                      SocialCubit.get(context).uploadCoverImg(
                                          name: nameController.text,
                                          bio: bioController.text,
                                          phone: phoneController.text);
                                    },
                                    text: 'update Cover',
                                    isUpper: false,
                                    width: double.infinity,
                                    background: Colors.greenAccent),
                                if (state is UpdateUserCoverImgLoading)
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                if (state is UpdateUserCoverImgLoading)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  SizedBox(
                    height: 20.0,
                  ),
                  textFieldForm(
                      controller: nameController,
                      type: TextInputType.name,
                      label: 'Name',
                      prefix: IconBroken.User,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'name must not be empty';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 15.0,
                  ),
                  textFieldForm(
                      controller: bioController,
                      type: TextInputType.text,
                      label: 'Bio',
                      prefix: IconBroken.Info_Circle,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'bio must not be empty';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 15.0,
                  ),
                  textFieldForm(
                      controller: phoneController,
                      type: TextInputType.phone,
                      label: 'Phone',
                      prefix: IconBroken.Call,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Phone must not be empty';
                        }
                        return null;
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
