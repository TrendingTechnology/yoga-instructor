import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sofia/model/user.dart';

part 'store_user_data_state.freezed.dart';

@freezed
abstract class StoreUserDataState with _$StoreUserDataState {
  const factory StoreUserDataState() = InitialUserData;
  const factory StoreUserDataState.storing() = StoringUserData;
  const factory StoreUserDataState.stored(User userData) = StoredUserData;
  const factory StoreUserDataState.error({String message}) =
      ErrorStoringUserData;
}
