import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sofia/providers.dart';
import 'package:sofia/res/palette.dart';
import 'package:sofia/widgets/age_widgets/user_info_initial_widget.dart';

class UserInfoErrorWidget extends StatelessWidget {
  final String errorMessage;
  final Size screenSize;
  final String uid;
  final String imageUrl;
  final String userName;
  final String gender;

  const UserInfoErrorWidget({
    Key key,
    @required this.errorMessage,
    @required this.screenSize,
    @required this.uid,
    @required this.imageUrl,
    @required this.userName,
    @required this.gender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserInfoInitialWidget(
          screenSize: screenSize,
          uid: uid,
          imageUrl: imageUrl,
          userName: userName,
          gender: gender,
        ),
        Text(
          errorMessage,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
            color: Palette.accentDarkPink,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
