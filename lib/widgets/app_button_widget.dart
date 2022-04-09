import 'package:flutter/material.dart';

import '../AppTheme.dart';
import '../SizeConfig.dart';

class AppButtonWidget extends StatelessWidget {
  final String? buttonText;
  final Function? onButtonClicked;

  AppButtonWidget({this.buttonText, this.onButtonClicked});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onButtonClicked!(),
      child: Center(
        child: Container(
          width: 80 * SizeConfig.widthMultiplier,
          height: 6 * SizeConfig.heightMultiplier,
          decoration: BoxDecoration(
            color: AppTheme.buttonsColor,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: AppTheme.shadows,
          ),
          child: Center(
            child: Text(
              buttonText!,
              style: AppTheme.buttonTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
