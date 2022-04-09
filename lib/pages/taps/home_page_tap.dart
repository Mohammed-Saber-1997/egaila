import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:eqaila_app/bloc/item_report/report_item_bloc.dart';
import 'package:eqaila_app/bloc/members/members_bloc.dart';
import 'package:eqaila_app/bloc/send_complaint/send_complaint_bloc.dart';
import 'package:eqaila_app/bloc/social_news/social_news_bloc.dart';
import 'package:eqaila_app/bloc/story_details/story_details_bloc.dart';
import 'package:eqaila_app/models/models.dart';
import 'package:eqaila_app/repository/members_repository.dart';
import 'package:eqaila_app/repository/report_item_repository.dart';
import 'package:eqaila_app/repository/send_complaint_repository.dart';
import 'package:eqaila_app/repository/social_news_repository.dart';
import 'package:eqaila_app/repository/story_details_repository.dart';
import 'package:eqaila_app/utils/images.dart';
import 'package:eqaila_app/utils/strings.dart';
import 'package:eqaila_app/widgets/home_section_item.dart';

import '../../AppTheme.dart';
import '../../SizeConfig.dart';
import '../../constants.dart';
import '../complaint_page.dart';
import '../members_page.dart';
import '../report_item_page.dart';
import '../screen_scanner_page.dart';
import '../social_news_page.dart';
import '../story_details_page.dart';

class HomePageTap extends StatelessWidget {
  final HomeSliderModel? homeSliderList;

