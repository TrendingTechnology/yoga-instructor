import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:sofia/res/palette.dart';
import 'package:sofia/utils/database.dart';
import 'package:sofia/utils/sign_in.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Database _database = Database();

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    double screeWidth = MediaQuery.of(context).size.width;
    double screeHeight = MediaQuery.of(context).size.height;

    const double POSE_WIDTH_MULT = 0.5;
    const double POSE_HEIGHT_MULT = 0.48;

    const double FAV_WIDTH_MULT = 5.5;
    const double FAV_HEIGHT_MULT = 4.8;

    const double IMAGE_MULT = 0.36;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello, Souvik',
                          style: TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                            color: Palette.black,
                          ),
                        ),
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Container(
                                color: Palette.lightDarkShade,
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Icon(
                                    Icons.person,
                                    color: Palette.lightShade,
                                    size: 26,
                                  ),
                                ),
                              ),
                            ),
                            imageUrl != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: SizedBox(width: 38.0, child: Image.network(imageUrl)),
                                  )
                                : Container(),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Text(
                      'Inhale the future, exhale the past.', // Update the quote from backend
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Palette.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.0),
                  // Your favourites
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Text(
                      'For beginners',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Palette.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  FutureBuilder(
                    future: _database.retrievePoses(trackName: 'beginners'),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          height: screeWidth * POSE_HEIGHT_MULT,
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.length,
                            separatorBuilder: (context, index) => SizedBox(
                              width: 24.0,
                            ),
                            itemBuilder: (_, index) {
                              String poseTitle = snapshot.data[index]['title'];
                              String poseSubtitle = snapshot.data[index]['sub'];

                              return Row(
                                children: [
                                  if (index == 0) SizedBox(width: 16.0),
                                  Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 16.0),
                                        child: Container(
                                          width: screeWidth * POSE_WIDTH_MULT,
                                          decoration: BoxDecoration(
                                            color: Palette.mediumShade,
                                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Center(
                                                    child: SizedBox(
                                                      width: screeWidth * IMAGE_MULT,
                                                      child:
                                                          Image.asset('assets/images/child.png'),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  poseTitle[0].toUpperCase() +
                                                      poseTitle.substring(1) +
                                                      ' pose',
                                                  maxLines: 1,
                                                  softWrap: false,
                                                  overflow: TextOverflow.fade,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Palette.black,
                                                  ),
                                                ),
                                                Text(
                                                  poseSubtitle[0].toUpperCase() +
                                                      poseSubtitle.substring(1),
                                                  maxLines: 1,
                                                  softWrap: false,
                                                  overflow: TextOverflow.fade,
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing: 1,
                                                    color: Palette.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        widthFactor: FAV_WIDTH_MULT,
                                        heightFactor: FAV_HEIGHT_MULT,
                                        alignment: Alignment.bottomRight,
                                        child: ClipOval(
                                          child: Material(
                                            color: Palette.lightDarkShade,
                                            child: InkWell(
                                              splashColor: Palette.lightDarkShade,
                                              child: SizedBox(
                                                width: 38,
                                                height: 38,
                                                child: Center(
                                                  child: Icon(
                                                    Icons.favorite,
                                                    size: 20,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              onTap: () {},
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  if (index == snapshot.data.length - 1) SizedBox(width: 16.0),
                                ],
                              );
                            },
                          ),
                        );
                      }
                      return Container();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
