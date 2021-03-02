import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sofia/application/states/store_user_data_state.dart';
import 'package:sofia/utils/database.dart';

class StoreUserDataNotifier extends StateNotifier<StoreUserDataState> {
  final Database _database;

  StoreUserDataNotifier(this._database) : super(StoreUserDataState());

  Future<void> storeData({
    @required String uid,
    @required String imageUrl,
    @required String userName,
    @required String gender,
    @required String age,
  }) async {
    try {
      state = StoreUserDataState.storing();
      await _database.storeUserData(
        uid: uid,
        imageUrl: imageUrl,
        userName: userName,
        gender: gender,
        age: age,
      );
      state = StoreUserDataState.stored();
    } catch (error) {
      state = StoreUserDataState.error(message: 'Error signing in.');
    }
  }
}
