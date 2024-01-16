import 'package:flutter/material.dart';

class NamedNavigationRailItemWidget extends NavigationRailDestination {
  final String initialLocation;

  NamedNavigationRailItemWidget(
      {required this.initialLocation,
      required Widget icon,
      required Widget label})
      : super(icon: icon, label: label);
}
