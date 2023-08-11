
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/model/restaurant/restaurant.dart';
import '../domain/repositories/restaurant_repository.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepository _repository;

 RestaurantBloc(this._repository) : super( RestaurantInitial()) {
  on<FetchRestaurants>((event, emit) async {
    emit( RestaurantLoading());
    try {
      final restaurants = await _repository.getRestaurants();
   
      emit(RestaurantLoaded(restaurants));
    } catch (error) {
      print('$error unik');
      emit(RestaurantError('Failed to gets restaurants'));
    }
  });
}
  Stream<RestaurantState> mapEventToState(RestaurantEvent event) async* {
    if (event is FetchRestaurants) {
      yield  RestaurantLoading();
      try {
        final restaurants = await _repository.getRestaurants();
        yield RestaurantLoaded(restaurants);
      } catch (error) {
        yield RestaurantError('Failed to get restaurants');
      }
    }
  }
}
