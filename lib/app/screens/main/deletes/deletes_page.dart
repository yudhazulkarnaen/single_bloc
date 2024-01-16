import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/bloc/favorite/favorite_bloc.dart';

class DeletesPage extends StatefulWidget {
  @override
  State<DeletesPage> createState() => _DeletesPageState();
}

class _DeletesPageState extends State<DeletesPage> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var blocState = context.watch<FavoriteBloc>();

    if (blocState.initState.deletes.isEmpty) {
      return Center(child: Text("No deletes yet."));
    }

    return BlocConsumer<FavoriteBloc, FavoriteState>(
      listener: (context, state) => {},
      builder: (context, state) {
        if (state is! FavoriteUpdateState) {
          return Container();
        }

        final blocWatcher = context.read<FavoriteBloc>();
        final stateObject = state.initialState;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Text('You have '
                  '${stateObject.deletes.length} deletes:'),
            ),
            Expanded(
              // Make better use of wide windows with a grid.
              child: GridView(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400,
                  childAspectRatio: 400 / 80,
                ),
                children: [
                  for (var pair in stateObject.deletes)
                    ListTile(
                      leading: IconButton(
                        icon:
                            Icon(Icons.delete_outline, semanticLabel: 'Delete'),
                        color: theme.colorScheme.primary,
                        onPressed: () {
                          blocWatcher.add(RestoreToggle(pair: pair));
                          print("Delete button pressed");
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
      },
    );
  }
}
