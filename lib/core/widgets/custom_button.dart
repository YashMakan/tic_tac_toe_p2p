import 'package:flutter/material.dart';
import 'package:nice_buttons/nice_buttons.dart';
import 'package:tic_tac_toe_p2p/core/constants/enums.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final ButtonStyleType buttonStyleType;
  final Function() onTap;

  const CustomButton(
      {super.key,
      required this.title,
      required this.buttonStyleType,
      required this.onTap});

  bool get isButtonStyleTypeAsPurple =>
      buttonStyleType == ButtonStyleType.purple;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(32)),
      child: NiceButtons(
        gradientOrientation: GradientOrientation.Horizontal,
        startColor: isButtonStyleTypeAsPurple
            ? const Color(0xFFB85FFF)
            : const Color(0xFFA6F208),
        endColor: isButtonStyleTypeAsPurple
            ? const Color(0xFFAB50F4)
            : const Color(0xFF67EB00),
        borderColor: isButtonStyleTypeAsPurple
            ? const Color(0xFF9023E8)
            : const Color(0xFF4EC307),
        borderRadius: 32,
        stretch: false,
        onTap: (finish) {
          onTap.call();
        },
        child: Center(
          child: Text(
            title,
            style: textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                shadows: [
                  const BoxShadow(color: Colors.black38, blurRadius: 8)
                ]),
          ),
        ),
      ),
    );
  }
}
