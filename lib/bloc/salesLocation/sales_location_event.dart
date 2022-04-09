part of 'sales_location_bloc.dart';

@immutable
abstract class SalesLocationEvent {}

class GetSalesLocation extends SalesLocationEvent {
  GetSalesLocation();
}
