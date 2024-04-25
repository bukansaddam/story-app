// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'loading_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoadingState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingStateInitial value) initial,
    required TResult Function(LoadingStateLoading value) loading,
    required TResult Function(LoadingStateLoaded value) loaded,
    required TResult Function(LoadingStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingStateInitial value)? initial,
    TResult? Function(LoadingStateLoading value)? loading,
    TResult? Function(LoadingStateLoaded value)? loaded,
    TResult? Function(LoadingStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingStateInitial value)? initial,
    TResult Function(LoadingStateLoading value)? loading,
    TResult Function(LoadingStateLoaded value)? loaded,
    TResult Function(LoadingStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoadingStateCopyWith<$Res> {
  factory $LoadingStateCopyWith(
          LoadingState value, $Res Function(LoadingState) then) =
      _$LoadingStateCopyWithImpl<$Res, LoadingState>;
}

/// @nodoc
class _$LoadingStateCopyWithImpl<$Res, $Val extends LoadingState>
    implements $LoadingStateCopyWith<$Res> {
  _$LoadingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LoadingStateInitialImplCopyWith<$Res> {
  factory _$$LoadingStateInitialImplCopyWith(_$LoadingStateInitialImpl value,
          $Res Function(_$LoadingStateInitialImpl) then) =
      __$$LoadingStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingStateInitialImplCopyWithImpl<$Res>
    extends _$LoadingStateCopyWithImpl<$Res, _$LoadingStateInitialImpl>
    implements _$$LoadingStateInitialImplCopyWith<$Res> {
  __$$LoadingStateInitialImplCopyWithImpl(_$LoadingStateInitialImpl _value,
      $Res Function(_$LoadingStateInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingStateInitialImpl implements LoadingStateInitial {
  const _$LoadingStateInitialImpl();

  @override
  String toString() {
    return 'LoadingState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingStateInitial value) initial,
    required TResult Function(LoadingStateLoading value) loading,
    required TResult Function(LoadingStateLoaded value) loaded,
    required TResult Function(LoadingStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingStateInitial value)? initial,
    TResult? Function(LoadingStateLoading value)? loading,
    TResult? Function(LoadingStateLoaded value)? loaded,
    TResult? Function(LoadingStateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingStateInitial value)? initial,
    TResult Function(LoadingStateLoading value)? loading,
    TResult Function(LoadingStateLoaded value)? loaded,
    TResult Function(LoadingStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class LoadingStateInitial implements LoadingState {
  const factory LoadingStateInitial() = _$LoadingStateInitialImpl;
}

/// @nodoc
abstract class _$$LoadingStateLoadingImplCopyWith<$Res> {
  factory _$$LoadingStateLoadingImplCopyWith(_$LoadingStateLoadingImpl value,
          $Res Function(_$LoadingStateLoadingImpl) then) =
      __$$LoadingStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingStateLoadingImplCopyWithImpl<$Res>
    extends _$LoadingStateCopyWithImpl<$Res, _$LoadingStateLoadingImpl>
    implements _$$LoadingStateLoadingImplCopyWith<$Res> {
  __$$LoadingStateLoadingImplCopyWithImpl(_$LoadingStateLoadingImpl _value,
      $Res Function(_$LoadingStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingStateLoadingImpl implements LoadingStateLoading {
  const _$LoadingStateLoadingImpl();

  @override
  String toString() {
    return 'LoadingState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingStateInitial value) initial,
    required TResult Function(LoadingStateLoading value) loading,
    required TResult Function(LoadingStateLoaded value) loaded,
    required TResult Function(LoadingStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingStateInitial value)? initial,
    TResult? Function(LoadingStateLoading value)? loading,
    TResult? Function(LoadingStateLoaded value)? loaded,
    TResult? Function(LoadingStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingStateInitial value)? initial,
    TResult Function(LoadingStateLoading value)? loading,
    TResult Function(LoadingStateLoaded value)? loaded,
    TResult Function(LoadingStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class LoadingStateLoading implements LoadingState {
  const factory LoadingStateLoading() = _$LoadingStateLoadingImpl;
}

/// @nodoc
abstract class _$$LoadingStateLoadedImplCopyWith<$Res> {
  factory _$$LoadingStateLoadedImplCopyWith(_$LoadingStateLoadedImpl value,
          $Res Function(_$LoadingStateLoadedImpl) then) =
      __$$LoadingStateLoadedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingStateLoadedImplCopyWithImpl<$Res>
    extends _$LoadingStateCopyWithImpl<$Res, _$LoadingStateLoadedImpl>
    implements _$$LoadingStateLoadedImplCopyWith<$Res> {
  __$$LoadingStateLoadedImplCopyWithImpl(_$LoadingStateLoadedImpl _value,
      $Res Function(_$LoadingStateLoadedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingStateLoadedImpl implements LoadingStateLoaded {
  const _$LoadingStateLoadedImpl();

  @override
  String toString() {
    return 'LoadingState.loaded()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingStateLoadedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function(String message) error,
  }) {
    return loaded();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingStateInitial value) initial,
    required TResult Function(LoadingStateLoading value) loading,
    required TResult Function(LoadingStateLoaded value) loaded,
    required TResult Function(LoadingStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingStateInitial value)? initial,
    TResult? Function(LoadingStateLoading value)? loading,
    TResult? Function(LoadingStateLoaded value)? loaded,
    TResult? Function(LoadingStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingStateInitial value)? initial,
    TResult Function(LoadingStateLoading value)? loading,
    TResult Function(LoadingStateLoaded value)? loaded,
    TResult Function(LoadingStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class LoadingStateLoaded implements LoadingState {
  const factory LoadingStateLoaded() = _$LoadingStateLoadedImpl;
}

/// @nodoc
abstract class _$$LoadingStateErrorImplCopyWith<$Res> {
  factory _$$LoadingStateErrorImplCopyWith(_$LoadingStateErrorImpl value,
          $Res Function(_$LoadingStateErrorImpl) then) =
      __$$LoadingStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$LoadingStateErrorImplCopyWithImpl<$Res>
    extends _$LoadingStateCopyWithImpl<$Res, _$LoadingStateErrorImpl>
    implements _$$LoadingStateErrorImplCopyWith<$Res> {
  __$$LoadingStateErrorImplCopyWithImpl(_$LoadingStateErrorImpl _value,
      $Res Function(_$LoadingStateErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$LoadingStateErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoadingStateErrorImpl implements LoadingStateError {
  const _$LoadingStateErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'LoadingState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingStateErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingStateErrorImplCopyWith<_$LoadingStateErrorImpl> get copyWith =>
      __$$LoadingStateErrorImplCopyWithImpl<_$LoadingStateErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadingStateInitial value) initial,
    required TResult Function(LoadingStateLoading value) loading,
    required TResult Function(LoadingStateLoaded value) loaded,
    required TResult Function(LoadingStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadingStateInitial value)? initial,
    TResult? Function(LoadingStateLoading value)? loading,
    TResult? Function(LoadingStateLoaded value)? loaded,
    TResult? Function(LoadingStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadingStateInitial value)? initial,
    TResult Function(LoadingStateLoading value)? loading,
    TResult Function(LoadingStateLoaded value)? loaded,
    TResult Function(LoadingStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class LoadingStateError implements LoadingState {
  const factory LoadingStateError(final String message) =
      _$LoadingStateErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$LoadingStateErrorImplCopyWith<_$LoadingStateErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
