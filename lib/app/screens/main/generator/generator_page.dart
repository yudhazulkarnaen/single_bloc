import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/bloc/favorite/favorite_bloc.dart';
import 'big_card.dart';
import 'history_list_view.dart';

class GeneratorPage extends StatefulWidget {
  @override
  State<GeneratorPage> createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {
  @override
  void initState() {
    super.initState();

    context.read<FavoriteBloc>().add(InitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteBloc, FavoriteState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is! FavoriteUpdateState) {
          return Container();
        }
        final blocWatcher = context.read<FavoriteBloc>();
        final stateObject = state.initialState;

        var pair = stateObject.current;

        IconData icon;
        if (stateObject.favorites.contains(pair)) {
          icon = Icons.favorite;
        } else {
          icon = Icons.favorite_border;
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: HistoryListView(),
              ),
              SizedBox(height: 10),
              BigCard(pair: pair),
              SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      blocWatcher.add(FavoriteToggle(pair: pair));
                    },
                    icon: Icon(icon),
                    label: Text('Like'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      blocWatcher.add(FavoriteGetNext());
                    },
                    child: Text('Next'),
                  ),
                ],
              ),
              Spacer(flex: 2),
            ],
          ),
        );
      },
    );
  }
}
