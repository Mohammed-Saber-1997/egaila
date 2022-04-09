import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:eqaila_app/bloc/item_report/report_item_bloc.dart';
import 'package:eqaila_app/utils/strings.dart';
import 'package:eqaila_app/widgets/text_field_widget.dart';
import 'package:eqaila_app/widgets/tooltip_shapeborder.dart';

import '../AppTheme.dart';
import '../SizeConfig.dart';

class ReportItemPage extends StatelessWidget {
  final String reportTitle;

  ReportItemPage(this.reportTitle);

  late ReportItemBloc reportItemBloc;

  @override
  Widget build(BuildContext context) {
    reportItemBloc = BlocProvider.of<ReportItemBloc>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: WillPopScope(
        onWillPop: () {
          reportItemBloc.close();
          Navigator.pop(context);
          return Future<bool>.value(true);
        }, //as Future<bool> Function()?,
        child: Scaffold(
          appBar: AppBar(
            title: Text(reportTitle),
            centerTitle: true,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 5 * SizeConfig.imageSizeMultiplier),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 10),
                      pageDescriptionText(context),
                      SizedBox(height: 10),
                      Divider(height: 1.0),
                      SizedBox(height: 20),
                      BlocBuilder<ReportItemBloc, ReportItemState>(
                        builder: (context, state) {
                          if (state is ReportItemInitial) {
                            return imageWidget(context);
                          } else if (state is ImagePicked) {
                            return imageWidget(context);
                          } else {
                            return Container();
                          }
                        },
                      ),
//                    SizedBox(height: 20),
//                    BlocBuilder<ReportItemBloc, ReportItemState>(
//                      builder: (context, state) {
//                        return textFieldWidget();
//                      },
//                    ),
                      SizedBox(height: 10),
                      sendButtonWidget(context),
                      SizedBox(height: 20),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget pageDescriptionText(BuildContext context) {
    return Text(
      "فى حاله وجدت سلعه عليها ملاحظات او سعرها ارخص فى جمعيه اخرى ،يرجى إبلاغنا عبر هذا النموذج",
      style: TextStyle(
        fontSize: 2 * SizeConfig.textMultiplier,
        color: AppTheme.black,
        fontWeight: FontWeight.bold,
        fontFamily: "Cairo",
      ),
    );
  }

  Widget imageWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: 5 * SizeConfig.widthMultiplier,
              vertical: 2 * SizeConfig.widthMultiplier),
          decoration: ShapeDecoration(
            color: AppTheme.buttonsColor,
            shape: TooltipShapeBorder(
              arrowHeight: 10,
              arrowWidth: 30,
              arrowArc: 0.1,
              radius: 10,
            ),
            shadows: [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 5.0,
                offset: Offset(5, 5),
              )
            ],
          ),
          child: Text(
            "ارفق صورة",
            style: TextStyle(
              fontSize: 2 * SizeConfig.textMultiplier,
              color: AppTheme.appBackgroundColor,
              fontFamily: "Cairo",
            ),
          ),
        ),
        Container(
          child: reportItemBloc.imageFile == null
              ? IconButton(
                  alignment: Alignment.center,
                  iconSize: 7 * SizeConfig.textMultiplier,
                  icon: Icon(
                    Icons.camera_alt,
                    color: AppTheme.buttonsColor,
                    size: 7 * SizeConfig.textMultiplier,
                  ),
                  onPressed: () {
                    showBottomSheetWidget(context);
                  },
                )
              : Container(
                  child: Center(
                    child: Image.file(reportItemBloc.imageFile!),
                  ),
                ),
        ),
        SizedBox(height: 20),
        textFieldWidget(),
      ],
    );
  }

  Future<dynamic> showBottomSheetWidget(BuildContext context) {
    return showModalBottomSheet<dynamic>(
        isScrollControlled: false,
        context: context,
        builder: (BuildContext context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
                child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Wrap(
                      children: <Widget>[
                        Text(
                          "ارفق صورة",
                          style: TextStyle(
                            fontSize: 2.5 * SizeConfig.textMultiplier,
                            color: AppTheme.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Cairo",
                          ),
                        ),

                        Divider(),
                        ListTile(
                            title: Text(
                              'التقط من الكاميرا',
                              style: TextStyle(
                                fontSize: 2 * SizeConfig.textMultiplier,
                                color: AppTheme.buttonsColor,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Cairo",
                              ),
                            ),
                            onTap: () {
                              reportItemBloc.add(PickImageFromCamera());
                              Navigator.pop(context);
                            }),
                        ListTile(
                            title: Text(
                              'ألبوم الصور',
                              style: TextStyle(
                                fontSize: 2 * SizeConfig.textMultiplier,
                                color: AppTheme.buttonsColor,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Cairo",
                              ),
                            ),
                            onTap: () {
                              reportItemBloc.add(PickImageFromGallery());
                              Navigator.pop(context);
                            }),
                        ListTile(
                            title: Text(
                              'اغلق',
                              style: TextStyle(
                                fontSize: 2 * SizeConfig.textMultiplier,
                                color: AppTheme.buttonsColor,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Cairo",
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            }),
                        //build other menu here
                      ],
                    ))),
          );
        });
  }

  Widget showLoadingSpinKit() {
    return SpinKitFoldingCube(
      color: AppTheme.buttonsGradientColor1,
      size: 10 * SizeConfig.imageSizeMultiplier,
    );
  }

  Widget textFieldWidget() {
    return Column(
      children: <Widget>[
        TextFieldWidget(
          controller: reportItemBloc.userNameController,
          hintText: Strings.name,
          icon: Icons.person,
          keyboardType: TextInputType.emailAddress,
          errorText: reportItemBloc.nameError,
        ),
        SizedBox(height: 10),
        TextFieldWidget(
          controller: reportItemBloc.mobileController,
          hintText: Strings.mobile,
          icon: Icons.phone,
          keyboardType: TextInputType.phone,
          errorText: reportItemBloc.mobileError,
        ),
        SizedBox(height: 10),
        TextFieldWidget(
          controller: reportItemBloc.messageController,
          hintText: Strings.enterNotes,
          maxLines: 5,
          errorText: reportItemBloc.messageError,
        ),
      ],
    );
  }

  Widget sendButtonWidget(BuildContext context) {
    return InkWell(
      onTap: () {
        reportItemBloc.add(SendButtonEvent(context));
      },
      child: Center(
        child: Container(
          width: 80 * SizeConfig.widthMultiplier,
          height: 6 * SizeConfig.heightMultiplier,
          decoration: BoxDecoration(
            color: AppTheme.buttonsColor,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 5.0,
                offset: Offset(5, 5),
              )
            ],
          ),
          child: Center(
            child: Text(
              Strings.send,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 1.5 * SizeConfig.textMultiplier,
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:eqaila_app/bloc/item_report/report_item_bloc.dart';
// import 'package:eqaila_app/utils/strings.dart';
// import 'package:eqaila_app/widgets/app_button_widget.dart';
// import 'package:eqaila_app/widgets/text_field_widget.dart';
// import 'package:eqaila_app/widgets/tooltip_shapeborder.dart';
//
// import '../AppTheme.dart';
// import '../SizeConfig.dart';
//
// class ReportItemPage extends StatelessWidget {
//   final String reportTitle;
//
//   ReportItemPage(this.reportTitle);
//
//   late ReportItemBloc reportItemBloc;
//
//   @override
//   Widget build(BuildContext context) {
//     reportItemBloc = BlocProvider.of<ReportItemBloc>(context);
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: WillPopScope(
//         onWillPop: () {
//           reportItemBloc.close();
//           Navigator.pop(context);
//         } as Future<bool> Function()?,
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text(reportTitle, style: AppTheme.appBarStyle),
//             centerTitle: true,
//           ),
//           body: SingleChildScrollView(
//             child: Container(
//               padding: EdgeInsets.symmetric(
//                   horizontal: 5 * SizeConfig.imageSizeMultiplier),
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     SizedBox(height: 10),
//                     pageDescriptionText(context),
//                     SizedBox(height: 10),
//                     Divider(height: 1.0),
//                     SizedBox(height: 20),
//                     BlocBuilder<ReportItemBloc, ReportItemState>(
//                       builder: (context, state) {
//                         if (state is ReportItemInitial) {
//                           return imageWidget(context);
//                         } else if (state is ImagePicked) {
//                           return imageWidget(context);
//                         } else {
//                           return Container();
//                         }
//                       },
//                     ),
//                     SizedBox(height: 10),
//                     sendButtonWidget(context),
//                     SizedBox(height: 20),
//                   ]),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   /// page Description Text
//   Widget pageDescriptionText(BuildContext context) {
//     return Text(
//       Strings.pageDescriptionText,
//       style: AppTheme.textBlackBoldStyle,
//     );
//   }
//
//   /// image Widget
//   Widget imageWidget(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         Container(
//           padding: EdgeInsets.symmetric(
//               horizontal: 5 * SizeConfig.widthMultiplier,
//               vertical: 2 * SizeConfig.widthMultiplier),
//           decoration: ShapeDecoration(
//             color: AppTheme.buttonsColor,
//             shape: TooltipShapeBorder(
//               arrowHeight: 10,
//               arrowWidth: 30,
//               arrowArc: 0.1,
//               radius: 10,
//             ),
//             shadows: AppTheme.shadows,
//           ),
//           child: Text(
//             Strings.attachPicture,
//             style: AppTheme.textWhiteStyle,
//           ),
//         ),
//         Container(
//           child: reportItemBloc.imageFile == null
//               ? IconButton(
//                   alignment: Alignment.center,
//                   iconSize: 7 * SizeConfig.textMultiplier,
//                   icon: Icon(
//                     Icons.camera_alt,
//                     color: AppTheme.buttonsColor,
//                     size: 7 * SizeConfig.textMultiplier,
//                   ),
//                   onPressed: () {
//                     showBottomSheetWidget(context);
//                   },
//                 )
//               : Container(
//                   child: Center(
//                     child: Image.file(reportItemBloc.imageFile!),
//                   ),
//                 ),
//         ),
//         SizedBox(height: 20),
//         textFieldWidget(),
//       ],
//     );
//   }
//
//   /// Bottom Sheet Widget
//   Future<dynamic> showBottomSheetWidget(BuildContext context) {
//     return showModalBottomSheet<dynamic>(
//         isScrollControlled: false,
//         context: context,
//         builder: (BuildContext context) {
//           return Directionality(
//             textDirection: TextDirection.rtl,
//             child: Container(
//                 child: Padding(
//                     padding: const EdgeInsets.all(30.0),
//                     child: Wrap(
//                       children: <Widget>[
//                         Text(
//                           Strings.attachPicture,
//                           style: AppTheme.textBoldBlackStyle,
//                         ),
//
//                         Divider(),
//                         ListTile(
//                             title: Text(
//                               Strings.captureFromCamera,
//                               style: AppTheme.textDarkStyleW700,
//                             ),
//                             onTap: () {
//                               reportItemBloc.add(PickImageFromCamera());
//                               Navigator.pop(context);
//                             }),
//                         ListTile(
//                             title: Text(
//                               Strings.photoAlbum,
//                               style: AppTheme.textDarkStyleW700,
//                             ),
//                             onTap: () {
//                               reportItemBloc.add(PickImageFromGallery());
//                               Navigator.pop(context);
//                             }),
//                         ListTile(
//                             title: Text(
//                               Strings.close,
//                               style: AppTheme.textDarkStyleW700,
//                             ),
//                             onTap: () {
//                               Navigator.pop(context);
//                             }),
//                         //build other menu here
//                       ],
//                     ))),
//           );
//         });
//   }
//
//   /// textField Widget
//   Widget textFieldWidget() {
//     return Column(
//       children: <Widget>[
//         TextFieldWidget(
//           controller: reportItemBloc.userNameController,
//           hintText: Strings.name,
//           icon: Icons.person,
//           keyboardType: TextInputType.emailAddress,
//           errorText: reportItemBloc.nameError,
//         ),
//         SizedBox(height: 10),
//         TextFieldWidget(
//           controller: reportItemBloc.mobileController,
//           hintText: Strings.mobile,
//           icon: Icons.phone,
//           keyboardType: TextInputType.phone,
//           errorText: reportItemBloc.mobileError,
//         ),
//         SizedBox(height: 10),
//         TextFieldWidget(
//           controller: reportItemBloc.messageController,
//           hintText: Strings.enterNotes,
//           maxLines: 5,
//           errorText: reportItemBloc.messageError,
//         ),
//       ],
//     );
//   }
//
//   /// send Button Widget
//   Widget sendButtonWidget(BuildContext context) {
//     return AppButtonWidget(
//       buttonText: Strings.send,
//       onButtonClicked: () {
//         reportItemBloc.add(SendButtonEvent(context));
//       },
//     );
//   }
// }
