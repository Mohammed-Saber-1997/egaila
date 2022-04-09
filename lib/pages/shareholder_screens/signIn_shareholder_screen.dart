import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eqaila_app/bloc/shareholder_signin/shareholder_sign_in_bloc.dart';
import 'package:eqaila_app/utils/strings.dart';
import 'package:eqaila_app/widgets/app_button_widget.dart';
import 'package:eqaila_app/widgets/text_field_widget.dart';

import '../../AppTheme.dart';
import '../../SizeConfig.dart';
import 'shareholder_services_screen.dart';

class ShareholderSignInScreen extends StatelessWidget {
  final TextEditingController civilNo = TextEditingController();

  final TextEditingController boxNo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //TODO: Delete Shareholder Fake Data
    civilNo.text = '265060500844';
    boxNo.text = '1';

    return BlocListener<ShareholderSignInBloc, ShareholderSignInState>(
      bloc: BlocProvider.of<ShareholderSignInBloc>(context),
      listener: (BuildContext context, state) {
        if (state is ShareholderSignInLoaded) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return ShareholderServicesScreen();
          }));
        } else if (state is ShareholderSignInError) {
          //TODO: Toast
          //ToastUtil.showErrorToast(Strings.shareholderSignInError);
        }
      },
      child: BlocBuilder<ShareholderSignInBloc, ShareholderSignInState>(
        builder: (context, state) {
          if (state is ShareholderSignInInitial) {
            return appBareWidget(bodyWidget(context));
          } else if (state is ShareholderSignInLoading) {
            return appBareWidget(Center(child: AppTheme.showLoadingSpinKit()));
          } else if (state is ShareholderSignInError) {
            return appBareWidget(bodyWidget(context));
          } else {
            return appBareWidget(bodyWidget(context));
          }
        },
      ),
    );
  }

  Widget textFieldWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            Strings.civilNo,
            style: AppTheme.textStyleDark16w700,
          ),
          TextFieldWidget(
            controller: civilNo,
            hintText: Strings.civilNo,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 4.0 * SizeConfig.heightMultiplier),
          Text(
            Strings.boxNo,
            style: AppTheme.textStyleDark16w700,
          ),
          TextFieldWidget(
            controller: boxNo,
            hintText: Strings.boxNo,
            keyboardType: TextInputType.phone,
          ),
        ],
      );

  Widget shareholderLoginButtonWidget(BuildContext context) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: AppButtonWidget(
          buttonText: Strings.shareholderSignInButton,
          onButtonClicked: () {
            BlocProvider.of<ShareholderSignInBloc>(context).add(
              LogInButtonEvent(civilNo.value.text, boxNo.value.text),
            );
          },
        ),
      );

  Widget appBareWidget(Widget widget) => Scaffold(
        appBar: AppBar(
          title: Text(Strings.shareholderServices, style: AppTheme.appBarStyle),
          centerTitle: true,
        ),
        body: widget,
      );

  Widget bodyWidget(BuildContext context) => Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            margin: EdgeInsets.only(top: 150),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                textFieldWidget(),
                SizedBox(height: 10 * SizeConfig.heightMultiplier),
                Align(
                  alignment: Alignment.center,
                  child: shareholderLoginButtonWidget(context),
                ),
              ],
            ),
          ),
        ),
      );
}
