import 'package:flutter/material.dart';

AppBar customAppBar(String? title) {
  return AppBar(
    centerTitle: false,
    forceMaterialTransparency: true,
    title: title != null ? Text(title) : const SizedBox(),
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
        child: Image.asset(
          "assets/images/empreinte.png",
          fit: BoxFit.cover,
        ),
      )
    ],
  );
}

Route createRoute(Widget screen) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.linear;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
