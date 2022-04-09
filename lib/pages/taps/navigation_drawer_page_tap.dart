import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eqaila_app/bloc/members/members_bloc.dart';
import 'package:eqaila_app/bloc/social_news/social_news_bloc.dart';
import 'package:eqaila_app/models/models.dart';
import 'package:eqaila_app/pages/shareholder_screens/signIn_shareholder_screen.dart';
import 'package:eqaila_app/repository/members_repository.dart';
import 'package:eqaila_app/repository/social_news_repository.dart';
import 'package:eqaila_app/utils/strings.dart';

import '../../AppTheme.dart';
import '../../SizeConfig.dart';
import '../members_page.dart';
import '../social_news_page.dart';

class NavigationDrawerPageTap extends StatelessWidget {
  final SectionsModel? sections;

  NavigationDrawerPageTap(this.sections);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Strings.news,
          style: AppTheme.appBarStyle,
        ),
      ),
      body: SafeArea(
        child: Container(
          //color: AppTheme.buttonsColor,
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            children: <Widget>[
              //headerWidget(),
              sectionsWidget(),
            ],
          ),
        ),
      ),
    );
  }

  /// header Widget
  Widget headerWidget() {
    return Container(
      color: AppTheme.buttonsColor,
      child: DrawerHeader(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ImageIcon(
              AssetImage("assets/images/navheaderuser.png"),
              color: Colors.white,
              size: 10 * SizeConfig.imageSizeMultiplier,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 8.0),
            //   child: AutoSizeText(
            //     Strings.shareholderSignInButton,
            //     style: TextStyle(color: Colors.white, fontSize: 20),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Widget sectionsWidget() {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(
            right: 1.5 * SizeConfig.heightMultiplier,
            left: 1.5 * SizeConfig.heightMultiplier,
          ),
          child: Divider(
            color: AppTheme.gg,
            height: 1.0,
          ),
        );
      },
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: sections!.results!.length + 2,
      itemBuilder: (BuildContext context, int index) {
        if (index <= sections!.results!.length - 1) {
          return baseNewsItems(context, index);
        } else if (index <= sections!.results!.length) {
          return addNewItem(
            context,
            text: Strings.boardOfDirectors,
            onClick: () => toMembersPageEvent(context),
          );
        } else {
          return addNewItem(
            context,
            text: Strings.shareholders,
            onClick: () => toShareholderSignInScreenEvent(context),
          );
        }
      },
    );
  }

  /// sections ListView Widget
  // Widget sectionsWidget() {
  //   return ListView.separated(
  //     separatorBuilder: (context, index) {
  //       return Container(
  //         margin: EdgeInsets.only(
  //           right: 1.5 * SizeConfig.heightMultiplier,
  //           left: 1.5 * SizeConfig.heightMultiplier,
  //         ),
  //         child: Divider(
  //           color: AppTheme.gg,
  //           height: 1.0,
  //         ),
  //       );
  //     },
  //     physics: NeverScrollableScrollPhysics(),
  //     shrinkWrap: true,
  //     itemCount: sections!.results!.length + 2,
  //     itemBuilder: (BuildContext context, int index) {
  //       if (index <= sections!.results!.length - 1) {
  //         return baseNewsItems(context, index);
  //       } else if (index == sections!.results!.length) {
  //         return addNewItem(
  //           context,
  //           text: Strings.boardOfDirectors,
  //           onClick: () => toMembersPageEvent(context),
  //         );
  //       } else {
  //         return addNewItem(
  //           context,
  //           text: Strings.shareholders,
  //           onClick: () => toShareholderSignInScreenEvent(context),
  //         );
  //       }
  //     },
  //   );
  // }

  /// base News List Items
  Widget baseNewsItems(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.only(
          right: 2.0 * SizeConfig.heightMultiplier,
          left: 2.0 * SizeConfig.heightMultiplier,
          top: 1 * SizeConfig.heightMultiplier,
          bottom: 1 * SizeConfig.heightMultiplier),
      child: InkWell(
        onTap: () => toSocialNewsPageEvent(context, index),
        child: Row(
          children: <Widget>[
            ImageIcon(
              AssetImage("assets/images/navbaricon.png"),
              color: AppTheme.textOrangeColor,
              size: 6 * SizeConfig.imageSizeMultiplier,
            ),
            Padding(
              padding: EdgeInsets.only(right: 8.0, left: 8.0),
              child: Text(
                sections!.results![index].newSectionName!,
                style: AppTheme.titleTextStyle,
                maxLines: 1,
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Add New Item in List
  Widget addNewItem(BuildContext context,
      {required String text, Function? onClick}) {
    return Padding(
      padding: EdgeInsets.only(
          right: 2.0 * SizeConfig.heightMultiplier,
          left: 2.0 * SizeConfig.heightMultiplier,
          top: 1 * SizeConfig.heightMultiplier,
          bottom: 1 * SizeConfig.heightMultiplier),
      child: InkWell(
        onTap: () => onClick!(),
        child: Row(
          children: <Widget>[
            ImageIcon(
              AssetImage("assets/images/navbaricon.png"),
              color: AppTheme.textOrangeColor,
              size: 6 * SizeConfig.imageSizeMultiplier,
            ),
            Padding(
              padding: EdgeInsets.only(right: 8.0, left: 8.0),
              child: Text(
                text,
                style: AppTheme.titleTextStyle,
                maxLines: 1,
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Navigate to SocialNewsPage Event
  void toSocialNewsPageEvent(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return BlocProvider<SocialNewsBloc>(
          create: (context) => SocialNewsBloc(SocialNewsRepositoryImpl()),
          child: SocialNewsPage(sections!.results![index].newSectionId,
              sections!.results![index].newSectionName),
        );
      }),
    );
  }

  /// Navigate to ShareholderSignInScreen Event
  void toShareholderSignInScreenEvent(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return ShareholderSignInScreen();
      }),
    );
  }

  /// Navigate to MembersPage Event
  void toMembersPageEvent(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return BlocProvider<MembersBloc>(
          create: (context) =>
              MembersBloc(MembersRepositoryImpl())..add(FetchMembersData()),
          child: MembersPage(),
        );
      }),
    );
  }
}
