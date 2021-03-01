import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sofia/application/states/auth_current_user_state.dart';
import 'package:sofia/utils/authentication_client.dart';

class AuthCurrentUserNotifier extends StateNotifier<AuthCurrentUserState> {
  final AuthenticationClient _authentication;

  AuthCurrentUserNotifier(this._authentication) : super(AuthCurrentUserState());

  Future<void> getCurrentUser() async {
    try {
      state = AuthCurrentUserState.finding();
      final currentUserDetails = await _authentication.checkForCurrentUser();

      final FirebaseUser currentUser = currentUserDetails.elementAt(0);
      final bool isDetailsUploaded = currentUserDetails.elementAt(1);

      if (currentUser == null) {
        state = AuthCurrentUserState.notSignedIn();
      } else if (isDetailsUploaded) {
        state = AuthCurrentUserState.alreadySignedIn(currentUser);
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
