import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'blogsfeed_event.dart';
part 'blogsfeed_state.dart';

class BlogsfeedBloc extends Bloc<BlogsfeedEvent, BlogsfeedState> {
  BlogsfeedBloc() : super(BlogsfeedInitial());

  @override
  Stream<BlogsfeedState> mapEventToState(
    BlogsfeedEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
