// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'store_user_data_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$StoreUserDataStateTearOff {
  const _$StoreUserDataStateTearOff();

// ignore: unused_element
  InitialUserData call() {
    return const InitialUserData();
  }

// ignore: unused_element
  StoringUserData storing() {
    return const StoringUserData();
  }

// ignore: unused_element
  StoredUserData stored() {
    return const StoredUserData();
  }

// ignore: unused_element
  ErrorStoringUserData error({String message}) {
    return ErrorStoringUserData(
      message: message,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $StoreUserDataState = _$StoreUserDataStateTearOff();

/// @nodoc
mixin _$StoreUserDataState {
  @optionalTypeArgs
  TResult when<TResult extends Object>(
    TResult $default(), {
    @required TResult storing(),
    @required TResult stored(),
    @required TResult error(String message),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>(
    TResult $default(), {
    TResult storing(),
    TResult stored(),
    TResult error(String message),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>(
    TResult $default(InitialUserData value), {
    @required TResult storing(StoringUserData value),
    @required TResult stored(StoredUserData value),
    @required TResult error(ErrorStoringUserData value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>(
    TResult $default(InitialUserData value), {
    TResult storing(StoringUserData value),
    TResult stored(StoredUserData value),
    TResult error(ErrorStoringUserData value),
    @required TResult orElse(),
  });
}

/// @nodoc
abstract class $StoreUserDataStateCopyWith<$Res> {
  factory $StoreUserDataStateCopyWith(
          StoreUserDataState value, $Res Function(StoreUserDataState) then) =
      _$StoreUserDataStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$StoreUserDataStateCopyWithImpl<$Res>
    implements $StoreUserDataStateCopyWith<$Res> {
  _$StoreUserDataStateCopyWithImpl(this._value, this._then);

  final StoreUserDataState _value;
  // ignore: unused_field
  final $Res Function(StoreUserDataState) _then;
}

/// @nodoc
abstract class $InitialUserDataCopyWith<$Res> {
  factory $InitialUserDataCopyWith(
          InitialUserData value, $Res Function(InitialUserData) then) =
      _$InitialUserDataCopyWithImpl<$Res>;
}

/// @nodoc
class _$InitialUserDataCopyWithImpl<$Res>
    extends _$StoreUserDataStateCopyWithImpl<$Res>
    implements $InitialUserDataCopyWith<$Res> {
  _$InitialUserDataCopyWithImpl(
      InitialUserData _value, $Res Function(InitialUserData) _then)
      : super(_value, (v) => _then(v as InitialUserData));

  @override
  InitialUserData get _value => super._value as InitialUserData;
}

/// @nodoc
class _$InitialUserData implements InitialUserData {
  const _$InitialUserData();

  @override
  String toString() {
    return 'StoreUserDataState()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is InitialUserData);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>(
    TResult $default(), {
    @required TResult storing(),
    @required TResult stored(),
    @required TResult error(String message),
  }) {
    assert($default != null);
    assert(storing != null);
    assert(stored != null);
    assert(error != null);
    return $default();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>(
    TResult $default(), {
    TResult storing(),
    TResult stored(),
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
    TResult $default(InitialUserData value), {
    @required TResult storing(StoringUserData value),
    @required TResult stored(StoredUserData value),
    @required TResult error(ErrorStoringUserData value),
  }) {
    assert($default != null);
    assert(storing != null);
    assert(stored != null);
    assert(error != null);
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>(
    TResult $default(InitialUserData value), {
    TResult storing(StoringUserData value),
    TResult stored(StoredUserData value),
    TResult error(ErrorStoringUserData value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class InitialUserData implements StoreUserDataState {
  const factory InitialUserData() = _$InitialUserData;
}

/// @nodoc
abstract class $StoringUserDataCopyWith<$Res> {
  factory $StoringUserDataCopyWith(
          StoringUserData value, $Res Function(StoringUserData) then) =
      _$StoringUserDataCopyWithImpl<$Res>;
}

/// @nodoc
class _$StoringUserDataCopyWithImpl<$Res>
    extends _$StoreUserDataStateCopyWithImpl<$Res>
    implements $StoringUserDataCopyWith<$Res> {
  _$StoringUserDataCopyWithImpl(
      StoringUserData _value, $Res Function(StoringUserData) _then)
      : super(_value, (v) => _then(v as StoringUserData));

  @override
  StoringUserData get _value => super._value as StoringUserData;
}

/// @nodoc
class _$StoringUserData implements StoringUserData {
  const _$StoringUserData();

  @override
  String toString() {
    return 'StoreUserDataState.storing()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is StoringUserData);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>(
    TResult $default(), {
    @required TResult storing(),
    @required TResult stored(),
    @required TResult error(String message),
  }) {
    assert($default != null);
    assert(storing != null);
    assert(stored != null);
    assert(error != null);
    return storing();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>(
    TResult $default(), {
    TResult storing(),
    TResult stored(),
    TResult error(String message),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (storing != null) {
      return storing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>(
    TResult $default(InitialUserData value), {
    @required TResult storing(StoringUserData value),
    @required TResult stored(StoredUserData value),
    @required TResult error(ErrorStoringUserData value),
  }) {
    assert($default != null);
    assert(storing != null);
    assert(stored != null);
    assert(error != null);
    return storing(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>(
    TResult $default(InitialUserData value), {
    TResult storing(StoringUserData value),
    TResult stored(StoredUserData value),
    TResult error(ErrorStoringUserData value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (storing != null) {
      return storing(this);
    }
    return orElse();
  }
}

abstract class StoringUserData implements StoreUserDataState {
  const factory StoringUserData() = _$StoringUserData;
}

/// @nodoc
abstract class $StoredUserDataCopyWith<$Res> {
  factory $StoredUserDataCopyWith(
          StoredUserData value, $Res Function(StoredUserData) then) =
      _$StoredUserDataCopyWithImpl<$Res>;
}

/// @nodoc
class _$StoredUserDataCopyWithImpl<$Res>
    extends _$StoreUserDataStateCopyWithImpl<$Res>
    implements $StoredUserDataCopyWith<$Res> {
  _$StoredUserDataCopyWithImpl(
      StoredUserData _value, $Res Function(StoredUserData) _then)
      : super(_value, (v) => _then(v as StoredUserData));

  @override
  StoredUserData get _value => super._value as StoredUserData;
}

/// @nodoc
class _$StoredUserData implements StoredUserData {
  const _$StoredUserData();

  @override
  String toString() {
    return 'StoreUserDataState.stored()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is StoredUserData);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>(
    TResult $default(), {
    @required TResult storing(),
    @required TResult stored(),
    @required TResult error(String message),
  }) {
    assert($default != null);
    assert(storing != null);
    assert(stored != null);
    assert(error != null);
    return stored();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>(
    TResult $default(), {
    TResult storing(),
    TResult stored(),
    TResult error(String message),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (stored != null) {
      return stored();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>(
    TResult $default(InitialUserData value), {
    @required TResult storing(StoringUserData value),
    @required TResult stored(StoredUserData value),
    @required TResult error(ErrorStoringUserData value),
  }) {
    assert($default != null);
    assert(storing != null);
    assert(stored != null);
    assert(error != null);
    return stored(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>(
    TResult $default(InitialUserData value), {
    TResult storing(StoringUserData value),
    TResult stored(StoredUserData value),
    TResult error(ErrorStoringUserData value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (stored != null) {
      return stored(this);
    }
    return orElse();
  }
}

abstract class StoredUserData implements StoreUserDataState {
  const factory StoredUserData() = _$StoredUserData;
}

/// @nodoc
abstract class $ErrorStoringUserDataCopyWith<$Res> {
  factory $ErrorStoringUserDataCopyWith(ErrorStoringUserData value,
          $Res Function(ErrorStoringUserData) then) =
      _$ErrorStoringUserDataCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class _$ErrorStoringUserDataCopyWithImpl<$Res>
    extends _$StoreUserDataStateCopyWithImpl<$Res>
    implements $ErrorStoringUserDataCopyWith<$Res> {
  _$ErrorStoringUserDataCopyWithImpl(
      ErrorStoringUserData _value, $Res Function(ErrorStoringUserData) _then)
      : super(_value, (v) => _then(v as ErrorStoringUserData));

  @override
  ErrorStoringUserData get _value => super._value as ErrorStoringUserData;

  @override
  $Res call({
    Object message = freezed,
  }) {
    return _then(ErrorStoringUserData(
      message: message == freezed ? _value.message : message as String,
    ));
  }
}

/// @nodoc
class _$ErrorStoringUserData implements ErrorStoringUserData {
  const _$ErrorStoringUserData({this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'StoreUserDataState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ErrorStoringUserData &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @JsonKey(ignore: true)
  @override
  $ErrorStoringUserDataCopyWith<ErrorStoringUserData> get copyWith =>
      _$ErrorStoringUserDataCopyWithImpl<ErrorStoringUserData>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>(
    TResult $default(), {
    @required TResult storing(),
    @required TResult stored(),
    @required TResult error(String message),
  }) {
    assert($default != null);
    assert(storing != null);
    assert(stored != null);
    assert(error != null);
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>(
    TResult $default(), {
    TResult storing(),
    TResult stored(),
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
    TResult $default(InitialUserData value), {
    @required TResult storing(StoringUserData value),
    @required TResult stored(StoredUserData value),
    @required TResult error(ErrorStoringUserData value),
  }) {
    assert($default != null);
    assert(storing != null);
    assert(stored != null);
    assert(error != null);
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>(
    TResult $default(InitialUserData value), {
    TResult storing(StoringUserData value),
    TResult stored(StoredUserData value),
    TResult error(ErrorStoringUserData value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ErrorStoringUserData implements StoreUserDataState {
  const factory ErrorStoringUserData({String message}) = _$ErrorStoringUserData;

  String get message;
  @JsonKey(ignore: true)
  $ErrorStoringUserDataCopyWith<ErrorStoringUserData> get copyWith;
}
