import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:eqaila_app/models/models.dart';
import 'package:eqaila_app/repository/shareholder/signin_shareholder_repository.dart';

part 'shareholder_sign_in_event.dart';
part 'shareholder_sign_in_state.dart';

class ShareholderSignInBloc
    extends Bloc<ShareholderSignInEvent, ShareholderSignInState> {
  final SignInShareholderRepository repository;

  ShareholderSignInBloc(this.repository) : super(ShareholderSignInInitial());

  List<SignInShareholderModel> _shareholderModel = [];

  @override
  Stream<ShareholderSignInState> mapEventToState(
    ShareholderSignInEvent event,
  ) async* {
    if (event is LogInButtonEvent) {
      yield ShareholderSignInLoading();
      if (event.civilNo.isEmpty && event.boxNo.isEmpty) {
        yield ShareholderSignInError("Error");
      } else {
        try {
          _shareholderModel = await repository.getSignInShareholderData(
              event.civilNo, event.boxNo);

          yield ShareholderSignInLoaded(_shareholderModel[0]);
        } catch (error) {
          yield ShareholderSignInError(error.toString());
        }
      }
    }
  }
}
