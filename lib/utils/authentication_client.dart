import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

// bool authSignedIn;
// bool detailsUploaded;
// String uid;
// String name;
// String email;
// String imageUrl;

class AuthenticationClient {
  /// Checks if the user is already signed into the app using
  /// Google Sign In.
  Future<Set<dynamic>> checkForCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool authSignedIn = prefs.getBool('auth') ?? false;
    bool isDetailsUploaded = prefs.getBool('details_uploaded') ?? false;

    final FirebaseUser user = await _auth.currentUser();

    Set userDetailSet = {user, isDetailsUploaded};

    if (authSignedIn == true && user != null) {
      return userDetailSet;
    }

    return null;
  }

  /// Authenticates user using Google Sign In with
  /// Firebase Authentication API.
  ///
  /// Retrieves some general user related information
  /// from their Google account for ease of the login process.
  ///
  /// Returns user `uid`.
  Future<FirebaseUser> signInWithGoogle() async {
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

    // uid = user.uid;
    // name = user.displayName;
    // email = user.email;
    // imageUrl = user.photoUrl;

    // // Only taking the first part of the name, i.e., First Name
    // if (name.contains(" ")) {
    //   name = name.substring(0, name.indexOf(" "));
    // }

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();

    if (currentUser != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('auth', true);
      // authSignedIn = true;
      return user;
    }

    return null;
  }

  /// Signs out of the current logged in Google account
  /// in the app.
  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
    await _auth.signOut();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', false);
    // authSignedIn = false;

    print("User Sign Out");
  }
}

/// Retrieves the user `uid` from the shared preference of the
/// device.
Future<String> getUid() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String uid = prefs.getString('uid');

  return 'Successfully retrieved uid: $uid';
}
