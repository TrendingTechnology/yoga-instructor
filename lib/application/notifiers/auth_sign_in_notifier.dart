import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sofia/application/states/auth_sign_in_state.dart';
import 'package:sofia/utils/authentication_client.dart';

class AuthSignInNotifier extends StateNotifier<AuthSignInState> {
  final AuthenticationClient _authentication;

  AuthSignInNotifier(this._authentication) : super(AuthSignInState());

  Future<void> googleSignIn() async {
    try {
      state = AuthSignInState.signingIn();
      final signedInUser = await _authentication.signInWithGoogle();
      state = AuthSignInState.signedIn(signedInUser);
    } catch (error) {
      state = AuthSignInState.error(
          message: 'Error signing in, please check your network connection');
    }
  }
}
