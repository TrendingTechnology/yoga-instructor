import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_sign_in_state.freezed.dart';

@freezed
abstract class AuthSignInState with _$AuthSignInState {
  const factory AuthSignInState() = Initial;
  const factory AuthSignInState.signingIn() = SigningIn;
  const factory AuthSignInState.signedIn(FirebaseUser user) = SignedIn;
  const factory AuthSignInState.error({String message}) = SignInError;
}
