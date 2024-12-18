import 'package:flutter/material.dart';
import 'carousel_manager.dart';

class AppRoutes {
  static const String carouselPage = '/carouselPage';

  static Map<String, WidgetBuilder> routes = {
    carouselPage: (context) => CarouselPage(),
  };
}
