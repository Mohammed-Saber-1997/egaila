import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eqaila_app/bloc/shareholder_signin/shareholder_sign_in_bloc.dart';
import 'package:eqaila_app/utils/strings.dart';

import '../../AppTheme.dart';

class FamilyCardScreen extends StatelessWidget {
  late ShareholderSignInBloc user;

  @override
  Widget build(BuildContext context) {
    user = BlocProvider.of<ShareholderSignInBloc>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          Strings.familyCard,
          style: AppTheme.appBarStyle,
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          child: Column(
            children: <Widget>[
              headerWidget(context),
              SizedBox(height: 20),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: BarcodeWidget(
                        barcode: Barcode.qrCode(),
                        data: '${user.state.model!.shhId}',
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Header Widget
  Widget headerWidget(BuildContext context) {
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
            SizedBox(height: 10),
            Text('الأسم: ${user.state.model!.shhName}',
                style: AppTheme.textStyleWhite16w600),
            SizedBox(height: 10),
            Text(
              'رقم الصندوق: ${user.state.model!.shhCivilId}',
              style: AppTheme.textStyleWhite16w600,
            ),
            SizedBox(height: 20),
            //searchField(context),
          ],
        ),
      ),
    );
  }
}
