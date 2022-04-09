import 'package:flutter/material.dart';

import 'SizeConfig.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget portraitLayout;
  final Widget? landscapeLayout;

  const ResponsiveWidget({
    Key? key,
    required this.portraitLayout,
    this.landscapeLayout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (SizeConfig.isPortrait && SizeConfig.isMobilePortrait) {
      return portraitLayout;
    } else {
      return landscapeLayout ?? portraitLayout;
    }
  }
}