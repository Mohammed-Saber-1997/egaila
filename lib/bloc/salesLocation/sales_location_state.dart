part of 'sales_location_bloc.dart';

@immutable
abstract class SalesLocationState {
  final List<SalesLocationModel>? modelLocation;

  SalesLocationState(this.modelLocation);
}

class SalesLocationInitial extends SalesLocationState {
  SalesLocationInitial() : super(null);
}

class LocationLoaded extends SalesLocationState {
  final List<SalesLocationModel> modelLocation;

  LocationLoaded(this.modelLocation) : super(modelLocation);
}
