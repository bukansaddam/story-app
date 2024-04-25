import 'package:freezed_annotation/freezed_annotation.dart';
part 'loading_state.freezed.dart';

@freezed
class LoadingState with _$LoadingState {
  const factory LoadingState.initial() = LoadingStateInitial;
  const factory LoadingState.loading() = LoadingStateLoading;
  const factory LoadingState.loaded() = LoadingStateLoaded;
  const factory LoadingState.error(String message) = LoadingStateError;
}
