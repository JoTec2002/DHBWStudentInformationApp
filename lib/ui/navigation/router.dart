import 'package:dhbwstudentapp/date_management/ui/date_management_navigation_entry.dart';
import 'package:dhbwstudentapp/dualis/ui/dualis_navigation_entry.dart';
import 'package:dhbwstudentapp/information/ui/useful_information_navigation_entry.dart';
import 'package:dhbwstudentapp/schedule/ui/schedule_navigation_entry.dart';
import 'package:dhbwstudentapp/ui/main_page.dart';
import 'package:dhbwstudentapp/ui/navigation/navigation_entry.dart';
import 'package:dhbwstudentapp/ui/onboarding/onboarding_page.dart';
import 'package:dhbwstudentapp/ui/settings/settings_page.dart';
import 'package:flutter/material.dart';

final List<NavigationEntry> navigationEntries = [
  ScheduleNavigationEntry(),
  DualisNavigationEntry(),
  DateManagementNavigationEntry(),
  UsefulInformationNavigationEntry(),
];

Route<dynamic> generateDrawerRoute(RouteSettings settings) {
  print("=== === === === === === Navigating to: ${settings.name}");

  var widget;

  for (var route in navigationEntries) {
    if (route.route == settings.name) {
      widget = route.buildRoute;
      break;
    }
  }

  if (widget == null) {
    print("Failed to navigate to: " + settings.name);
    widget = (BuildContext context) => Container();
  }

  return PageRouteBuilder(
    settings: settings,
    transitionDuration: Duration(milliseconds: 200),
    pageBuilder: (context, animation, secondaryAnimation) => widget(context),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var offsetBegin = Offset(0.0, 0.005);
      var offsetEnd = Offset.zero;
      var offsetTween = Tween(begin: offsetBegin, end: offsetEnd)
          .chain(CurveTween(curve: Curves.fastOutSlowIn));

      var opacityBegin = 0.0;
      var opacityEnd = 1.0;
      var opacityTween = Tween(begin: opacityBegin, end: opacityEnd)
          .chain(CurveTween(curve: Curves.fastOutSlowIn));

      return SlideTransition(
        position: animation.drive(offsetTween),
        child: FadeTransition(
          opacity: animation.drive(opacityTween),
          child: Container(
            child: child,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      );
    },
  );
}

Route<dynamic> generateRoute(RouteSettings settings) {
  print("=== === === === === === Navigating to: ${settings.name}");
  var target;

  switch (settings.name) {
    case "onboarding":
      target = OnboardingPage();
      break;
    case "main":
      target = MainPage();
      break;
    case "settings":
      target = SettingsPage();
      break;
    default:
      print("Failed to navigate to: " + settings.name);
      target = Container();
  }

  return MaterialPageRoute(builder: (_) => target, settings: settings);
}
