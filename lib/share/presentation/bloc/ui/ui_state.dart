part of 'ui_bloc.dart';

@immutable
abstract class UiState {
  final int indexSelected;

  const UiState({
    required this.indexSelected,
  });
}

class UiInitialState extends UiState {
  const UiInitialState() : super(indexSelected: 0);
}

class UiIndexChangeState extends UiState {
  final int newIndexSelected;

  const UiIndexChangeState({required this.newIndexSelected})
      : super(indexSelected: newIndexSelected);
}
