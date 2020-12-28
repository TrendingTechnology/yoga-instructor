import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofia/screens/home_page.dart';
import 'package:sofia/utils/database.dart';

/// Widget for generating the Age Screen,
/// and storing it in the database
class AgePage extends StatefulWidget {
  final String userName;
  final String gender;

  AgePage({@required this.userName, @required this.gender});

  @override
  _AgePageState createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> {
  Database _database = Database();

  String errorString;
  bool _isStoring = false;
  int _selectedAgeGroup;

  List<String> _ageGroupList = ['< 20', '20 - 34', '35+'];
  List<bool> _selectedList = [false, false, false];

  AppBar appBar = AppBar(
    centerTitle: true,
    title: Text(
      '',
      style: TextStyle(color: Colors.deepOrangeAccent[700], fontSize: 30),
    ),
    backgroundColor: Color(0xFFfeafb6),
    elevation: 0,
  );

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  Future<void> _uploadData() async {
    setState(() {
      _isStoring = true;
    });

    await _database.storeUserData(
      userName: widget.userName,
      gender: widget.gender,
      age: _ageGroupList[_selectedAgeGroup],
    );
    _isStoring = false;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return HomePage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar,
      body: Container(
        color: Color(0xFFfeafb6),
        // Color(0xFFffe6e1), --> color for the other cover
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                bottom: screenSize.height / 80,
              ),
              child: Text(
                'QUOTE',
                textAlign: TextAlign.center,
                style: GoogleFonts.lexendTera(
                  fontSize: screenSize.width / 30,
                  color: Colors.black26,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: screenSize.width / 15,
                right: screenSize.width / 15,
                bottom: screenSize.height / 50,
              ),
              child: Text(
                'The yoga pose you avoid the most you need the most.',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  fontSize: screenSize.width / 25,
                  color: Color(0xFF734435),
                ),
              ),
            ),
            Flexible(
              child: SvgPicture.asset(
                'assets/images/intro_3.svg',
                width: screenSize.width,
                semanticsLabel: 'Cover Image',
              ),
            ),
            SizedBox(height: screenSize.height / 50),
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
                        color: _selectedList[0] ? Color(0xFFed576a) : Color(0xFFf1919c),
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
                        color: _selectedList[1] ? Color(0xFFed576a) : Color(0xFFf1919c),
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
                        color: _selectedList[2] ? Color(0xFFed576a) : Color(0xFFf1919c),
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
            SizedBox(height: screenSize.height / 20),
            _isStoring
                ? CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFed576a)),
                  )
                : IconButton(
                    icon: Icon(
                      Icons.check_circle,
                      size: screenSize.width / 10,
                      color: _selectedAgeGroup != null ? Color(0xFFed576a) : Colors.black12,
                    ),
                    onPressed: _selectedAgeGroup != null
                        ? () async {
                            await _uploadData().catchError(
                              (e) => print('UPLOAD ERROR: $e'),
                            );
                          }
                        : null,
                  ),
          ],
        ),
      ),
    );
  }
}
