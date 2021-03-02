import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sofia/application/states/retrieve_poses_state.dart';
import 'package:sofia/model/pose.dart';
import 'package:sofia/utils/database.dart';

class RetrievePosesNotifier extends StateNotifier<RetrievePosesState> {
  final Database _database;

  RetrievePosesNotifier(this._database) : super(RetrievePosesState());

  Future<void> retrievePoses({@required String trackName}) async {
    try {
      state = RetrievePosesState.retrieving();
      List<Pose> poses = await _database.retrievePoses(trackName: trackName);
      state = RetrievePosesState.retrieved(poses);
    } catch (error) {
      state = RetrievePosesState.error(message: 'Error storing user data');
    }
  }
}
