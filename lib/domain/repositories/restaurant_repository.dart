import 'package:dio/dio.dart';

import '../../data/model/restaurant/restaurant.dart';

class RestaurantRepository {
  final Dio _dio = Dio();

  Future<List<Restaurant>> getRestaurants() async {
    try {
      final response = await _dio.get('https://restaurant-api.dicoding.dev/list');
      final data = response.data as Map<String, dynamic>;
      print('$data kk');

      final List<dynamic> restaurantList = data['restaurants'];
       print('$restaurantList vvv');
      return restaurantList.map((json) => Restaurant.fromJson(json)).toList();
    } catch (error) {
    
      if (error is DioError) {
        print('${error.response?.statusCode} ${error.message} kkkqqq');
        final errorMessage = error.response?.data['message'] as String? ?? 'Failed to load restaurants';
        throw Exception(errorMessage);
      } else {
        throw Exception('Failed to load restaurants');
      }
    }
  }
}
