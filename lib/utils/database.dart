import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sofia/model/pose.dart';
import 'package:sofia/model/track.dart';
import 'package:sofia/model/user.dart';
import 'package:sofia/utils/authentication_client.dart';

/// The main Firestore collection.
final CollectionReference mainCollection =
    Firestore.instance.collection('sofia');

// Use this for production
// final DocumentReference documentReference = mainCollection.document('prod');

/// The test document reference.
final DocumentReference documentReference = mainCollection.document('test');

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

  Map<String, List<Set<dynamic>>> poses = {
    'beginners': [
      {
        'mountain',
        'tadasana',
        'The biggest benefit of tadasana is that it helps in correcting your posture and improves your balance by making your spine more agile. It helps in increasing the flexibility of your ankles, thighs and joints. It can tone your hips and abdomen and helps to gain control over your muscular movements.',
        '',
        [0],
      },
      {
        'tree',
        'vrikshasana',
        'It strengthens the legs, and opens the hips. It improves your neuromuscular coordination. It helps with balance and endurance. It improves alertness and concentration. It may help those who suffer from sciatica (nerve pain in the leg)',
        '',
        [0],
      },
      {
        'downward facing dog',
        'adho mukha svanasana',
        'Tones your core. Strengthens your bones. Works the back of your legs. Improves blood flow to the brain. Strengthens your arms. Improves your body posture.',
        '',
        [0],
      },
      {
        'triangle',
        'trikonasana',
        'Stretches and strengthens the thighs, knees, and ankles. Stretches the hips, groins, hamstrings, and calves; shoulders, chest, and spine. Stimulates the abdominal organs. Helps relieve stress. Improves digestion. Helps relieve the symptoms of menopause.',
        'https://stream.mux.com/kiBM5MAziq4wGLnc2GCVixAL8EXYg7wcUDA00VcSkzNM.m3u8.m3u8',
        [95, 194],
      },
      {
        'cobra',
        'bhujangasana',
        'Strengthens the spine. Stretches chest and lungs, shoulders, and abdomen. Tones the buttocks. Stimulates abdominal organs. Helps relieve stress and fatigue. Opens the heart and lungs. Soothes sciatica. Therapeutic for asthma.',
        '',
        [0],
      },
      {
        'child',
        'shishuasana',
        'Releases tension in the back, shoulders and chest. Recommended if you have dizziness or fatigue. Helps alleviate stress and anxiety. Flexes the body\'s internal organs and keeps them supple. It lengthens and stretches the spine.',
        '',
        [0],
      },
      {
        'easy',
        'sukhasana',
        'Sukhasana Posture eliminates stress and anxiety. Induces calmness of mind. Improves blood circulation in your hips, legs, spine, back and pelvis area and helps digestive organs immensely. You get fresh energy and rejuvenated.',
        '',
        [0],
      },
    ],
    'power yoga': [
      {
        'half moon',
        'ardha chandrasana',
        'Have to add the advantage here.',
        '',
        [0],
      },
      {
        'boat',
        'paripurna navasana',
        'Tones and strengthens your abdominal muscles. Improves balance and digestion. Stretches your hamstrings. Strengthens your spine and hip flexors. Stimulates the kidneys, thyroid and prostate glands, and intestines. Aids in stress relief. Improves confidence.',
        '',
        [0],
      },
      {
        'camel',
        'ustrasana',
        'Reduces fat on thighs. Opens up the hips, stretching deep hip flexors. Stretches and strengthens the shoulders and back. Expands the abdominal region, improving digestion and elimination. Improves posture. Opens the chest, improving respiration. Loosens up the vertebrae. Relieves lower back pain.',
        '',
        [0],
      },
      {
        'locust',
        'salabhasana',
        'Strengthens the muscles of the spine, buttocks, and backs of the arms and legs. Stretches the shoulders, chest, belly, and thighs. Improves posture. Stimulates abdominal organs. Helps relieve stress.',
        '',
        [0],
      },
      {
        'plank',
        'chaturanga dandasana',
        'Strengthens your back and core. Similar to plank exercises, this asana aligns your whole body and builds strength in your erector spinae, the muscles on either side of your spine. This helps improve core strength, posture, and stability. Mastering Chaturanga can help you build functional strength.',
        '',
        [0],
      },
      {
        'downward facing dog',
        'adho mukha svanasana',
        'Tones your core. Strengthens your bones. Works the back of your legs. Improves blood flow to the brain. Strengthens your arms. Improves your body posture.',
        '',
        [0],
      },
      {
        'chair',
        'utkatasana',
        'Tones the leg muscles excellently. Strengthens hip flexors, ankles, calves, and back. Stretches chest and shoulders. Reduces symptoms of flat feet. Stimulates the heart, diaphragm, and abdominal organs.',
        '',
        [0],
      }
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
      {
        'triangle',
        'trikonasana',
        'Stretches and strengthens the thighs, knees, and ankles. Stretches the hips, groins, hamstrings, and calves; shoulders, chest, and spine. Stimulates the abdominal organs. Helps relieve stress. Improves digestion. Helps relieve the symptoms of menopause.',
        '',
        [0],
      },
      {
        'cobra',
        'bhujangasana',
        'Strengthens the spine. Stretches chest and lungs, shoulders, and abdomen. Tones the buttocks. Stimulates abdominal organs. Helps relieve stress and fatigue. Opens the heart and lungs. Soothes sciatica. Therapeutic for asthma.',
        '',
        [0],
      },
      {
        'tree',
        'vrikshasana',
        'It strengthens the legs, and opens the hips. It improves your neuromuscular coordination. It helps with balance and endurance. It improves alertness and concentration. It may help those who suffer from sciatica (nerve pain in the leg)',
        '',
        [0],
      },
      {
        'mountain',
        'tadasana',
        'The biggest benefit of tadasana is that it helps in correcting your posture and improves your balance by making your spine more agile. It helps in increasing the flexibility of your ankles, thighs and joints. It can tone your hips and abdomen and helps to gain control over your muscular movements.',
        '',
        [0],
      },
      {
        'fish',
        'matsyasana',
        'Have to add the advantage here.',
        '',
        [0],
      }
    ],
    'yoga in pregnancy': [
      {
        'mountain',
        'tadasana',
        'The biggest benefit of tadasana is that it helps in correcting your posture and improves your balance by making your spine more agile. It helps in increasing the flexibility of your ankles, thighs and joints. It can tone your hips and abdomen and helps to gain control over your muscular movements.',
        '',
        [0],
      },
      {
        'triangle',
        'trikonasana',
        'Stretches and strengthens the thighs, knees, and ankles. Stretches the hips, groins, hamstrings, and calves; shoulders, chest, and spine. Stimulates the abdominal organs. Helps relieve stress. Improves digestion. Helps relieve the symptoms of menopause.',
        '',
        [0],
      },
      {
        'warrior',
        'virabhadrasana',
        'Stretches your hips, groins and shoulders. Opens your chest and lungs. Energizes tired limbs. Stimulates your abdominal organs. Develops balance and stability. Improves circulation and respiration.',
        '',
        [0],
      },
      {
        'easy',
        'sukhasana',
        'Sukhasana Posture eliminates stress and anxiety; induces calmness of mind; improves blood circulation in your hips, legs, spine, back and pelvis area and helps digestive organs immensely. You get fresh energy and rejuvenated.',
        '',
        [0],
      },
      {
        'cat-cow',
        'marjaryasana',
        'Improves posture and balance. Strengthens and stretches the spine and neck. Stretches the hips, abdomen and back. Increases coordination. Massages and stimulates organs in the belly, like the kidneys and adrenal glands. Creates emotional balance. Relieves stress and calms the mind.',
        '',
        [0],
      },
      {
        'forward bend',
        'uttanasana',
        'Stretches the hips, hamstrings, and calves. Strengthens the thighs and knees. Keeps your spine strong and flexible. Reduces stress, anxiety, depression, and fatigue. Calms the mind and soothes the nerves. Relieves tension in the spine, neck, and back. Activates the abdominal muscles.',
        '',
        [0],
      },
      {
        'corpse',
        'shavasana',
        'Calms central nervous system, aiding the digestive and immune systems. Calms the mind and reduces stress. Reduces headache, fatigue and anxiety. Helps lower blood pressure. Promotes spiritual awakening and awareness of higher consciousness.',
        '',
        [0],
      }
    ],
    'insomnia': [
      {
        'dynamic forward-fold sequence',
        'ardha uttanasana to uttanasana',
        'Strengthens the Lower Back. Strengthens the muscles of Feet and Ankles. Strengthens the muscles of Hamstrings. Strengthens the muscles of Hips. Strengthens the muscles of Knees. Strengthens the muscles of Pelvic. Strengthens the muscles of Quadriceps.',
        '',
        [0],
      },
      {
        'ragdoll',
        'ardha utkatasana',
        'Check the advantages',
        '',
        [0]
      },
      {
        'downward-facing dog',
        'adho mukha svanasana',
        'Tones your core. Strengthens your bones. Works the back of your legs. Improves blood flow to the brain. Strengthens your arms. Improves your body posture.',
        '',
        [0],
      },
      {
        'cat-cow',
        'marjaryasana',
        'Great for strengthening your spine. During cow stretch activates the tailbone, the spin\'s root, while the cat stretch releases the tension of neck and upper back. The pose will also improve the blood flow in your spine.',
        '',
        [0],
      },
      {
        'hypnotic sphinx',
        'salamba bhujangasan',
        'It strengthens various areas of your body, such as the back, spine, chest, shoulders, abdominal muscles, neck and arms. It also tones your body and helps to develop strong muscles. The tightening of the glute muscles provides support to the hip, spine and pelvis.',
        '',
        [0],
      },
      {
        'seated forward bend',
        'paschimottanasana',
        'Calms the brain and helps relieve stress and mild depression. Stretches the spine, shoulders, hamstrings. Stimulates the liver, kidneys, ovaries, and uterus. Improves digestion. Helps relieve the symptoms of menopause and menstrual discomfort. Soothes headache and anxiety and reduces fatigue.',
        '',
        [0],
      },
      {
        'legs-up-the-wall',
        'viparita karani',
        'Alleviates headaches. Boosts energy. Soothes menstrual cramps (some yoga traditions advice against doing Viparita Karani during menstruation) Relieves lower-back pain.',
        '',
        [0],
      },
    ],
    'cardiovascular yoga': [
      {
        'extended triangle',
        'utthita trikonasana',
        'Stretches and strengthens the thighs, knees, and ankles. Stretches the hips, groins, hamstrings, and calves; shoulders, chest, and spine. Stimulates the abdominal organs. Helps relieve stress. Improves digestion. Helps relieve the symptoms of menopause.',
        '',
        [0],
      },
      {
        'seated forward bend',
        'paschimottanasana',
        'Calms the brain and helps relieve stress and mild depression. Stretches the spine, shoulders, hamstrings. Stimulates the liver, kidneys, ovaries, and uterus. Improves digestion. Helps relieve the symptoms of menopause and menstrual discomfort. Soothes headache and anxiety and reduces fatigue.',
        '',
        [0],
      },
      {
        'half spinal twist',
        'ardha matsyendrasana',
        'It strengthens and tones your obliques and abs. The pose energizes and stretches the spine. Open your shoulders, hips and neck. Increase the flexibility in your spine and hips. It also cleanses your internal organs. It will improves digestion as well as elimination of the wastes.',
        '',
        [0],
      },
      {
        'cow face',
        'gomukhasana',
        'It stretches your hips. It provides power to your ankles, thighs, shoulders, armpit, chest, deltoid and triceps. Relieves chronic knee pain. Strengthens your spine and abdominal muscles. Helps decompress low spine (during folded variation). Strengthens the hip joint.',
        '',
        [0],
      },
      {
        'bridge',
        'setu bandhasana',
        'Stretches the chest, neck, spine, and hips. Strengthens the back, buttocks, and hamstrings. Improves circulation of blood. Helps alleviate stress and mild depression. Calms the brain and central nervous system. Stimulates the lungs, thyroid glands, and abdominal organs. Improves digestion.',
        '',
        [0],
      }
    ],
    'yoga for migraine': [
      {
        'downward facing dog',
        'adho mukha svanasana',
        'Tones your core. Strengthens your bones. Works the back of your legs. Improves blood flow to the brain. Strengthens your arms. Improves your body posture.',
        '',
        [0],
      },
      {
        'wide-legged forward bend',
        'prasarita padottanasana',
        'This pose stretches the backs of the legs – Hamstrings, calves, glutes and lower back. It improves hip joint flexibility. It strengthens the feet. It acts as a semi inversion. It creates length in the spine. It improves posture. It provides rest to the heart. It helps to turn inward.',
        '',
        [0],
      },
      {
        'child',
        'shishuasana',
        'The pose essentially is helpful to stretch the thighs, hips, and ankles and simultaneously reduces stress and fatigue. Helps to relax the muscles on the front of the body while also stretching the muscles of the back. It is a great stress reliever as it calms and soothes the brain.',
        '',
        [0],
      },
      {
        'head to knee',
        'janu sirsasana',
        'Calms the brain and helps relieve mild depression. Stretches the spine, shoulders, hamstrings, and groins. Stimulates the liver and kidneys. Improves digestion. Helps relieve the symptoms of menopause. Relieves anxiety, fatigue, headache, menstrual discomfort.',
        '',
        [0],
      },
      {
        'standing forward bend',
        'hastapadasana',
        'Stretches the hips, hamstrings, and calves. Strengthens the thighs and knees. Keeps your spine strong and flexible. Reduces stress, anxiety, depression, and fatigue. Calms the mind and soothes the nerves. Relieves tension in the spine, neck, and back. Activates the abdominal muscles.',
        '',
        [0],
      },
    ],
    'yoga for asthma': [
      {
        'easy',
        'sukhasana',
        'Sukhasana Posture eliminates stress and anxiety. Induces calmness of mind; improves blood circulation in your hips, legs, spine, back and pelvis area and helps digestive organs immensely. You get fresh energy and rejuvenated.',
        '',
        [0],
      },
      {
        'staff',
        'dandasana',
        'Helps improve posture. Strengthens back muscles. Lengthens and stretches the spine. May help to relieve complications related to the reproductive organs. Stretches shoulders and chest. Nourishes your body\'s resistance to back and hip injuries. Helps to calm brain cells.',
        '',
        [0],
      },
      {
        'seated wide angle',
        'upavistha konasana',
        'Top Health Benefits of Upavistha Konasana. Stretches The Body. Strengthens The Spinal Cord. Relaxes And Calms The Brain. Cures Sciatica. Relieves Arthritis. Tones and Stimulates Abdominal Organs. Activates the Core Muscles.',
        '',
        [0],
      },
      {
        'forward bend',
        'uttanasana',
        'Stretches the hips, hamstrings, and calves. Strengthens the thighs and knees. Keeps your spine strong and flexible. Reduces stress, anxiety, depression, and fatigue. Calms the mind and soothes the nerves. Relieves tension in the spine, neck, and back. Activates the abdominal muscles.',
        '',
        [0],
      },
      {
        'butterfly',
        'baddha konasana',
        'Strengthens and improves flexibility in the inner thighs, groins and the knees. Helps prepare the hips and groins for meditative seated poses, which require more flexibility in these areas. Helps to soothe menstrual discomfort and digestive complaints.',
        '',
        [0],
      },
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
      DocumentReference documentReferencer =
          documentReference.collection('tracks').document(key);

      Map<String, dynamic> name = <String, dynamic>{
        "id": id,
        "name": key,
        "desc": trackDescription[id - 1],
        "count": value.length,
      };
      id = id + 1;

      await documentReferencer.setData(name).whenComplete(() {
        print("$key track added to the database");
      }).catchError((e) => print(e));

      value.forEach((element) async {
        DocumentReference poseDocs = documentReferencer
            .collection('poses')
            .document(element.elementAt(0));

        Map<String, dynamic> data = <String, dynamic>{
          "title": element.elementAt(0),
          "sub": element.elementAt(1),
          "benefits": element.elementAt(2),
          "video_url": element.elementAt(3),
          "pause_points": element.elementAt(4),
        };

        await poseDocs.setData(data).whenComplete(() {
          print("${element.elementAt(0)} added to the database");
        }).catchError((e) => print(e));
      });
    });
  }

  /// For storing user data on the database
  Future<User> storeUserData({
    @required String uid,
    @required String imageUrl,
    @required String userName,
    @required String gender,
    @required String age,
  }) async {
    User userData;

    DocumentReference documentReferencer =
        documentReference.collection('user_info').document(uid);

    Map<String, dynamic> data = <String, dynamic>{
      "uid": uid,
      "imageUrl": imageUrl,
      "userName": userName,
      "gender": gender,
      "age": age,
    };
    print('DATA:\n$data');

    userData = User.fromJson(data);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await documentReferencer.setData(data).whenComplete(() {
      print("User Info added to the database");
      prefs.setBool('details_uploaded', true);
    }).catchError((e) => print(e));

    return userData;
  }

  // Future getProducts() async {
  //   QuerySnapshot productQuery =
  //       await documentReference.collection('departments').getDocuments();

  //   return productQuery.documents;
  // }

  /// For retrieving the user info from the database
  Future<User> retrieveUserInfo({@required String uid}) async {
    DocumentSnapshot userInfo =
        await documentReference.collection('user_info').document(uid).get();

    User userData = User.fromJson(userInfo.data);

    return userData;
  }

  /// For retrieving the tracks from the database
  Future<List<Track>> retrieveTracks() async {
    QuerySnapshot tracksQuery = await documentReference
        .collection('tracks')
        .orderBy('id', descending: false)
        .getDocuments();

    List<Track> tracks = [];

    tracksQuery.documents.forEach((doc) {
      tracks.add(Track.fromJson(doc.data));
    });

    return tracks;
  }

  /// For retrieving the poses from the database
  Future<List<Pose>> retrievePoses({@required String trackName}) async {
    QuerySnapshot posesQuery = await documentReference
        .collection('tracks')
        .document(trackName)
        .collection('poses')
        .getDocuments();

    List<Pose> poses = [];

    posesQuery.documents.forEach((doc) {
      poses.add(Pose.fromJson(doc.data));
    });

    return poses;
  }

  uploadScore({
    @required String poseName,
    @required int stars,
    @required double accuracy,
    @required int timeInMilliseconds,
  }) async {
    String currentUid = AuthenticationClient.presentUser.uid;

    DocumentReference documentReferencer = documentReference
        .collection('user_info')
        .document(currentUid)
        .collection('score')
        .document(poseName);

    Map<String, dynamic> data = <String, dynamic>{
      "stars": stars,
      "double": accuracy,
      "time": timeInMilliseconds,
    };
    print('DATA:\n$data');

    await documentReferencer.setData(data).whenComplete(() {
      print("Score added to the database!");
    }).catchError((e) => print(e));

    QuerySnapshot scoreDocs = await documentReference
        .collection('user_info')
        .document(currentUid)
        .collection('score')
        .getDocuments();

    int totalStars = 0;
    double totalAcuracy = 0.0;
    int totalTimeInMilliseconds = 0;

    scoreDocs.documents.forEach((doc) {
      totalStars += doc.data['stars'];
      totalAcuracy += doc.data['accuracy'];
      totalTimeInMilliseconds += doc.data['time'];
    });

    DocumentReference userReferencer =
        documentReference.collection('user_info').document(currentUid);

    await userReferencer.updateData(data).whenComplete(() {
      print('User total score updated!');
    }).catchError((e) => print(e));
  }
}
