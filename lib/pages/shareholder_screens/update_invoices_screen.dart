import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eqaila_app/utils/images.dart';
import 'package:eqaila_app/utils/strings.dart';
import 'package:eqaila_app/widgets/app_button_widget.dart';

import '../../AppTheme.dart';
import '../../constants.dart';

class UpdateInvoicesScreen extends StatefulWidget {
  static const routeName = 'Update_Invoices_Screen';

  @override
  _UpdateInvoicesScreenState createState() => _UpdateInvoicesScreenState();
}

class _UpdateInvoicesScreenState extends State<UpdateInvoicesScreen> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          Strings.updatingData,
          style: AppTheme.appBarStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            child: Column(
              children: <Widget>[
                updateIbanNumber(context),
                updatePhoneNumber(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget updateIbanNumber(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(16.0, 20, 16.0, 16.0),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.only(top: 16.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 96.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                Strings.attachPicture,
                                style: AppTheme.textStyleDark16w700,
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.all(0),
                                title: Text(
                                  Strings.EnterIBANNumber,
                                  style: AppTheme.textStyleDark16w700,
                                ),
                                subtitle: TextField(
                                  decoration: kInputDecoration,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              SizedBox(height: 16.0),
                              AppButtonWidget(
                                buttonText: Strings.update,
                                onButtonClicked: () => updateIbanNumberEvent(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                  Container(
                    height: 80,
                    width: 80,
                    padding: _image == null
                        ? EdgeInsets.all(16.0)
                        : EdgeInsets.all(0.0),
                    decoration: BoxDecoration(
                      color: AppTheme.textOrangeColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: GestureDetector(
                      child: _image == null
                          ? SvgPicture.asset(Images.ic_photograph)
                          : Image(
                              image: FileImage(_image!),
                              fit: BoxFit.cover,
                            ),
                      onTap: pickImage,
                    ),
                    margin: EdgeInsets.only(right: 16.0),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ],
    );
  }

  Widget updatePhoneNumber(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            Strings.insertTheMobile,
            style: AppTheme.textStyleDark16w700,
          ),
          TextField(
            decoration: kInputDecoration,
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 16.0),
          AppButtonWidget(
            buttonText: Strings.update,
            onButtonClicked: () => updateMobileNumberEvent(),
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }

  void pickImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.camera);

    setState(() {
      _image = File(image!.path);
    });
  }

  void updateIbanNumberEvent() {
    // TODO: Implement [Update IBAN Number] functionality.
  }

  void updateMobileNumberEvent() {
    // TODO: Implement [Update Mobile Number] functionality.
  }
}

///// Header Widget..
//Widget headerWidget(BuildContext context) {
//  return SafeArea(
//    child: Stack(
//      children: <Widget>[
//        Container(
//          height: 150.0,
//          width: double.infinity,
//          decoration: ShapeDecoration(
//            color: AppTheme.colorPrimary,
//            shadows: [
//              BoxShadow(
//                color: Colors.black38,
//                blurRadius: 5.0,
//                offset: Offset(5, 5),
//              )
//            ],
//            shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.only(
//                bottomLeft: Radius.circular(40),
//                bottomRight: Radius.circular(40),
//              ),
//            ),
//          ),
//        ),
//        Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            SizedBox(
//              height: MediaQuery.of(context).size.width * 0.1,
//            ),
//            Padding(
//              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
//              child: Expanded(
//                flex: 2,
//                child: Container(),
//              ),
//            ),
//            SizedBox(height: 30),
//            Padding(
//              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
//              child: Container(
//                width: MediaQuery.of(context).size.width * 0.4,
//                height: MediaQuery.of(context).size.width * 0.4,
//                child: Material(
//                  elevation: 10,
//                  color: AppTheme.buttonsGradientColor2,
//                  borderRadius: BorderRadius.circular(10.0),
//                  child: Stack(
//                    children: <Widget>[
//                      Padding(
//                        padding: const EdgeInsets.only(left: 16, right: 16),
//                        child: Column(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            SizedBox(height: 16),
//                            Text(
//                              'image',
//                              style: TextStyle(
//                                  fontSize: 18,
//                                  fontWeight: FontWeight.w900,
//                                  color: Colors.white),
//                            ),
//                            SizedBox(height: 16),
//                          ],
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//            )
//          ],
//        ),
//      ],
//    ),
//  );
//}
