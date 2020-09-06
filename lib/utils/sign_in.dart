import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth0/flutter_auth0.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sofia/secrets.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

bool authSignedIn;
bool detailsUploaded;
String uid;
String name;
String email;
String imageUrl;

/// The main Firestore collection
final CollectionReference mainCollection =
    Firestore.instance.collection('sofia');

// Use this for production
// final DocumentReference documentReference = mainCollection.document('prod');

// Use this for testing
final DocumentReference documentReference = mainCollection.document('test');

/// For checking if the user is already signed into the
/// app using Google Sign In
Future getUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  authSignedIn = prefs.getBool('auth') ?? false;
  detailsUploaded = prefs.getBool('details_uploaded') ?? false;

  final FirebaseUser user = await _auth.currentUser();

  if (authSignedIn == true) {
    if (user != null) {
      uid = user.uid;
      name = user.displayName;
      email = user.email;
      imageUrl = user.photoUrl;
    }
  }
}

/// For authenticating user using Google Sign In
/// with Firebase Authentication API.
///
/// Retrieves some general user related information
/// from their Google account for ease of the login process
Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  // Checking if email and name is null
  assert(user.uid != null);
  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoUrl != null);

  uid = user.uid;
  name = user.displayName;
  email = user.email;
  imageUrl = user.photoUrl;

  // Only taking the first part of the name, i.e., First Name
  if (name.contains(" ")) {
    name = name.substring(0, name.indexOf(" "));
  }

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', true);
  authSignedIn = true;

  return 'signInWithGoogle succeeded: $user';
}

/// For signing out of their Google account
Future<void> signOutGoogle() async {
  await googleSignIn.signOut();
  await _auth.signOut();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', false);
  authSignedIn = false;

  print("User Sign Out");
}

/// For usign Web Login using Auth0
Future<String> signInWithAuth0() async {
  Auth0 auth0;

  auth0 = Auth0(baseUrl: 'https://$authDomain/', clientId: authClientID);

  var response = await auth0.webAuth.authorize({
    'audience': 'https://$authDomain/userinfo',
    'scope': 'openid email offline_access',
  });

  print(response);

  // DateTime now = DateTime.now();
  // showInfo('Web Login', '''
  // \ntoken_type: ${response['token_type']}
  // \nexpires_in: ${DateTime.fromMillisecondsSinceEpoch(response['expires_in'] + now.millisecondsSinceEpoch)}
  // \nrefreshToken: ${response['refresh_token']}
  // \naccess_token: ${response['access_token']}
  // ''');

  String tokenType = response['token_type'];
  String accessToken = response['access_token'];

  assert(accessToken != null);

  uid = accessToken;

  // try {
  //   var authClient = Auth0Auth(auth0.auth.clientId, auth0.auth.client.baseUrl,
  //       bearer: '$uid');
  //   var info = await authClient.getUserInfo();
  //   String buffer = '';
  //   info.forEach((k, v) => buffer = '$buffer\n$k: $v');
  //   print(buffer);
  //   // showInfo('User Info', buffer);
  // } catch (e) {
  //   print(e);
  // }

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', true);
  prefs.setString('uid', uid);
  authSignedIn = true;

  return 'Auth0 sign-in successful, access token: $uid';

  // webLogged = true;
  // currentWebAuth = Map.from(response);
}

Future<String> getUid() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  uid = prefs.getString('uid');

  return 'Successfully retrieved uid: $uid';
}
