import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eqaila_app/bloc/members/members_bloc.dart';
import 'package:eqaila_app/models/models.dart';

import '../AppTheme.dart';
import '../SizeConfig.dart';
import '../constants.dart';

class MemberDetailsPage extends StatelessWidget {
  final String? memberName;
  final int? memberId;

  MemberDetailsPage(this.memberName, this.memberId);

  @override
  Widget build(BuildContext context) {
    final MembersBloc membersBloc = BlocProvider.of<MembersBloc>(context);
    membersBloc.add(FetchMemberDetails(memberId));
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.colorPrimaryB,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: FittedBox(
            child: Text(memberName!, style: AppTheme.appBarStyle),
          ),
        ),
        body: BlocBuilder<MembersBloc, MembersState>(
          builder: (context, state) {
            if (state is SingleMemberLoading) {
              return AppTheme.showLoadingSpinKit();
            } else if (state is SingleMemberLoaded) {
              return Column(
                children: <Widget>[
                  headerWidget(context, state.singleMembersModel!),
                ],
              );
            } else if (state is SingleMemberError) {
              return Text(state.errorMessage);
            } else {
              return AppTheme.showLoadingSpinKit();
            }
          },
        ),
      ),
    );
  }

  /// header Widget
  Widget headerWidget(
      BuildContext context, SingleWorkMemberModel singleMembersModel) {
    return Stack(
      children: <Widget>[
        buildHeaderBackground(),
        Positioned(
          child: buildHeaderContent(context, singleMembersModel),
          bottom: 0,
          right: 6 * SizeConfig.imageSizeMultiplier,
          left: 6 * SizeConfig.imageSizeMultiplier,
        ),
      ],
    );
  }

  /// build Header Background
  Widget buildHeaderBackground() => Column(
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            height: 50 * SizeConfig.imageSizeMultiplier,
            child: Container(
              color: AppTheme.buttonsColor,
            ),
          ),
          SizedBox(height: 8 * SizeConfig.imageSizeMultiplier),
        ],
      );

  /// build Header Content
  Widget buildHeaderContent(
          BuildContext context, SingleWorkMemberModel memberModel) =>
      Row(
        children: <Widget>[
          buildProfileImage(context, "${memberModel.results!.editorId}"),
          SizedBox(width: 24),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AutoSizeText(
                memberModel.results!.editorName!,
                style: AppTheme.textStyleWhite14w600,
              ),
              AutoSizeText(
                memberModel.results!.jobTitle!,
                style: AppTheme.textStyleWhiteB16w600,
              ),
            ],
          ),
        ],
      );

  /// build Profile Image
  Widget buildProfileImage(BuildContext context, String memberImage) {
    final image = DecorationImage(
      fit: BoxFit.cover,
      image: NetworkImage(
        "$BASE_URL/Content/Upload/Editors/Med/$memberImage.jpg",
      ),
    );

    return Container(
      height: 25 * SizeConfig.heightMultiplier,
      width: 35 * SizeConfig.widthMultiplier,
      decoration: decoration(context, image: image),
    );
  }

  Decoration decoration(BuildContext context, {DecorationImage? image}) =>
      BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        boxShadow: [
          BoxShadow(color: AppTheme.buttonsColor, spreadRadius: 4),
        ],
        image: image,
      );
}
