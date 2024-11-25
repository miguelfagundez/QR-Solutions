import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ui_state.dart';
part 'ui_event.dart';

class UiBloc extends Bloc<UiEvent, UiState> {
  UiBloc() : super(const UiInitialState()) {
    on<IndexSelectedEvent>((event, emit) {
      emit(UiIndexChangeState(newIndexSelected: event.indexSelected));
    });
  }
}
