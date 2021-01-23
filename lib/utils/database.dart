import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'sign_in.dart';

class Database {
  List<String> tracks = [
    'beginners',
    'power yoga',
    // 'morning workout',
    'immunity booster',
    'yoga in pregnancy',
    'insomnia',
    'cardiovascular yoga',
    'yoga for migraine',
    'yoga for asthma',
  ];

  Map<String, List<Set<String>>> poses = {
    'beginners': [
      {'mountain', 'tadasana'},
      {'tree', 'vrikshasana'},
      {'downward facing dog', 'adho mukha svanasana'},
      {'triangle', 'trikonasana'},
      {'cobra', 'bhujangasana'},
      {'child', 'shishuasana'},
      {'easy', 'sukhasana'},
    ],
    'power yoga': [
      {'half moon', 'ardha chandrasana'},
      {'boat', 'paripurna navasana'},
      {'camel', 'ustrasana'},
      {'locust', 'salabhasana'},
      {'plank', 'chaturanga dandasana'},
      {'downward facing dog', 'adho mukha svanasana'},
      {'chair', 'utkatasana'}
    ],
    // 'morning workout': [
    //   {'mountain', 'tadasana'},
    //   {'upward salute', 'urdhva hastasana'},
    //   {'standing forward bend', 'hastapadasana'},
    //   {'low lunge', 'anjaneyasana'},
    //   {'plank', 'phalakasana'},
    //   {'four-limbed staff', 'chaturanga dandasana'},
    //   {'upward facing dog', 'urdhva mukha svanasana'},
    //   {'downward-facing dog', 'adho mukha svanasana'}
    // ],
    'immunity booster': [
      {'triangle', 'trikonasana'},
      {'cobra', 'bhujangasana'},
      {'tree', 'vrikshasana'},
      {'mountain', 'tadasana'},
      {'fish', 'matsyasana'}
    ],
    'yoga in pregnancy': [
      {'mountain', 'tadasana'},
      {'triangle', 'trikonasana'},
      {'warrior', 'virabhadrasana'},
      {'easy', 'sukhasana'},
      {'cat-cow', 'marjaryasana'},
      {'forward bend', 'uttanasana'},
      {'corpse', 'shavasana'}
    ],
    'insomnia': [
      {'dynamic forward-fold sequence', 'ardha uttanasana to uttanasana'},
      {'ragdoll', 'ardha utkatasana'},
      {'downward-facing dog', 'adho mukha svanasana'},
      {'cat-cow', 'marjaryasana'},
      {'hypnotic sphinx', 'salamba bhujangasan'},
      {'seated forward bend', 'paschimottanasana'},
      {'legs-up-the-wall', 'viparita karani'},
    ],
    'cardiovascular yoga': [
      {'extended triangle', 'utthita trikonasana'},
      {'seated forward bend', 'paschimottanasana'},
      {'half spinal twist', 'ardha matsyendrasana'},
      {'cow face', 'gomukhasana'},
      {'bridge', 'setu bandhasana'}
    ],
    'yoga for migraine': [
      {'downward facing dog', 'adho mukha svanasana'},
      {'wide-legged forward bend', 'prasarita padottanasana'},
      {'child', 'shishuasana'},
      {'head to knee', 'janu sirsasana'},
      {'standing forward bend', 'hastapadasana'},
    ],
    'yoga for asthma': [
      {'easy', 'sukhasana'},
      {'staff', 'dandasana'},
      {'seated wide angle', 'upavistha konasana'},
      {'forward bend', 'uttanasana'},
      {'butterfly', 'baddha konasana'},
    ]
  };

  List<String> trackDescription = [
    'This is perfect to get started with yoga. All asanas are safe and simple. You\'ll learn the basic asanas and get ready for a deep dive.',
    'This track is built to increase stamina. It increases flexibility and promotes weight loss. It also improves circulation and the immune system. Get ready for a mini workout!',
    // 'Surya Namaskar is a refreshing way to start a day. It is a track of 12 yoga poses which have immense benefits on mind and body. Do it regularly to regularize hormones as well !',
    'Boost your immunity with this specifically designed track of 5 poses!',
    'Prenatal yoga has helped women across the globe to have happier and healthier pregnancies. It improves sleep, decreases stress and back pains.',
    'Having trouble sleeping? No worries! Our 6 step insomnia yoga track will help you tackle insomnia like a pro, with better health as a bonus!',
    'This track will relax  your blood vessels and lower blood pressure and heart rate, increasing aerobic exercise\'s benefits!',
    'Tired of chronic headaches? Try out this track to relax and destress and get rid of your headaches in no time!',
    'Get tired easily of physical exercise? This is a perfect track for you! It consists of 5 yoga asanas performed slow which will make your lungs healthy and strong.'
  ];

  /// For easy uploading of tracks to the database
  uploadTracks() async {
    // beginners
    int id = 1;
    poses.forEach((key, value) async {
      DocumentReference documentReferencer = documentReference.collection('tracks').document(key);

      Map<String, dynamic> name = <String, dynamic>{
        "id": id,
        "name": key,
        "desc": trackDescription[id],
        "count": value.length,
      };
      id = id + 1;

      await documentReferencer.setData(name).whenComplete(() {
        print("$key track added to the database");
      }).catchError((e) => print(e));

      value.forEach((element) async {
        DocumentReference poseDocs =
            documentReferencer.collection('poses').document(element.elementAt(0));

        Map<String, String> data = <String, String>{
          "title": element.elementAt(0),
          "sub": element.elementAt(1),
        };

        await poseDocs.setData(data).whenComplete(() {
          print("${element.elementAt(0)} added to the database");
        }).catchError((e) => print(e));
      });
    });
  }

  /// For storing user data on the database
  Future<void> storeUserData({
    @required String userName,
    @required String gender,
    @required String age,
  }) async {
    DocumentReference documentReferencer = documentReference.collection('user_info').document(uid);

    Map<String, dynamic> data = <String, dynamic>{
      "image_url": imageUrl,
      "name": userName,
      "gender": gender,
      "age": age,
    };
    print('DATA:\n$data');

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await documentReferencer.setData(data).whenComplete(() {
      print("User Info added to the database");
      prefs.setBool('details_uploaded', true);
    }).catchError((e) => print(e));
  }

  // Future getProducts() async {
  //   QuerySnapshot productQuery =
  //       await documentReference.collection('departments').getDocuments();

  //   return productQuery.documents;
  // }

  /// For retrieving the user info from the database
  retrieveUserInfo() async {
    DocumentSnapshot userInfo =
        await documentReference.collection('user_info').document(uid).get();

    return userInfo;
  }

  /// For retrieving the tracks from the database
  retrieveTracks() async {
    QuerySnapshot tracksQuery = await documentReference
        .collection('tracks')
        .orderBy('id', descending: false)
        .getDocuments();

    return tracksQuery.documents;
  }

  /// For retrieving the poses from the database
  retrievePoses({@required String trackName}) async {
    QuerySnapshot posesQuery = await documentReference
        .collection('tracks')
        .document(trackName)
        .collection('poses')
        .getDocuments();

    return posesQuery.documents;
  }
}
