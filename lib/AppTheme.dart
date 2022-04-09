import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'SizeConfig.dart';

class AppTheme {
  AppTheme._();

  static const Color appBackgroundColor = Color(0xFFFFFFFF);

  static const Color colorPrimary = const Color(0xFF1660A9);
  static const Color colorPrimaryB = const Color(0xFFEFF2FB);
  static const Color colorWhitC = const Color(0xFFE3E6EB);
  static const Color colorWhitB = const Color(0xFFF4F4F4);
  static const Color gg = const Color(0xff94aaac);
  static const Color black = const Color(0xff20262C);
  static const Color greyO = const Color(0xff9D99A7);
  static const Color grey = const Color(0xffA1A3A6);

  static const Color itemColor = const Color(0xFFF8FAFB);
  static const Color lightGrey = const Color(0xffE1E2E4);
  static const Color extraDarkPurple = const Color(0xff494c79);

  static const Color titleTextColor = const Color(0xFF1d2635);
  static const Color subTitleTextColor = const Color(0xFF797878);

//  static const Color buttonsColor = const Color(0xFF2c3e50);
  static const Color buttonsColor = const Color(0xFF436f8a);
  static const Color buttonsTextColor = const Color(0xFFFFFEFD);

//  static const Color textOrangeColor = const Color(0xFFD37A54);
  static const Color textOrangeColor = const Color(0xFF56556e);

  static const Color buttonsGradientColor1 = const Color(0xFF4b5d67);
  static const Color buttonsGradientColor2 = const Color(0xFFEB4960);

  static const Color hintColor = const Color(0xff505A76);

  static const Color primary = Color(0xff696b9e);
  static const Color secondary = Color(0xfff29a94);

  static TextStyle h6Style = const TextStyle(fontSize: 14);

  static final appBarStyle = textStyle(colorPrimaryB, 20.0, FontWeight.w700);
  static final buttonTextStyle = textStyle(
      colorPrimaryB, 1.8 * SizeConfig.textMultiplier, FontWeight.w600);
  static final titleTextStyle = textStyle(
      titleTextColor, 2.0 * SizeConfig.textMultiplier, FontWeight.bold);

  static final textBlackBoldStyle =
      textStyle(black, 2.0 * SizeConfig.textMultiplier, FontWeight.bold);

  static final textWhiteStyle = textStyle(
      appBackgroundColor, 2.0 * SizeConfig.textMultiplier, FontWeight.w600);

  static final textOrangeColorStyle = textStyle(
      textOrangeColor, 2.0 * SizeConfig.textMultiplier, FontWeight.w600);

  static final textBoldStyle = textStyle(
      titleTextColor, 2.5 * SizeConfig.textMultiplier, FontWeight.bold);
  static final textBoldBlackStyle =
      textStyle(black, 2.5 * SizeConfig.textMultiplier, FontWeight.bold);
  static final textBoldBlackColorStyle =
      textStyle(buttonsColor, 2.5 * SizeConfig.textMultiplier, FontWeight.bold);
  static final textDarkStyleW700 =
      textStyle(buttonsColor, 2.0 * SizeConfig.textMultiplier, FontWeight.w700);

  static final titleOrangeTextStyle = textStyle(
      textOrangeColor, 2.0 * SizeConfig.textMultiplier, FontWeight.bold);

  static final textStyleWhite16w600 =
      textStyle(colorPrimaryB, 16.0, FontWeight.w600);

  static final textStyleDark16w700 =
      textStyle(buttonsColor, 16.0, FontWeight.w700);
  static final textStyleDark16w600 =
      textStyle(buttonsColor, 16.0, FontWeight.w600);
  static final textStyleDark18Bold =
      textStyle(buttonsColor, 18.0, FontWeight.bold);
  static final textStyleDark20w700 =
      textStyle(buttonsColor, 20.0, FontWeight.w700);

  static final textStyleBlack22w600 = textStyle(black, 22.0, FontWeight.w600);
  static final textStyleBlack16w600 = textStyle(black, 16.0, FontWeight.w600);

  static final textStyleGray16w600 = textStyle(grey, 16.0, FontWeight.w600);
  static final textStyleGray13w600 = textStyle(greyO, 13.0, FontWeight.w300);

  static final textStyleWhite20Bold =
      textStyle(appBackgroundColor, 20.0, FontWeight.bold);
  static final textStyleWhite20w600 =
      textStyle(appBackgroundColor, 20.0, FontWeight.w600);
  static final textStyleWhite14w600 =
      textStyle(appBackgroundColor, 14.0, FontWeight.w600);
  static final textStyleWhiteB16w600 =
      textStyle(appBackgroundColor, 16.0, FontWeight.w600);

  static final textStyleOrange20w700 =
      textStyle(textOrangeColor, 20.0, FontWeight.w700);
  static final textStyleOrange20Bold =
      textStyle(textOrangeColor, 20.0, FontWeight.bold);
  static final textStyleOrange16w700 =
      textStyle(textOrangeColor, 16.0, FontWeight.w700);

  static TextStyle textStyle(
          Color color, double fontSize, FontWeight fontWeight) =>
      TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: "Cairo",
        fontWeight: fontWeight,
      );

  //________________________________________________________________________________________
  static List<BoxShadow> shadows = [
    BoxShadow(
      color: Colors.black38,
      blurRadius: 5.0,
      offset: Offset(5, 5),
    )
  ];

  //_________________________________________________________________________________________________
  static Widget showLoadingSpinKit() => SpinKitFoldingCube(
        color: buttonsGradientColor1,
        size: 10 * SizeConfig.imageSizeMultiplier,
      );

  //_________________________________________________________________________________________________
  static InputBorder border() => OutlineInputBorder(
        borderSide: BorderSide(color: AppTheme.buttonsColor, width: 1),
        borderRadius: BorderRadius.circular(30.0),
      );

  static InputBorder borderGray() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(
          color: subTitleTextColor,
          width: 1.0,
        ),
      );

//__________________________________________________________________________________________________
  static Theme datePickerTheme(Widget child) => Theme(
        data: ThemeData.light().copyWith(
          primaryColor: AppTheme.buttonsColor,
          accentColor: AppTheme.buttonsColor,
          colorScheme: ColorScheme.light(primary: AppTheme.buttonsColor),
          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
        ),
        child: child,
      );

//  ______________________________________________________________________________________________

  static final titleTextTheme = TextStyle(
    fontSize: 2 * SizeConfig.textMultiplier,
    color: black,
    fontFamily: "Cairo",
  );

  static final titleTextWightTheme = TextStyle(
    fontSize: 2 * SizeConfig.textMultiplier,
    color: appBackgroundColor,
    fontFamily: "Cairo",
  );

  static final subTitleTextWightTheme = TextStyle(
    fontSize: 1.5 * SizeConfig.textMultiplier,
    color: itemColor,
    fontFamily: "Cairo",
  );

  static final TextStyle subTitleTheme = TextStyle(
    fontWeight: FontWeight.bold,
    color: black,
    fontSize: 1.7 * SizeConfig.textMultiplier,
    fontFamily: "Cairo",
  );

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppTheme.appBackgroundColor,
    brightness: Brightness.light,
    fontFamily: "Cairo",
    primaryColor: buttonsColor,
    splashColor: buttonsColor,
    appBarTheme: AppBarTheme(color: buttonsColor),
  );
}
