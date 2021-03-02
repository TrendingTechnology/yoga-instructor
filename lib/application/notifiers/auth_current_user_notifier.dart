import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sofia/application/states/auth_current_user_state.dart';
import 'package:sofia/model/user.dart';
import 'package:sofia/utils/authentication_client.dart';
import 'package:sofia/utils/database.dart';

class AuthCurrentUserNotifier extends StateNotifier<AuthCurrentUserState> {
  final AuthenticationClient _authentication;
  final Database _database;

  AuthCurrentUserNotifier(this._authentication, this._database)
      : super(AuthCurrentUserState());

  Future<void> getCurrentUser() async {
    try {
      state = AuthCurrentUserState.finding();
      final currentUserDetails = await _authentication.checkForCurrentUser();

      final FirebaseUser currentUser = currentUserDetails.elementAt(0);
      final bool isDetailsUploaded = currentUserDetails.elementAt(1);

      if (currentUser == null) {
        state = AuthCurrentUserState.notSignedIn();
      } else if (isDetailsUploaded) {
        User userData = await _database.retrieveUserInfo(uid: currentUser.uid);

        state = AuthCurrentUserState.alreadySignedIn(userData);
      } else {
        state = AuthCurrentUserState.detailsNotUploaded(currentUser);
      }
    } catch (error) {
      state = AuthCurrentUserState.error(
        message: 'Error finding current user.',
      );
    }
  }
}
