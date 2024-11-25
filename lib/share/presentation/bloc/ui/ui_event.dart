part of 'ui_bloc.dart';

@immutable
abstract class UiEvent {}

class IndexSelectedEvent extends UiEvent {
  final int indexSelected;

  IndexSelectedEvent({required this.indexSelected});
}
