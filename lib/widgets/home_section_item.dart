import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../AppTheme.dart';
import '../SizeConfig.dart';

class HomeSectionItem extends StatelessWidget {
  final String? itemImageURL;
  final String? itemText;
  final Function? onItemClicked;
  final bool isHomePage;
  final bool isSmallIcon;

  HomeSectionItem(
      {this.itemImageURL,
      this.itemText,
      this.onItemClicked,
      this.isHomePage = true,
      this.isSmallIcon = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: InkWell(
        onTap: onItemClicked as void Function()?,
        child: Container(
          height: isHomePage
              ? MediaQuery.of(context).size.width * 0.3
              : MediaQuery.of(context).size.width * 0.4, //90.0,
          width: isHomePage
              ? MediaQuery.of(context).size.width * 0.3
              : MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppTheme.appBackgroundColor,
            ),
            color: AppTheme.appBackgroundColor,
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
//              isHomePage
//                  ? ImageIcon(
//                      AssetImage(itemImageURL),
//                      color: AppTheme.textOrangeColor,
//                      size: 9 * SizeConfig.imageSizeMultiplier,
//                    )
//                  :
              SvgPicture.asset(
                itemImageURL!,
                color: AppTheme.textOrangeColor,
                height: isSmallIcon
                    ? 9 * SizeConfig.imageSizeMultiplier
                    : MediaQuery.of(context).size.width * 0.150,
                width: isSmallIcon
                    ? 9 * SizeConfig.imageSizeMultiplier
                    : MediaQuery.of(context).size.width * 0.150,
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: FittedBox(
                  child: AutoSizeText(
                    itemText!,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: AppTheme.subTitleTheme,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
