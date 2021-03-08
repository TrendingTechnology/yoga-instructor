import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sofia/application/states/retrieve_tracks_state.dart';
import 'package:sofia/model/track.dart';
import 'package:sofia/utils/database.dart';

class RetrieveTracksNotifier extends StateNotifier<RetrieveTracksState> {
  final Database _database;

  RetrieveTracksNotifier(this._database) : super(RetrieveTracksState());

  Future<void> retrieveTracks() async {
    try {
      state = RetrieveTracksState.retrieving();
      List<Track> tracks = await _database.retrieveTracks();
      state = RetrieveTracksState.retrieved(tracks);
    } catch (error) {
      state = RetrieveTracksState.error(message: 'Error retrieveing tracks');
    }
  }
}
