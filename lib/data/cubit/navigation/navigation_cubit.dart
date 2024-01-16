import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../system/constants/constants.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit()
      : super(const NavigationState(
            bottomNavItems: Routes.generatorNamedPage, index: 0));

  void getNavBarItem(int index) {
    switch (index) {
      case 0:
        emit(const NavigationState(
            bottomNavItems: Routes.generatorNamedPage, index: 0));
      case 1:
        emit(const NavigationState(
            bottomNavItems: Routes.favoritesNamedPage, index: 1));
      case 2:
        emit(const NavigationState(
            bottomNavItems: Routes.deletesNamedPage, index: 2));
    }
  }

  @override
  void onChange(Change<NavigationState> change) {
    super.onChange(change);
    print(change);
  }
}
