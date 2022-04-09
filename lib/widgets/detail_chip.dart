import 'package:flutter/material.dart';

import '../AppTheme.dart';

final Color chipBackgroundColor = Color(0xFFF6F6F6);

class DetailChip extends StatelessWidget {
  final IconData? iconData;
  final String? label;
  final TextStyle? textStyle;

  DetailChip({this.iconData, this.label, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return RawChip(
      label: Text(
        label!,
        style: textStyle,
      ),
      labelStyle: TextStyle(color: Colors.black, fontSize: 14.0),
      backgroundColor: chipBackgroundColor,
      avatar: iconData != null
          ? Icon(
              iconData,
              color: AppTheme.colorPrimary,
              size: 14.0,
            )
          : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
    );
  }
}
