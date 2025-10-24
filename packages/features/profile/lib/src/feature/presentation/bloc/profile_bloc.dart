import 'package:core/core.dart';

part 'profile_bloc.freezed.dart';
part 'profile_event.dart';
part 'profile_state.dart';

/// BLoC for profile
/// Manages state and handles business logic
@lazySingleton
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState.initial()) {
    // Register event handlers
    on<ProfileEventLoad>(_onLoad);
    on<ProfileEventRefresh>(_onRefresh);
    on<ProfileEventDelete>(_onDelete);
  }

  /// Handle load event
  Future<void> _onLoad(
    ProfileEventLoad event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileState.loading());

    // TODO: Implement load logic
    // Example:
    // final params = GetDataParams(id: event.id);
    // final result = await getDataUseCase(params);
    //
    // result.fold(
    //   (failure) => emit(ProfileState.error(failure.message)),
    //   (data) => emit(ProfileState.loaded(data)),
    // );

    // Temporary success for testing
    await Future.delayed(const Duration(seconds: 1));
    emit(const ProfileState.loaded('Sample data loaded'));
  }

  /// Handle refresh event
  Future<void> _onRefresh(
    ProfileEventRefresh event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileState.loading());

    // TODO: Implement refresh logic
    await Future.delayed(const Duration(seconds: 1));
    emit(const ProfileState.loaded('Data refreshed'));
  }

  /// Handle delete event
  Future<void> _onDelete(
    ProfileEventDelete event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileState.loading());

    // TODO: Implement delete logic
    // Example:
    // final params = DeleteParams(id: event.id);
    // final result = await deleteUseCase(params);
    //
    // result.fold(
    //   (failure) => emit(ProfileState.error(failure.message)),
    //   (data) => emit(const ProfileState.deleteSuccess()),
    // );

    await Future.delayed(const Duration(milliseconds: 500));
    emit(const ProfileState.deleteSuccess());
  }
}
