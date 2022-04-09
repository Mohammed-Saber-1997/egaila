part of 'shareholder_sign_in_bloc.dart';

@immutable
abstract class ShareholderSignInState {
  final SignInShareholderModel? model;

  ShareholderSignInState(this.model);
}

class ShareholderSignInInitial extends ShareholderSignInState {
  ShareholderSignInInitial() : super(null);
}

class ShareholderSignInLoading extends ShareholderSignInState {
  ShareholderSignInLoading() : super(null);
}

class ShareholderSignInLoaded extends ShareholderSignInState {
  final SignInShareholderModel model;

  ShareholderSignInLoaded(this.model) : super(model);
}

class ShareholderSignInError extends ShareholderSignInState {
  final String errorMessage;

  ShareholderSignInError(this.errorMessage) : super(null);
}
