import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'bloc/restaurant_bloc.dart';
import 'domain/repositories/restaurant_repository.dart';

void main() {
  final RestaurantRepository restaurantRepository = RestaurantRepository();
  final RestaurantBloc restaurantBloc = RestaurantBloc(restaurantRepository);

  runApp(
    MaterialApp(
      home: BlocProvider<RestaurantBloc>(
        create: (context) => restaurantBloc..add( FetchRestaurants()), 
        child: const RestaurantPage(),
      ),
    ),
  );
}

class RestaurantPage extends StatelessWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
      ),
      body: BlocBuilder<RestaurantBloc, RestaurantState>(
        builder: (context, state) {
          if (state is RestaurantLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is RestaurantLoaded) {
            return ListView.builder(
              itemCount: state.restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = state.restaurants[index];
                return ListTile(
                  title: Text(restaurant.name ?? ''),
                  subtitle: Text(restaurant.city ?? ''),
                );
              },
            );
          } else if (state is RestaurantError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text('Ada yang Salah'),
            );
          }
        },
      ),
    );
  }
}
