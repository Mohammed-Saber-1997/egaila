part of 'shareholder_sign_in_bloc.dart';

@immutable
abstract class ShareholderSignInEvent {}

class LogInButtonEvent extends ShareholderSignInEvent {
  final String civilNo;
  final String boxNo;
  LogInButtonEvent(this.civilNo, this.boxNo);
}
