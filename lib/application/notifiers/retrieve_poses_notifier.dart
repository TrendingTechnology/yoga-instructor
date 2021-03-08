import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sofia/application/states/retrieve_poses_state.dart';
import 'package:sofia/model/pose.dart';
import 'package:sofia/utils/database.dart';

class RetrievePosesNotifier extends StateNotifier<RetrievePosesState> {
  final Database _database;
  final String _trackName;

  RetrievePosesNotifier(this._database, this._trackName)
      : super(RetrievePosesState());

  Future<void> retrievePoses() async {
    try {
      state = RetrievePosesState.retrieving();
      List<Pose> poses = await _database.retrievePoses(trackName: _trackName);
      state = RetrievePosesState.retrieved(poses);
    } catch (error) {
      state = RetrievePosesState.error(message: 'Error retrieving poses');
    }
  }
}
