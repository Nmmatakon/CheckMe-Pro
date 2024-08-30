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
