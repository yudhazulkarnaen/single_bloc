import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:test_flutter/data/bloc/delete/delete_bloc.dart';
// import 'package:provider/provider.dart';

import '../../../../data/bloc/favorite/favorite_bloc.dart';
// import '../../../../data/bloc/delete/delete_bloc.dart';
// import '../../../../data/providers/app_state_provider.dart';

class FavoritesPage extends StatefulWidget {
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  // void initState() {
  //   super.initState();
  //   context.read<FavoriteBloc>().add(InitialEvent());
  // }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    // var appState = context.watch<AppStateProvider>();

    var blocState = context.watch<FavoriteBloc>();

    // if (appState.favorites.isEmpty) {
    //   return Center(
    //     child: Text('No favorites yet.'),
    //   );
    // }

    if (blocState.initState.favorites.isEmpty) {
      return Center(child: Text("No favorites yet."));
    }

    return BlocBuilder<FavoriteBloc, FavoriteState>(builder: (context, state) {
      final blocWatcher = context.read<FavoriteBloc>();
      final stateObject = blocWatcher.currentState;

      if (stateObject.favorites.isEmpty) {
        return Center(child: Text('No favorites yet.'));
      }

      // final blocWatcher = context.read<FavoriteBloc>();
      // final stateObject = state.initialState;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Text('You have '
                '${stateObject.favorites.length} favorites:'),
          ),
          Expanded(
            // Make better use of wide windows with a grid.
            child: GridView(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400,
                childAspectRatio: 400 / 80,
              ),
              children: [
                for (var pair in stateObject.favorites)
                  ListTile(
                    leading: IconButton(
                      icon: Icon(Icons.delete_outline, semanticLabel: 'Delete'),
                      color: theme.colorScheme.primary,
                      onPressed: () {
                        blocWatcher.add(DeleteToggle(pair: pair));
                        // print("Delete button pressed");
                      },
                    ),
                    title: Text(
                      pair.asLowerCase,
                      semanticsLabel: pair.asPascalCase,
                    ),
                  ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
