import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sofia/model/track.dart';

part 'retrieve_tracks_state.freezed.dart';

@freezed
abstract class RetrieveTracksState with _$RetrieveTracksState {
  const factory RetrieveTracksState() = InitialTrackData;
  const factory RetrieveTracksState.retrieving() = RetrievingTracks;
  const factory RetrieveTracksState.retrieved(List<Track> tracks) =
      RetrievedTracks;
  const factory RetrieveTracksState.error({String message}) =
      ErrorRetrievingTracks;
}
