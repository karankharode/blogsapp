import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  HomepageBloc() : super(HomepageInitial());

  @override
  Stream<HomepageState> mapEventToState(
    HomepageEvent event,
  ) async* {
    yield HomepageLoading();
    if(event is ChangePageIndex){
      try{
        final index =  event.index;
        yield HomepageLoaded(index);
      } on Error {
        yield HomePageError("Couldn't fetch weather. Is the device online?");
      }
    }

  }
}
