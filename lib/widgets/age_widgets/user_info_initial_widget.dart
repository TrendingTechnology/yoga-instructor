import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sofia/providers.dart';

class UserInfoInitialWidget extends StatefulWidget {
  final Size screenSize;
  final String uid;
  final String imageUrl;
  final String userName;
  final String gender;

  const UserInfoInitialWidget({
    Key key,
    @required this.screenSize,
    @required this.uid,
    @required this.imageUrl,
    @required this.userName,
    @required this.gender,
  }) : super(key: key);

  @override
  _UserInfoInitialWidgetState createState() => _UserInfoInitialWidgetState();
}

class _UserInfoInitialWidgetState extends State<UserInfoInitialWidget> {
  int _selectedAgeGroup;

  List<String> _ageGroupList = ['< 20', '20 - 34', '35+'];
  List<bool> _selectedList = [false, false, false];

  _uploadData(BuildContext context) {
    context.read(storeUserDataNotifierProvider).storeData(
          uid: widget.uid,
          imageUrl: widget.imageUrl,
          userName: widget.userName,
          age: _ageGroupList[_selectedAgeGroup],
          gender: widget.gender,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  _selectedList = [true, false, false];
                  _selectedAgeGroup = 0;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFf1919c),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    width: 3,
                    color: _selectedList[0]
                        ? Color(0xFFed576a)
                        : Color(0xFFf1919c),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    bottom: 16.0,
                    left: 8.0,
                    right: 8.0,
                  ),
                  child: Text(
                    _ageGroupList[0],
                    style: TextStyle(
                      fontFamily: 'GoogleSans',
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _selectedList = [false, true, false];
                  _selectedAgeGroup = 1;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFf1919c),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    width: 3,
                    color: _selectedList[1]
                        ? Color(0xFFed576a)
                        : Color(0xFFf1919c),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    bottom: 16.0,
                    left: 8.0,
                    right: 8.0,
                  ),
                  child: Text(
                    _ageGroupList[1],
                    style: TextStyle(
                      fontFamily: 'GoogleSans',
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _selectedList = [false, false, true];
                  _selectedAgeGroup = 2;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFf1919c),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    width: 3,
                    color: _selectedList[2]
                        ? Color(0xFFed576a)
                        : Color(0xFFf1919c),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    bottom: 16.0,
                    left: 8.0,
                    right: 8.0,
                  ),
                  child: Text(
                    _ageGroupList[2],
                    style: TextStyle(
                      fontFamily: 'GoogleSans',
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: widget.screenSize.height / 20),
        IconButton(
          icon: Icon(
            Icons.check_circle,
            size: widget.screenSize.width / 10,
            color:
                _selectedAgeGroup != null ? Color(0xFFed576a) : Colors.black12,
          ),
          onPressed:
              _selectedAgeGroup != null ? () => _uploadData(context) : null,
        ),
      ],
    );
  }
}
