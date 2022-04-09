import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:eqaila_app/models/models.dart';
import 'package:eqaila_app/repository/shareholder/sales_location_repository.dart';

part 'sales_location_event.dart';
part 'sales_location_state.dart';

class SalesLocationBloc extends Bloc<SalesLocationEvent, SalesLocationState> {
  final SalesLocationRepository repository;
  SalesLocationBloc(this.repository) : super(SalesLocationInitial());

  @override
  Stream<SalesLocationState> mapEventToState(
    SalesLocationEvent event,
  ) async* {
    if (event is GetSalesLocation) {
      try {
        List<SalesLocationModel> locationMode =
            await repository.getSalesLocation();
        yield LocationLoaded(locationMode);
      } catch (e) {
        print(e);
      }
    }
  }
}
