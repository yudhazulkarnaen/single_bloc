part of 'favorite_bloc.dart';

class FavoriteModel {
  final WordPair current;
  final List<WordPair> history;
  final List<WordPair> deletes;
  final List<WordPair> favorites;
  GlobalKey? historyListKey;

  FavoriteModel({
    required this.current,
    required this.history,
    required this.deletes,
    required this.favorites,
    this.historyListKey,
  });
}

@immutable
abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteUpdateState extends FavoriteState {
  FavoriteModel initialState;

  FavoriteUpdateState({
    required this.initialState,
  });
}
