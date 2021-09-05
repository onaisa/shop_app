part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}
class GetSearchLoudingState extends SearchState {}

class GetSearchSucessesState extends SearchState {}

class GetSearchErrorState extends SearchState {
  final String error;
  GetSearchErrorState(this.error);
}

class FinishSearchState extends SearchState {}
