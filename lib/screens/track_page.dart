import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofia/screens/predictor_page.dart';
import 'package:sofia/utils/database.dart';
import 'package:sofia/widget/voice_assistant_button.dart';

/// Widget for displaying the information
/// related to each track, retrieved from the database
class TrackPage extends StatefulWidget {
  final String trackName;
  final String desc;

  TrackPage({@required this.trackName, @required this.desc});

  @override
  _TrackPageState createState() => _TrackPageState();
}

class _TrackPageState extends State<TrackPage> {
  Database database = Database();

  List<Widget> result = [];

  _generatePoseTiles(var screenSize, String poseName, String subName) {
    result.add(
      Container(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(
            left: screenSize.width / 20,
            right: screenSize.width / 20,
            bottom: screenSize.height / 30,
          ),
          child: Card(
            elevation: 3,
            shadowColor: Color(0xFFffc7b8),
            color: Color(0xFFffe5de),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenSize.width / 10),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: screenSize.height / 40,
                bottom: screenSize.height / 40,
                left: screenSize.width / 20,
                right: screenSize.width / 20,
              ),
              child: Padding(
                padding: EdgeInsets.only(left: screenSize.width / 50),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            (poseName + ' pose').toUpperCase(),
                            textAlign: TextAlign.start,
                            style: GoogleFonts.openSans(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: screenSize.height / 80),
                          Text(
                            subName[0].toUpperCase() + subName.substring(1),
                            style: GoogleFonts.montserrat(
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.play_circle_outline,
                      color: Colors.brown[400],
                      size: screenSize.height / 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.trackName.toUpperCase(),
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFFFFF3F0),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black45,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      floatingActionButton: VoiceAssistantButton(),
      body: FutureBuilder(
        future: database.retrievePoses(trackName: widget.trackName),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Widget description() {
              return Container(
                padding: EdgeInsets.only(
                  top: screenSize.height / 80,
                  bottom: screenSize.height / 80,
                  left: screenSize.width / 20,
                  right: screenSize.width / 20,
                ),
                child: Text(
                  widget.desc,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              );
            }

            result.clear();

            result.add(description());

            result.add(
              Padding(
                padding: const EdgeInsets.only(left: 50.0, right: 50, top: 10),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: Color(0xFFffc7b8),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            PredictorPage('surya_namasker.mp4'),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Play All',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown[400],
                          ),
                        ),
                        Icon(
                          Icons.play_arrow,
                          size: 25,
                          color: Colors.brown[400],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
            result.add(SizedBox(height: screenSize.height / 30));

            for (int i = 0; i < snapshot.data.length; i++) {
              String poseName = snapshot.data[i].data['title'];
              String subName = snapshot.data[i].data['sub'];
              _generatePoseTiles(screenSize, poseName, subName);
            }

            return Container(
              color: Color(0xFFFFF3F0),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: result,
              ),
            );
          }

          return Container(
            color: Color(0xFFFFF3F0),
            child: Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                  Color(0xFFffc7b8),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
