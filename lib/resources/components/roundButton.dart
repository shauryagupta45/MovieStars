import 'package:flutter/material.dart';
import 'package:movie_stars/resources/color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;
  final Color buttonColor;
  final Color textColor;
  const RoundButton(
      {Key? key,
      required this.title,
      this.loading = false,
      required this.onPress,
      this.buttonColor = Colors.black,
      this.textColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 40,
        width: 200,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: loading
              ? const CircularProgressIndicator(color: Colors.white)
              : Text(
                  title,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }
}
