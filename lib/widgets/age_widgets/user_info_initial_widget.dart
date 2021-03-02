import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sofia/providers.dart';

class UserInfoInitialWidget extends StatelessWidget {
  final Size screenSize;
  final bool isSelected;
  final String uid;
  final String imageUrl;
  final String userName;
  final String age;
  final String gender;

  const UserInfoInitialWidget({
    Key key,
    @required this.screenSize,
    @required this.isSelected,
    @required this.uid,
    @required this.imageUrl,
    @required this.userName,
    @required this.age,
    @required this.gender,
  }) : super(key: key);

  _uploadData(BuildContext context) {
    context.read(storeUserDataNotifierProvider).storeData(
          uid: uid,
          imageUrl: imageUrl,
          userName: userName,
          age: age,
          gender: gender,
        );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.check_circle,
        size: screenSize.width / 10,
        color: isSelected != null ? Color(0xFFed576a) : Colors.black12,
      ),
      onPressed: isSelected ? _uploadData(context) : null,
    );
  }
}
