import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_flutter/app/widgets/named_nav_rail_item_widget.dart';

import '../../../data/cubit/navigation/navigation_cubit.dart';
import '../../../system/constants/constants.dart';
import '../../widgets/named_nav_bar_item_widget.dart';

class NavigationData {
  final String label;
  final String initialLocation;
  final Icon icon;

  const NavigationData({
    required this.label,
    required this.initialLocation,
    required this.icon,
  });
}

class MainPage extends StatelessWidget {
  final Widget screen;

  MainPage({Key? key, required this.screen}) : super(key: key);

  final List<NavigationData> navigationIndicatorList = [
    NavigationData(
        label: 'Generator',
        initialLocation: Routes.generatorNamedPage,
        icon: const Icon(Icons.home)),
    NavigationData(
        label: 'Favorites',
        initialLocation: Routes.favoritesNamedPage,
        icon: const Icon(Icons.favorite)),
    NavigationData(
        label: 'Deletes',
        initialLocation: Routes.deletesNamedPage,
        icon: const Icon(Icons.delete)),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 450) {
        final bottomNavigationTabList = navigationIndicatorList
            .map((e) => NamedNavigationBarItemWidget(
                  initialLocation: e.initialLocation,
                  icon: e.icon,
                  label: e.label,
                ))
            .toList();

        return Scaffold(
          body: screen,
          bottomNavigationBar:
              _buildBottomNavigation(context, bottomNavigationTabList),
        );
      }

      final navigationRailList = navigationIndicatorList
          .map((e) => NamedNavigationRailItemWidget(
                initialLocation: e.initialLocation,
                icon: e.icon,
                label: Text(e.label),
              ))
          .toList();

      return Scaffold(
        body: _buildNavigationRail(
            context, navigationRailList, constraints, screen),
      );
    });
  }
}

BlocBuilder<NavigationCubit, NavigationState> _buildBottomNavigation(
        mContext, List<NamedNavigationBarItemWidget> tabs) =>
    BlocBuilder<NavigationCubit, NavigationState>(
      buildWhen: (previous, current) => previous.index != current.index,
      builder: (context, state) {
        final appState = context.read<NavigationCubit>();

        return BottomNavigationBar(
          onTap: (value) {
            if (state.index != value) {
              appState.getNavBarItem(value);
              context.go(tabs[value].initialLocation);
            }
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          backgroundColor: Colors.black,
          unselectedItemColor: Colors.white,
          selectedIconTheme: IconThemeData(
            size: ((IconTheme.of(mContext).size)! * 1.3),
          ),
          items: tabs,
          currentIndex: state.index,
          type: BottomNavigationBarType.fixed,
        );
      },
    );

BlocBuilder<NavigationCubit, NavigationState> _buildNavigationRail(
        mContext,
        List<NamedNavigationRailItemWidget> tabs,
        BoxConstraints constraints,
        Widget screen) =>
    BlocBuilder<NavigationCubit, NavigationState>(
      buildWhen: (previous, current) => previous.index != current.index,
      builder: (context, state) {
        return Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: tabs,
                selectedIndex: state.index,
                onDestinationSelected: (value) {
                  if (state.index != value) {
                    context.read<NavigationCubit>().getNavBarItem(value);
                    context.go(tabs[value].initialLocation);
                  }
                },
              ),
            ),
            Expanded(child: screen),
          ],
        );
      },
    );
