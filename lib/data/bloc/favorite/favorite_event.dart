part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent {}

class InitialEvent extends FavoriteEvent {
  InitialEvent();
}

class FavoriteGetNext extends FavoriteEvent {
  FavoriteGetNext();
}

class DeleteToggle extends FavoriteEvent {
  final WordPair pair;

  DeleteToggle({
    required this.pair,
  });
}

class RestoreToggle extends FavoriteEvent {
  final WordPair pair;

  RestoreToggle({
    required this.pair,
  });
}

class FavoriteToggle extends FavoriteEvent {
  final WordPair pair;

  FavoriteToggle({
    required this.pair,
  });
}
