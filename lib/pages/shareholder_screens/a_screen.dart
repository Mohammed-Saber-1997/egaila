import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../AppTheme.dart';
import '../../SizeConfig.dart';
import '../../bloc/shareholder_signin/shareholder_sign_in_bloc.dart';
import '../../constants.dart';
import '../../models/signin_shareholder.dart';
import '../../widgets/app_button_widget.dart';

class AScreen extends StatelessWidget {
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
              'تسجيل طلب',
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
                    SizedBox(height: 10.0),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          cardWidget(context, index),
                      itemCount: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: AppButtonWidget(
                        buttonText: 'تسجيل طلب',
                        onButtonClicked: () => print('تسجيل طلب'),
                      ),
                    ),
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

Widget cardWidget(BuildContext context, int index) => Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          border: Border.all(color: AppTheme.buttonsColor),
        ),
        child: ExpansionTile(
          title: Text(
            'اكوابارك',
            style: AppTheme.subTitleTheme.copyWith(
              fontSize: 2 * SizeConfig.textMultiplier,
            ),
          ),
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: AppTheme.buttonsColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'الكمية المتاحة',
                        style: AppTheme.subTitleTheme.copyWith(
                          color: Colors.white,
                          fontSize: 2 * SizeConfig.textMultiplier,
                        ),
                      ),
                      Text(
                        'الكمية' + '        ',
                        style: AppTheme.subTitleTheme.copyWith(
                          color: Colors.white,
                          fontSize: 2 * SizeConfig.textMultiplier,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'سعر الكارت',
                        style: AppTheme.subTitleTheme.copyWith(
                          color: Colors.white,
                          fontSize: 2 * SizeConfig.textMultiplier,
                        ),
                      ),
                      Container(
                        width: 120.0,
                        height: 50.0,
                        child: TextField(
                          decoration: kInputDecoration.copyWith(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'اجمالي السعر',
                        style: AppTheme.subTitleTheme.copyWith(
                          color: Colors.white,
                          fontSize: 2 * SizeConfig.textMultiplier,
                        ),
                      ),
                      Text(
                        'السعر' + '         ',
                        style: AppTheme.subTitleTheme.copyWith(
                          color: Colors.white,
                          fontSize: 2 * SizeConfig.textMultiplier,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
