import 'package:eqaila_app/pages/shareholder_screens/shareholder_activities_screen.dart';
import 'package:eqaila_app/pages/shareholder_screens/shareholder_loyalty_cards_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eqaila_app/bloc/shareholderPurchases/shareholder_purchases_bloc.dart';
import 'package:eqaila_app/bloc/shareholder_signin/shareholder_sign_in_bloc.dart';
import 'package:eqaila_app/models/models.dart';
import 'package:eqaila_app/repository/shareholder/shareholder_purchases_repository.dart';
import 'package:eqaila_app/utils/images.dart';
import 'package:eqaila_app/utils/strings.dart';
import 'package:eqaila_app/widgets/home_section_item.dart';

import '../../AppTheme.dart';
import 'a_screen.dart';
import 'aa_screen.dart';
import 'family_card_screen.dart';
import 'shareholder_earnings_screen.dart';
import 'shareholder_purchases_screen.dart';
import 'update_invoices_screen.dart';

class ShareholderServicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //ToastUtil.showSuccessToast(Strings.loginSuccess);

    return BlocBuilder<ShareholderSignInBloc, ShareholderSignInState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            title: Text(
              Strings.services,
              style: AppTheme.appBarStyle,
            ),
          ),
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              child: Column(
                children: <Widget>[
                  headerWidget(context, state.model!),
                  Expanded(
                    child: shareholderServicesItems(context, state.model),
                    //child: ShareholderEarningsScreen(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Header Widget
  Widget headerWidget(BuildContext context, SignInShareholderModel model) {
    var credit = 500;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      width: double.infinity,
      decoration: ShapeDecoration(
        color: AppTheme.buttonsColor,
        shadows: AppTheme.shadows,
        shape: RoundedRectangleBorder(),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //SizedBox(height: 10),
            Text(
              'الأسم: ${model.shhName}',
              style: AppTheme.textStyleWhite16w600,
            ),
            //SizedBox(height: 10),
            Text(
              'رقم الصندوق: ${model.shhCivilId}',
              style: AppTheme.textStyleWhite16w600,
            ),
            //SizedBox(height: 10),
            Text(
              'رصيد المشتريات: $credit ك د ',
              style: AppTheme.textStyleWhite16w600,
            ),
            //SizedBox(height: 8),
            //searchField(context),
          ],
        ),
      ),
    );
  }

  /// Body shareholder Services
  Widget shareholderServicesItems(
          BuildContext context, SignInShareholderModel? model) =>
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20.0),
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  HomeSectionItem(
                    isHomePage: false,
                    itemImageURL: Images.ic_shopping,
                    itemText: Strings.shareholderPurchases,
                    onItemClicked: () =>
                        toShareholderPurchasesScreen(context, model),
                  ),
                  verticalDividerWidget(context,
                      padding: EdgeInsets.only(top: 20.0)),
                  HomeSectionItem(
                    isHomePage: false,
                    itemImageURL: Images.ic_money,
                    itemText: Strings.shareholderEarnings,
                    onItemClicked: () => toShareholderEarningsScreen(context),
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
                    isHomePage: false,
                    itemImageURL: Images.ic_money,
                    itemText: Strings.shareholderLoyaltyCards,
                    onItemClicked: () =>
                        toShareholderLoyaltyCardsScreen(context),
                    // {
                    //   // TODO: Implement [Shareholder LoyaltyCards] functionality.
                    // },
                  ),
                  verticalDividerWidget(context),
                  HomeSectionItem(
                    isHomePage: false,
                    itemImageURL: Images.ic_information,
                    itemText: Strings.shareholderActivities,
                    onItemClicked: () => toShareholderActivitiesScreen(context),
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
                    isHomePage: false,
                    itemImageURL: Images.ic_information,
                    itemText: Strings.familyCard,
                    onItemClicked: () => toFamilyCardScreen(context),
                  ),
                  verticalDividerWidget(context,
                      padding: EdgeInsets.only(bottom: 20.0)),
                  HomeSectionItem(
                    isHomePage: false,
                    itemImageURL: Images.ic_update,
                    itemText: Strings.updateShareholderData,
                    onItemClicked: () => toUpdateInvoicesScreen(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget horizontalDividerWidget(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        height: 2.0,
        width: MediaQuery.of(context).size.width,
        child: Divider(color: AppTheme.gg),
      );

  Widget verticalDividerWidget(BuildContext context,
          {EdgeInsetsGeometry? padding}) =>
      Container(
        padding: padding,
        height: MediaQuery.of(context).size.width * 0.4,
        width: 2.0,
        child: VerticalDivider(color: AppTheme.gg),
      );

  ///Navigate To Shareholder Purchases Screen
  void toShareholderPurchasesScreen(
      BuildContext context, SignInShareholderModel? model) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return BlocProvider<ShareholderPurchasesBloc>(
          create: (context) => ShareholderPurchasesBloc(
              ShareholderPurchasesRepositoryImpl())
            ..add(
                GetAllShareholderPurchases(model!.shhMembershipId.toString())),
          child: ShareholderPurchasesScreen(),
        );
      }),
    );
  }

  ///Navigate To ShareholderEarningsScreen
  void toShareholderEarningsScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return ShareholderEarningsScreen();
      }),
    );
  }

  ///Navigate To ShareholderLoyaltyCards
  void toShareholderLoyaltyCardsScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        // return ShareholderLoyaltyCardsScreen();
        return AAScreen();
      }),
    );
  }

  ///Navigate To ShareholderEarningsScreen
  void toShareholderActivitiesScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return ShareholderActivitiesScreen();
      }),
    );
  }

  ///Navigate To FamilyCardScreen
  void toFamilyCardScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return FamilyCardScreen();
      }),
    );
  }

  ///Navigate To UpdateInvoicesScreen
  void toUpdateInvoicesScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return UpdateInvoicesScreen();
      }),
    );
  }
}