  HomePageTap(this.homeSliderList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Strings.home,
          style: AppTheme.appBarStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            homeImageSlider(context, homeSliderList),
            homeSectionItems(context),
          ],
        ),
      ),
    );
  }

  /// home News Image Slider
  Widget homeImageSlider(
          BuildContext context, HomeSliderModel? homeSliderList) =>
      Container(
        color: AppTheme.appBackgroundColor,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ConstrainedBox(
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Swiper(
                autoplay: true,
                autoplayDelay: 6000,
                scrollDirection: Axis.horizontal,
                outer: false,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return BlocProvider<StoryDetailsBloc>(
                            create: (context) =>
                                StoryDetailsBloc(StoryDetailsRepositoryImpl()),
                            child: StoryDetailsPage(
                              homeSliderList!.results![index].newId,
                            ),
                          );
                        }),
                      );
                    },
                    child: Wrap(
                      runSpacing: 6.0,
                      children: [0].map((i) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Center(
                              child: Container(
                                height: 30 * SizeConfig.heightMultiplier,
                                width: MediaQuery.of(context).size.width * 0.95,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      "$BASE_URL/Content/Upload/Slider/${homeSliderList!.results![index].pictureName}",
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: .5 * SizeConfig.heightMultiplier,
                                  right: 1 * SizeConfig.heightMultiplier,
                                  left: 1 * SizeConfig.heightMultiplier),
                              child: Text(
                                homeSliderList.results![index].title!,
                                overflow: TextOverflow.ellipsis,
                                style: AppTheme.titleTextStyle,
                                maxLines: 2,
                              ),
                            )
                          ],
                        );
                      }).toList(),
                    ),
                  );
                },
                pagination: SwiperPagination(
                  margin: EdgeInsets.all(5.0),
                  builder: DotSwiperPaginationBuilder(
                    activeColor: AppTheme.buttonsColor,
                    color: AppTheme.gg,
                  ),
                ),
                itemCount: homeSliderList!.results!.length,
              ),
            ),
            constraints: BoxConstraints.loose(
              Size(MediaQuery.of(context).size.width,
                  43 * SizeConfig.heightMultiplier),
            ),
          ),
        ),
      );

  /// home Section Items
  Widget homeSectionItems(BuildContext context) => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  HomeSectionItem(
                    isSmallIcon: true,
                    itemImageURL: Images.socialNewsIcon,
                    itemText: Strings.socialNews,
                    onItemClicked: () => navigateToSocialNewsPageEvent(
                        context, 2, Strings.socialNews),
                  ),
                  verticalDividerWidget(
                    context,
                    padding: EdgeInsets.only(top: 20.0),
                  ),
                  HomeSectionItem(
                    isSmallIcon: true,
                    itemImageURL: Images.jamianews,
                    itemText: Strings.unionNews,
                    onItemClicked: () => navigateToSocialNewsPageEvent(
                        context, 8, Strings.unionNews),
                  ),
                  verticalDividerWidget(
                    context,
                    padding: EdgeInsets.only(top: 20.0),
                  ),
                  HomeSectionItem(
                    isSmallIcon: true,
                    itemImageURL: Images.offers,
                    itemText: Strings.offers,
                    onItemClicked: () => navigateToSocialNewsPageEvent(
                        context, 10, Strings.offers),
                  ),
                ],
              ),
            ),
            horizontalDividerWidget(context),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  HomeSectionItem(
                    isSmallIcon: true,
                    itemImageURL: Images.report_item,
                    itemText: Strings.reportingItems,
                    onItemClicked: () => toReportItemPageEvent(context),
                  ),
                  verticalDividerWidget(context),
                  HomeSectionItem(
                    isSmallIcon: true,
                    itemImageURL: Images.barcode,
                    itemText: Strings.barcodeReader,
                    onItemClicked: () => toScreenScannerPageEvent(context),
                  ),
                  verticalDividerWidget(context),
                  HomeSectionItem(
                    isSmallIcon: true,
                    itemImageURL: Images.complain,
                    itemText: Strings.complaintsAndSuggestions,
                    onItemClicked: () => toComplaintPageEvent(context),
                  ),
                ],
              ),
            ),
            horizontalDividerWidget(context),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // HomeSectionItem(
                  //   isSmallIcon: true,
                  //   itemImageURL: Images.financialReports,
                  //   itemText: Strings.financialReports,
                  //   onItemClicked: () {},
                  // ),
                  verticalDividerWidget(
                    context,
                    padding: EdgeInsets.only(bottom: 20.0),
                  ),
                  HomeSectionItem(
                    isSmallIcon: true,
                    itemImageURL: Images.member,
                    itemText: Strings.boardOfDirectors,
                    onItemClicked: () => toMembersPageEvent(context),
                  ),
                  verticalDividerWidget(
                    context,
                    padding: EdgeInsets.only(bottom: 20.0),
                  ),
                  // HomeSectionItem(
                  //   isSmallIcon: true,
                  //   itemImageURL: Images.community,
                  //   itemText: Strings.shareholders,
                  //   onItemClicked: () =>
                  //       toShareholderSignInScreenEvent(context),
                  // ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget verticalDividerWidget(BuildContext context,
          {EdgeInsetsGeometry? padding}) =>
      Container(
        padding: padding,
        height: MediaQuery.of(context).size.width * 0.3,
        width: 2.0,
        child: VerticalDivider(color: AppTheme.gg),
      );

  Widget horizontalDividerWidget(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        height: 2.0,
        width: MediaQuery.of(context).size.width,
        child: Divider(color: AppTheme.gg),
      );

  void toComplaintPageEvent(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return BlocProvider<SendComplaintBloc>(
          create: (context) => SendComplaintBloc(SendComplaintRepositoryImpl()),
          child: ComplaintPage(),
        );
      }),
    );
  }

  void toReportItemPageEvent(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return BlocProvider<ReportItemBloc>(
          create: (context) => ReportItemBloc(ReportItemRepositoryImpl()),
          child: ReportItemPage(Strings.reportingItems),
        );
      }),
    );
  }

  void toScreenScannerPageEvent(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return ScreenScannerPage();
      }),
    );
  }

  void toMembersPageEvent(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return BlocProvider<MembersBloc>(
          create: (context) =>
              MembersBloc(MembersRepositoryImpl())..add(FetchMembersData()),
          child: MembersPage(),
        );
      }),
    );
  }

  // void toShareholderSignInScreenEvent(BuildContext context) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(builder: (context) {
  //       return ShareholderSignInScreen();
  //     }),
  //   );
  // }

  /// navigate To SocialNewsPage Event
  void navigateToSocialNewsPageEvent(
      BuildContext context, int sectionId, String sectionName) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return BlocProvider<SocialNewsBloc>(
          create: (context) => SocialNewsBloc(SocialNewsRepositoryImpl()),
          child: SocialNewsPage(sectionId, sectionName),
        );
      }),
    );
  }
}
