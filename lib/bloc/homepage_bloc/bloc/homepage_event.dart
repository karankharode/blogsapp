part of 'homepage_bloc.dart';

abstract class HomepageEvent extends Equatable {
  const HomepageEvent();

  @override
  List<Object> get props => [];
}
class ChangePageIndex extends HomepageEvent {
  final int index;

  const ChangePageIndex(this.index);

  @override
  List<Object> get props => [index];
}