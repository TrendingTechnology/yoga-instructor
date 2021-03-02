import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sofia/model/user.dart';

part 'auth_current_user_state.freezed.dart';

@freezed
abstract class AuthCurrentUserState with _$AuthCurrentUserState {
  const factory AuthCurrentUserState() = Initial;
  const factory AuthCurrentUserState.finding() = Finding;
  const factory AuthCurrentUserState.alreadySignedIn(User user) = SignedInUser;
  const factory AuthCurrentUserState.detailsNotUploaded(FirebaseUser user) =
      DetailsNotUploaded;
  const factory AuthCurrentUserState.notSignedIn() = NotSignedInUser;
  const factory AuthCurrentUserState.error({String message}) = Error;
}
