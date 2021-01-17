import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50: Color.fromRGBO(117, 119, 151, .1),
      100: Color.fromRGBO(117, 119, 151, .2),
      200: Color.fromRGBO(117, 119, 151, .3),
      300: Color.fromRGBO(117, 119, 151, .4),
      400: Color.fromRGBO(117, 119, 151, .5),
      500: Color.fromRGBO(117, 119, 151, .6),
      600: Color.fromRGBO(117, 119, 151, .7),
      700: Color.fromRGBO(117, 119, 151, .8),
      800: Color.fromRGBO(117, 119, 151, .9),
      900: Color.fromRGBO(117, 119, 151, 1),
    };
    return AppBar(
      backgroundColor: MaterialColor(0xFFE5F3FF, color),
      elevation: 0.0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(25.0);
}
