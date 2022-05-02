import 'package:flutter/material.dart';

class CloseBtn extends StatelessWidget {
  const CloseBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(244, 245, 255, 0.4), borderRadius: BorderRadius.circular(6)),
        child: Image.asset("./assets/images/close.png"),
      ),
    );
  }
}
