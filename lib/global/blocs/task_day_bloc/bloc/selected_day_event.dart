part of 'selected_day_bloc.dart';

@immutable
abstract class SelectedDayEvent {}

class SelectedDayChanded extends SelectedDayEvent {
  final DateTime day;

  SelectedDayChanded({required this.day});
}

class SelectedDayWithDuration extends SelectedDayEvent {
  final int duration;

  SelectedDayWithDuration(this.duration);
}

class SelectedDayAdd extends SelectedDayEvent {
  final int duration;
  SelectedDayAdd(this.duration);
}

class SelectedDaySubstract extends SelectedDayEvent {
  final int duration;
  
  SelectedDaySubstract(this.duration);
}
