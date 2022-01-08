
import 'package:firebase_social_app/moduels/pages/edit_profile.dart';
import 'package:firebase_social_app/shared/components/component.dart';
import 'package:firebase_social_app/shared/cubit/cubit.dart';
import 'package:firebase_social_app/shared/cubit/state.dart';
import 'package:firebase_social_app/shared/styles/icons_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
    SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Text('Settings'),
    );
  }
}