import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          'SearchSreen',
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
      ),
    );
  }
}