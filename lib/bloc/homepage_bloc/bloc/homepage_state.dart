part of 'homepage_bloc.dart';

abstract class HomepageState extends Equatable {
  const HomepageState();
  
  @override
  List<Object> get props => [];
}

class HomepageInitial extends HomepageState {
  const HomepageInitial();
  @override
  List<Object> get props => [];
}
class HomepageLoading extends HomepageState {
  const HomepageLoading();
  @override
  List<Object> get props => [];
}
class HomepageLoaded extends HomepageState {
  final int index;
  const HomepageLoaded(this.index);
  @override
  List<Object> get props => [index];
}
class HomePageError extends HomepageState {
  final String message;
  const HomePageError(this.message);
  @override
  List<Object> get props => [message];
}
