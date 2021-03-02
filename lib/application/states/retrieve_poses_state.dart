import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sofia/model/pose.dart';

part 'retrieve_poses_state.freezed.dart';

@freezed
abstract class RetrievePosesState with _$RetrievePosesState {
  const factory RetrievePosesState() = InitialPoseData;
  const factory RetrievePosesState.retrieving() = RetrievingPoses;
  const factory RetrievePosesState.retrieved(List<Pose> poses) = RetrievedPoses;
  const factory RetrievePosesState.error({String message}) =
      ErrorRetrievingPoses;
}
