// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'retrieve_poses_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$RetrievePosesStateTearOff {
  const _$RetrievePosesStateTearOff();

// ignore: unused_element
  InitialPoseData call() {
    return const InitialPoseData();
  }

// ignore: unused_element
  RetrievingPoses retrieving() {
    return const RetrievingPoses();
  }

// ignore: unused_element
  RetrievedPoses retrieved(List<Pose> poses) {
    return RetrievedPoses(
      poses,
    );
  }

// ignore: unused_element
  ErrorRetrievingPoses error({String message}) {
    return ErrorRetrievingPoses(
      message: message,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $RetrievePosesState = _$RetrievePosesStateTearOff();

/// @nodoc
mixin _$RetrievePosesState {
  @optionalTypeArgs
  TResult when<TResult extends Object>(
    TResult $default(), {
    @required TResult retrieving(),
    @required TResult retrieved(List<Pose> poses),
    @required TResult error(String message),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>(
    TResult $default(), {
    TResult retrieving(),
    TResult retrieved(List<Pose> poses),
    TResult error(String message),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>(
    TResult $default(InitialPoseData value), {
    @required TResult retrieving(RetrievingPoses value),
    @required TResult retrieved(RetrievedPoses value),
    @required TResult error(ErrorRetrievingPoses value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>(
    TResult $default(InitialPoseData value), {
    TResult retrieving(RetrievingPoses value),
    TResult retrieved(RetrievedPoses value),
    TResult error(ErrorRetrievingPoses value),
    @required TResult orElse(),
  });
}

/// @nodoc
abstract class $RetrievePosesStateCopyWith<$Res> {
  factory $RetrievePosesStateCopyWith(
          RetrievePosesState value, $Res Function(RetrievePosesState) then) =
      _$RetrievePosesStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$RetrievePosesStateCopyWithImpl<$Res>
    implements $RetrievePosesStateCopyWith<$Res> {
  _$RetrievePosesStateCopyWithImpl(this._value, this._then);

  final RetrievePosesState _value;
  // ignore: unused_field
  final $Res Function(RetrievePosesState) _then;
}

/// @nodoc
abstract class $InitialPoseDataCopyWith<$Res> {
  factory $InitialPoseDataCopyWith(
          InitialPoseData value, $Res Function(InitialPoseData) then) =
      _$InitialPoseDataCopyWithImpl<$Res>;
}

/// @nodoc
class _$InitialPoseDataCopyWithImpl<$Res>
    extends _$RetrievePosesStateCopyWithImpl<$Res>
    implements $InitialPoseDataCopyWith<$Res> {
  _$InitialPoseDataCopyWithImpl(
      InitialPoseData _value, $Res Function(InitialPoseData) _then)
      : super(_value, (v) => _then(v as InitialPoseData));

  @override
  InitialPoseData get _value => super._value as InitialPoseData;
}

/// @nodoc
class _$InitialPoseData implements InitialPoseData {
  const _$InitialPoseData();

  @override
  String toString() {
    return 'RetrievePosesState()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is InitialPoseData);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>(
    TResult $default(), {
    @required TResult retrieving(),
    @required TResult retrieved(List<Pose> poses),
    @required TResult error(String message),
  }) {
    assert($default != null);
    assert(retrieving != null);
    assert(retrieved != null);
    assert(error != null);
    return $default();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>(
    TResult $default(), {
    TResult retrieving(),
    TResult retrieved(List<Pose> poses),
    TResult error(String message),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if ($default != null) {
      return $default();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>(
    TResult $default(InitialPoseData value), {
    @required TResult retrieving(RetrievingPoses value),
    @required TResult retrieved(RetrievedPoses value),
    @required TResult error(ErrorRetrievingPoses value),
  }) {
    assert($default != null);
    assert(retrieving != null);
    assert(retrieved != null);
    assert(error != null);
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>(
    TResult $default(InitialPoseData value), {
    TResult retrieving(RetrievingPoses value),
    TResult retrieved(RetrievedPoses value),
    TResult error(ErrorRetrievingPoses value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class InitialPoseData implements RetrievePosesState {
  const factory InitialPoseData() = _$InitialPoseData;
}

/// @nodoc
abstract class $RetrievingPosesCopyWith<$Res> {
  factory $RetrievingPosesCopyWith(
          RetrievingPoses value, $Res Function(RetrievingPoses) then) =
      _$RetrievingPosesCopyWithImpl<$Res>;
}

/// @nodoc
class _$RetrievingPosesCopyWithImpl<$Res>
    extends _$RetrievePosesStateCopyWithImpl<$Res>
    implements $RetrievingPosesCopyWith<$Res> {
  _$RetrievingPosesCopyWithImpl(
      RetrievingPoses _value, $Res Function(RetrievingPoses) _then)
      : super(_value, (v) => _then(v as RetrievingPoses));

  @override
  RetrievingPoses get _value => super._value as RetrievingPoses;
}

/// @nodoc
class _$RetrievingPoses implements RetrievingPoses {
  const _$RetrievingPoses();

  @override
  String toString() {
    return 'RetrievePosesState.retrieving()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is RetrievingPoses);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>(
    TResult $default(), {
    @required TResult retrieving(),
    @required TResult retrieved(List<Pose> poses),
    @required TResult error(String message),
  }) {
    assert($default != null);
    assert(retrieving != null);
    assert(retrieved != null);
    assert(error != null);
    return retrieving();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>(
    TResult $default(), {
    TResult retrieving(),
    TResult retrieved(List<Pose> poses),
    TResult error(String message),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (retrieving != null) {
      return retrieving();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>(
    TResult $default(InitialPoseData value), {
    @required TResult retrieving(RetrievingPoses value),
    @required TResult retrieved(RetrievedPoses value),
    @required TResult error(ErrorRetrievingPoses value),
  }) {
    assert($default != null);
    assert(retrieving != null);
    assert(retrieved != null);
    assert(error != null);
    return retrieving(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>(
    TResult $default(InitialPoseData value), {
    TResult retrieving(RetrievingPoses value),
    TResult retrieved(RetrievedPoses value),
    TResult error(ErrorRetrievingPoses value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (retrieving != null) {
      return retrieving(this);
    }
    return orElse();
  }
}

abstract class RetrievingPoses implements RetrievePosesState {
  const factory RetrievingPoses() = _$RetrievingPoses;
}

/// @nodoc
abstract class $RetrievedPosesCopyWith<$Res> {
  factory $RetrievedPosesCopyWith(
          RetrievedPoses value, $Res Function(RetrievedPoses) then) =
      _$RetrievedPosesCopyWithImpl<$Res>;
  $Res call({List<Pose> poses});
}

/// @nodoc
class _$RetrievedPosesCopyWithImpl<$Res>
    extends _$RetrievePosesStateCopyWithImpl<$Res>
    implements $RetrievedPosesCopyWith<$Res> {
  _$RetrievedPosesCopyWithImpl(
      RetrievedPoses _value, $Res Function(RetrievedPoses) _then)
      : super(_value, (v) => _then(v as RetrievedPoses));

  @override
  RetrievedPoses get _value => super._value as RetrievedPoses;

  @override
  $Res call({
    Object poses = freezed,
  }) {
    return _then(RetrievedPoses(
      poses == freezed ? _value.poses : poses as List<Pose>,
    ));
  }
}

/// @nodoc
class _$RetrievedPoses implements RetrievedPoses {
  const _$RetrievedPoses(this.poses) : assert(poses != null);

  @override
  final List<Pose> poses;

  @override
  String toString() {
    return 'RetrievePosesState.retrieved(poses: $poses)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RetrievedPoses &&
            (identical(other.poses, poses) ||
                const DeepCollectionEquality().equals(other.poses, poses)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(poses);

  @JsonKey(ignore: true)
  @override
  $RetrievedPosesCopyWith<RetrievedPoses> get copyWith =>
      _$RetrievedPosesCopyWithImpl<RetrievedPoses>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>(
    TResult $default(), {
    @required TResult retrieving(),
    @required TResult retrieved(List<Pose> poses),
    @required TResult error(String message),
  }) {
    assert($default != null);
    assert(retrieving != null);
    assert(retrieved != null);
    assert(error != null);
    return retrieved(poses);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>(
    TResult $default(), {
    TResult retrieving(),
    TResult retrieved(List<Pose> poses),
    TResult error(String message),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (retrieved != null) {
      return retrieved(poses);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>(
    TResult $default(InitialPoseData value), {
    @required TResult retrieving(RetrievingPoses value),
    @required TResult retrieved(RetrievedPoses value),
    @required TResult error(ErrorRetrievingPoses value),
  }) {
    assert($default != null);
    assert(retrieving != null);
    assert(retrieved != null);
    assert(error != null);
    return retrieved(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>(
    TResult $default(InitialPoseData value), {
    TResult retrieving(RetrievingPoses value),
    TResult retrieved(RetrievedPoses value),
    TResult error(ErrorRetrievingPoses value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (retrieved != null) {
      return retrieved(this);
    }
    return orElse();
  }
}

abstract class RetrievedPoses implements RetrievePosesState {
  const factory RetrievedPoses(List<Pose> poses) = _$RetrievedPoses;

  List<Pose> get poses;
  @JsonKey(ignore: true)
  $RetrievedPosesCopyWith<RetrievedPoses> get copyWith;
}

/// @nodoc
abstract class $ErrorRetrievingPosesCopyWith<$Res> {
  factory $ErrorRetrievingPosesCopyWith(ErrorRetrievingPoses value,
          $Res Function(ErrorRetrievingPoses) then) =
      _$ErrorRetrievingPosesCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class _$ErrorRetrievingPosesCopyWithImpl<$Res>
    extends _$RetrievePosesStateCopyWithImpl<$Res>
    implements $ErrorRetrievingPosesCopyWith<$Res> {
  _$ErrorRetrievingPosesCopyWithImpl(
      ErrorRetrievingPoses _value, $Res Function(ErrorRetrievingPoses) _then)
      : super(_value, (v) => _then(v as ErrorRetrievingPoses));

  @override
  ErrorRetrievingPoses get _value => super._value as ErrorRetrievingPoses;

  @override
  $Res call({
    Object message = freezed,
  }) {
    return _then(ErrorRetrievingPoses(
      message: message == freezed ? _value.message : message as String,
    ));
  }
}

/// @nodoc
class _$ErrorRetrievingPoses implements ErrorRetrievingPoses {
  const _$ErrorRetrievingPoses({this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'RetrievePosesState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ErrorRetrievingPoses &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @JsonKey(ignore: true)
  @override
  $ErrorRetrievingPosesCopyWith<ErrorRetrievingPoses> get copyWith =>
      _$ErrorRetrievingPosesCopyWithImpl<ErrorRetrievingPoses>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>(
    TResult $default(), {
    @required TResult retrieving(),
    @required TResult retrieved(List<Pose> poses),
    @required TResult error(String message),
  }) {
    assert($default != null);
    assert(retrieving != null);
    assert(retrieved != null);
    assert(error != null);
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>(
    TResult $default(), {
    TResult retrieving(),
    TResult retrieved(List<Pose> poses),
    TResult error(String message),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>(
    TResult $default(InitialPoseData value), {
    @required TResult retrieving(RetrievingPoses value),
    @required TResult retrieved(RetrievedPoses value),
    @required TResult error(ErrorRetrievingPoses value),
  }) {
    assert($default != null);
    assert(retrieving != null);
    assert(retrieved != null);
    assert(error != null);
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>(
    TResult $default(InitialPoseData value), {
    TResult retrieving(RetrievingPoses value),
    TResult retrieved(RetrievedPoses value),
    TResult error(ErrorRetrievingPoses value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ErrorRetrievingPoses implements RetrievePosesState {
  const factory ErrorRetrievingPoses({String message}) = _$ErrorRetrievingPoses;

  String get message;
  @JsonKey(ignore: true)
  $ErrorRetrievingPosesCopyWith<ErrorRetrievingPoses> get copyWith;
}
