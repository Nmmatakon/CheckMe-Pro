import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    super.key,
    required this.answerCall,
    required this.buttonImage,
  });

  final VoidCallback answerCall;
  final String buttonImage;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return GestureDetector(
      onTap: answerCall,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  offset: Offset.zero,
                  blurRadius: 10,
                  spreadRadius: 2,
                  color: Color.fromARGB(20, 33, 149, 243)),
            ],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: appTheme.colorScheme.onPrimary)),
        height: 80,
        child: Image.asset(
          buttonImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
