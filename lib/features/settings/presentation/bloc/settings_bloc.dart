import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_solutions/core/error/failures.dart';
import 'package:qr_solutions/features/settings/domain/usecases/get_darkmode_usecase.dart';
import 'package:qr_solutions/features/settings/domain/usecases/set_darkmode_usecase.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetDarkModeUseCase _getDarkModeUseCase;
  final SetDarkModeUseCase _setDarkModeUseCase;

  SettingsBloc(
    this._getDarkModeUseCase,
    this._setDarkModeUseCase,
  ) : super(const SettingInitialState()) {
    on<ChangeDarkModeEvent>(_changeDarkMode);
    on<GetDarkModeEvent>(_getDarkMode);
  }
  _changeDarkMode(ChangeDarkModeEvent event, Emitter<SettingsState> emit) {
    final resp = _setDarkModeUseCase(event.isDarkMode);

    resp.fold(
        (updateDarkModeFailure) =>
            emit(SettingsFailureState(failure: updateDarkModeFailure)),
        (updateDarkModeSuccess) {
      debugPrint(
          'DarMode Changed was updated successfully, $updateDarkModeSuccess');
      add(GetDarkModeEvent());
    });
  }

  _getDarkMode(GetDarkModeEvent event, Emitter<SettingsState> emit) {
    final resp = _getDarkModeUseCase();

    resp.fold(
        (getDarkModeFailure) =>
            emit(SettingsFailureState(failure: getDarkModeFailure)),
        (getDarkModeSuccess) {
      debugPrint('DarkMode was taken successfully, $getDarkModeSuccess');
      emit(ChangeDarkModeState(getDarkModeSuccess));
    });
  }
}
