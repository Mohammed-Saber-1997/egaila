import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../AppTheme.dart';
import '../../SizeConfig.dart';
import '../../bloc/shareholder_signin/shareholder_sign_in_bloc.dart';
import '../../constants.dart';
import '../../models/signin_shareholder.dart';
import '../../utils/strings.dart';
import '../../widgets/app_button_widget.dart';

class ShareholderLoyaltyCardsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShareholderSignInBloc, ShareholderSignInState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            iconTheme: IconThemeData(
              color: AppTheme.appBackgroundColor,
            ),
            backgroundColor: AppTheme.buttonsColor,
            title: Text(
              Strings.shareholderLoyaltyCards,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: <Widget>[
                    shareholderInfoWidget(context, state.model!),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget shareholderInfoWidget(
        BuildContext context, SignInShareholderModel model) =>
    Container(
      padding: EdgeInsets.all(10.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'الاسم : ${model.shhName}',
            style: AppTheme.subTitleTheme.copyWith(
              fontSize: 2 * SizeConfig.textMultiplier,
            ),
          ),
          Text(
            'الرقم المدني : ${model.shhCivilId}',
            style: AppTheme.subTitleTheme.copyWith(
              fontSize: 2 * SizeConfig.textMultiplier,
            ),
          ),
          Text(
            'رقم الصندوق : ${model.shhCivilId}',
            style: AppTheme.subTitleTheme.copyWith(
              fontSize: 2 * SizeConfig.textMultiplier,
            ),
          ),
          Text(
            // 'رقم الموبايل : ${model.shhMobile}',
            'رقم الموبايل : 98765432',
            style: AppTheme.subTitleTheme.copyWith(
              fontSize: 2 * SizeConfig.textMultiplier,
            ),
          ),
          Text(
            'تاريخ التسجيل : ${DateTime.now().year} / ${DateTime.now().month} / ${DateTime.now().day} ',
            style: AppTheme.subTitleTheme.copyWith(
              fontSize: 2 * SizeConfig.textMultiplier,
            ),
          ),
        ],
      ),
    );
