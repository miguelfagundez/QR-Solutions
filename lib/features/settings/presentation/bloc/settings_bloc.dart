import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_solutions/core/error/failures.dart';
import 'package:qr_solutions/core/utils/constants.dart';
import 'package:qr_solutions/features/settings/domain/entities/settings.dart';
import 'package:qr_solutions/features/settings/domain/usecases/get_settings_usecase.dart';
import 'package:qr_solutions/features/settings/domain/usecases/set_settings_usecase.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SetSettingsUseCase _setSettingsUseCase;
  final GetSettingsUseCase _getSettingsUseCase;

  SettingsBloc(
    this._setSettingsUseCase,
    this._getSettingsUseCase,
  ) : super(SettingInitialState()) {
    on<ChangeSettingsEvent>(_changeSettings);
    on<GetSettingsEvent>(_getSettings);
  }

  _getSettings(GetSettingsEvent event, Emitter<SettingsState> emit) {
    final resp = _getSettingsUseCase();

    resp.fold(
        (getSettingsFailure) =>
            emit(SettingsFailureState(failure: getSettingsFailure)),
        (getSettingsSuccess) {
      debugPrint(
          'Settings was taken successfully, ${getSettingsSuccess.isDarkMode}, ${getSettingsSuccess.openWebAutomatically}, ${getSettingsSuccess.openEmailAutomatically}, ${getSettingsSuccess.openPhoneAutomatically}');
      emit(ChangeSettingsState(getSettingsSuccess));
    });
  }

  _changeSettings(ChangeSettingsEvent event, Emitter<SettingsState> emit) {
    final resp = _setSettingsUseCase(event.settings);

    resp.fold(
        (updateSettingsFailure) =>
            emit(SettingsFailureState(failure: updateSettingsFailure)),
        (updateSettingsSuccess) {
      debugPrint(
          'Settings was changed successfully, ${event.settings.isDarkMode}, ${event.settings.openWebAutomatically}, ${event.settings.openEmailAutomatically}, ${event.settings.openPhoneAutomatically}');
      add(GetSettingsEvent());
    });
  }

  // _changeDarkMode(ChangeDarkModeEvent event, Emitter<SettingsState> emit) {
  //   final resp = _setDarkModeUseCase(event.isDarkMode);

  //   resp.fold(
  //       (updateDarkModeFailure) =>
  //           emit(SettingsFailureState(failure: updateDarkModeFailure)),
  //       (updateDarkModeSuccess) {
  //     debugPrint(
  //         'DarMode Changed was updated successfully, $updateDarkModeSuccess');
  //     add(GetDarkModeEvent());
  //   });
  // }

  // _getDarkMode(GetDarkModeEvent event, Emitter<SettingsState> emit) {
  //   final resp = _getDarkModeUseCase();

  //   resp.fold(
  //       (getDarkModeFailure) =>
  //           emit(SettingsFailureState(failure: getDarkModeFailure)),
  //       (getDarkModeSuccess) {
  //     debugPrint('DarkMode was taken successfully, $getDarkModeSuccess');
  //     emit(ChangeDarkModeState(getDarkModeSuccess));
  //   });
  // }
}
