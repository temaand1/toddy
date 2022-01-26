import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'selected_day_event.dart';

class SelectedDayBloc extends Bloc<SelectedDayEvent, DateTime> {
  SelectedDayBloc() : super(DateTime.now()) {
    on<SelectedDayChanded>((event, emit) {
      emit(event.day);
    });
    on<SelectedDayWithDuration>((event, emit) {

      emit(DateTime.now().add(Duration(days: event.duration)));
    });
  }
}
