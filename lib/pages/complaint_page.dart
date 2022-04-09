import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eqaila_app/bloc/send_complaint/send_complaint_bloc.dart';
import 'package:eqaila_app/utils/strings.dart';
import 'package:eqaila_app/widgets/text_field_widget.dart';

import '../AppTheme.dart';
import '../SizeConfig.dart';

class ComplaintPage extends StatelessWidget {
  late SendComplaintBloc sendComplaintBloc;

  @override
  Widget build(BuildContext context) {
    sendComplaintBloc = BlocProvider.of<SendComplaintBloc>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: WillPopScope(
        onWillPop: () {
          sendComplaintBloc.close();
          Navigator.pop(context);
          return Future<bool>.value(true);
        }, //as Future<bool> Function()?,
        child: Scaffold(
          appBar: AppBar(
            title: Text(Strings.complaintsAndSuggestions),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 5 * SizeConfig.imageSizeMultiplier),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20 * SizeConfig.imageSizeMultiplier),
                    BlocBuilder<SendComplaintBloc, SendComplaintState>(
                      builder: (context, state) {
                        if (state is SendComplaintInitial) {
                          return textFieldWidget();
                        } else if (state is UserInput) {
                          return textFieldWidget();
                        } else {
                          return Container();
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    sendButtonWidget(context),
                    SizedBox(height: 20),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget textFieldWidget() {
    return Column(
      children: <Widget>[
        TextFieldWidget(
          controller: sendComplaintBloc.userNameController,
          hintText: Strings.name,
          icon: Icons.person,
          keyboardType: TextInputType.emailAddress,
          errorText: sendComplaintBloc.nameError,
        ),
        SizedBox(height: 10),
        TextFieldWidget(
          controller: sendComplaintBloc.mobileController,
          hintText: Strings.mobile,
          icon: Icons.phone,
          keyboardType: TextInputType.phone,
          errorText: sendComplaintBloc.mobileError,
        ),
        SizedBox(height: 10),
        TextFieldWidget(
          controller: sendComplaintBloc.messageController,
          hintText: Strings.suggestionsOrComplaints,
          maxLines: 5,
          errorText: sendComplaintBloc.messageError,
        ),
      ],
    );
  }

  /// send Button Widget
  Widget sendButtonWidget(BuildContext context) {
    return InkWell(
      onTap: () {
        sendComplaintBloc.add(SendButtonEvent(context));
      },
      child: Center(
        child: Container(
          width: 80 * SizeConfig.widthMultiplier,
          height: 6 * SizeConfig.heightMultiplier,
          decoration: BoxDecoration(
            color: AppTheme.buttonsColor,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: AppTheme.shadows,
          ),
          child: Center(
            child: Text(
              Strings.send,
              style: AppTheme.buttonTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}

// class ComplaintPage extends StatelessWidget {
//   late SendComplaintBloc sendComplaintBloc;
//
//   @override
//   Widget build(BuildContext context) {
//     sendComplaintBloc = BlocProvider.of<SendComplaintBloc>(context);
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: WillPopScope(
//         onWillPop: () {
//           sendComplaintBloc.close();
//           Navigator.pop(context);
//         } as Future<bool> Function()?,
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text(Strings.complaintsSuggestions,
//                 style: AppTheme.appBarStyle),
//             centerTitle: true,
//           ),
//           body: SingleChildScrollView(
//             child: Container(
//               padding: EdgeInsets.symmetric(
//                   horizontal: 5 * SizeConfig.imageSizeMultiplier),
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     SizedBox(height: 20 * SizeConfig.imageSizeMultiplier),
//                     BlocBuilder<SendComplaintBloc, SendComplaintState>(
//                       builder: (context, state) {
//                         if (state is SendComplaintInitial) {
//                           return textFieldWidget();
//                         } else if (state is UserInput) {
//                           return textFieldWidget();
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
//   /// text Field Widget
//   Widget textFieldWidget() {
//     return Column(
//       children: <Widget>[
//         TextFieldWidget(
//           controller: sendComplaintBloc.userNameController,
//           hintText: Strings.name,
//           icon: Icons.person,
//           keyboardType: TextInputType.emailAddress,
//           errorText: sendComplaintBloc.nameError,
//         ),
//         SizedBox(height: 10),
//         TextFieldWidget(
//           controller: sendComplaintBloc.mobileController,
//           hintText: Strings.mobile,
//           icon: Icons.phone,
//           keyboardType: TextInputType.phone,
//           errorText: sendComplaintBloc.mobileError,
//         ),
//         SizedBox(height: 10),
//         TextFieldWidget(
//           controller: sendComplaintBloc.messageController,
//           hintText: Strings.suggestionsOrComplaints,
//           maxLines: 5,
//           errorText: sendComplaintBloc.messageError,
//         ),
//       ],
//     );
//   }
//
//   /// send Button Widget
//   Widget sendButtonWidget(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         sendComplaintBloc.add(SendButtonEvent(context));
//       },
//       child: Center(
//         child: Container(
//           width: 80 * SizeConfig.widthMultiplier,
//           height: 6 * SizeConfig.heightMultiplier,
//           decoration: BoxDecoration(
//             color: AppTheme.buttonsColor,
//             borderRadius: BorderRadius.circular(20.0),
//             boxShadow: AppTheme.shadows,
//           ),
//           child: Center(
//             child: Text(
//               Strings.send,
//               style: AppTheme.buttonTextStyle,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
