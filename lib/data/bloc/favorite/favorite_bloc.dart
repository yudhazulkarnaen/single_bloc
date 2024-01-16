import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_state.dart';
part 'favorite_event.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteModel initState = FavoriteModel(
      current: WordPair.random(), favorites: [], history: [], deletes: []);
  late FavoriteModel currentState;

  FavoriteBloc() : super(FavoriteInitial()) {
    // Reducer
    on<FavoriteEvent>((event, emit) {});
    on<InitialEvent>((event, emit) {
      currentState = initState;
      emit(FavoriteUpdateState(initialState: initState));
    });
    on<FavoriteGetNext>((event, emit) {
      var animatedList =
          currentState.historyListKey?.currentState as AnimatedListState?;
      animatedList?.insertItem(0);
      var tempFavorites = currentState.favorites;
      var tempDeletes = currentState.deletes;
      var tempHistory = currentState.history;

      tempHistory.insert(0, currentState.current);
      FavoriteModel temp = FavoriteModel(
          current: WordPair.random(),
          favorites: tempFavorites,
          deletes: tempDeletes,
          history: tempHistory);
      currentState = temp;

      emit(FavoriteUpdateState(initialState: temp));
    });
    on<FavoriteToggle>((event, emit) {
      var pair = event.pair;
      var tempFavorites = currentState.favorites;
      var tempDeletes = currentState.deletes;
      var tempHistory = currentState.history;

      if (currentState.favorites.contains(pair)) {
        tempFavorites.remove(pair);
      } else {
        tempFavorites.add(pair);
      }

      FavoriteModel temp = FavoriteModel(
          current: currentState.current,
          favorites: tempFavorites,
          deletes: tempDeletes,
          history: tempHistory);
      currentState = temp;

      emit(FavoriteUpdateState(initialState: temp));
    });

    on<RestoreToggle>((event, emit) {
      var pair = event.pair;
      var tempFavorites = currentState.favorites;
      var tempDeletes = currentState.deletes;
      var tempHistory = currentState.history;

      tempFavorites.add(pair);
      tempDeletes.remove(pair);

      FavoriteModel temp = FavoriteModel(
          current: currentState.current,
          favorites: tempFavorites,
          deletes: tempDeletes,
          history: tempHistory);
      currentState = temp;

      emit(FavoriteUpdateState(initialState: temp));
    });

    on<DeleteToggle>((event, emit) {
      var pair = event.pair;
      var tempFavorites = currentState.favorites;
      var tempDeletes = currentState.deletes;
      var tempHistory = currentState.history;

      tempFavorites.remove(pair);
      tempDeletes.add(pair);

      FavoriteModel temp = FavoriteModel(
          current: currentState.current,
          favorites: tempFavorites,
          deletes: tempDeletes,
          history: tempHistory);
      currentState = temp;

      emit(FavoriteUpdateState(initialState: temp));
    });
  }

  // void removeFavorite(WordPair pair) {
  //   favorites.remove(pair);
  //   notifyListeners();
  // }
}
