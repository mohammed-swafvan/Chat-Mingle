import 'package:chat_mingle/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
              height: screenHeight / 3.5,
              width: screenWidth,
              decoration: BoxDecoration(
                gradient:  const LinearGradient(
                  colors: [CustomColors.primaryColor, CustomColors.secondaryColor],
                  begin: Alignment.topLeft,
                  end: AlignmentDirectional.bottomEnd,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(screenWidth, 110.0),
                ),
              ),
            );
  }
}