import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/bloc/favorite/favorite_bloc.dart';
import '../../../../data/providers/app_state_provider.dart';

class HistoryListView extends StatefulWidget {
  const HistoryListView({Key? key}) : super(key: key);

  @override
  State<HistoryListView> createState() => _HistoryListViewState();
}

class _HistoryListViewState extends State<HistoryListView> {
  /// Needed so that [AppStateProvider] can tell [AnimatedList] below to animate
  /// new items.
  final _key = GlobalKey();

  /// Used to "fade out" the history items at the top, to suggest continuation.
  static const Gradient _maskingGradient = LinearGradient(
    // This gradient goes from fully transparent to fully opaque black...
    colors: [Colors.transparent, Colors.black],
    // ... from the top (transparent) to half (0.5) of the way to the bottom.
    stops: [0.0, 0.5],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteBloc, FavoriteState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is! FavoriteUpdateState) {
            return Container();
          }

          final stateObject = state.initialState;
          stateObject.historyListKey = _key;

          return ShaderMask(
            shaderCallback: (bounds) => _maskingGradient.createShader(bounds),
            // This blend mode takes the opacity of the shader (i.e. our gradient)
            // and applies it to the destination (i.e. our animated list).
            blendMode: BlendMode.dstIn,
            child: AnimatedList(
              key: _key,
              reverse: true,
              padding: EdgeInsets.only(top: 100),
              initialItemCount: stateObject.history.length,
              itemBuilder: (context, index, animation) {
                final pair = stateObject.history[index];
                return SizeTransition(
                  sizeFactor: animation,
                  child: Center(
                    child: TextButton.icon(
                      onPressed: () {
                        // stateObject.toggleFavorite(pair);
                      },
                      icon: stateObject.favorites.contains(pair)
                          ? Icon(Icons.favorite, size: 12)
                          : SizedBox(),
                      label: Text(
                        pair.asLowerCase,
                        semanticsLabel: pair.asPascalCase,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
