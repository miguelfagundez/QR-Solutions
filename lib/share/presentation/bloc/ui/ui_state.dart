part of 'ui_bloc.dart';

@immutable
abstract class UiState {
  final int indexSelected;

  const UiState({
    this.indexSelected = 0,
  });
}

class UiInitialState extends UiState {
  const UiInitialState() : super(indexSelected: 1);
}

class UiIndexChangeState extends UiState {
  final int newIndexSelected;

  const UiIndexChangeState({required this.newIndexSelected})
      : super(indexSelected: newIndexSelected);
}
