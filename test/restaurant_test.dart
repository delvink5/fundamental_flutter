import 'package:flutter_test/flutter_test.dart';
import 'package:fundamental_2/api/api_service.dart';
import 'package:fundamental_2/model/restaurant.dart';
import 'package:http/http.dart' as http;
import 'restaurant_test.mocks.dart' as mock;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([http.Client])
void main() {
  group('Testing RestaurantResult', () {
    final mockClient = mock.MockClient();
    const baseUrl = 'https://restaurant-api.dicoding.dev/';
    const path = 'list';
    test('Exception on 404', () async {
      when(mockClient.get(Uri.parse(baseUrl + path)))
          .thenAnswer((realInvocation) async => http.Response('', 404));

      expect(ApiService().restaurantList(mockClient), throwsException);
    });
    test('should return a correct data for RestaurantResult', () async {
      const response = '''{
    "error": false,
    "message": "success",
    "count": 1,
    "restaurants": [
        {
          "name": "Melting Pot",
          "id": "rqdv5juczeskfw1e867",
          "pictureId": "14",
          "city": "Medan",
          "rating": 4.2,
          "description":
              "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet."
        }
    ]
}
    ''';

      final expected = RestaurantResult(
          error: false,
          message: "success",
          count: 1,
          restaurants: [
            Restaurant(
                name: "Melting Pot",
                id: "rqdv5juczeskfw1e867",
                pictureId: "14",
                city: "Medan",
                rating: 4.2,
                description:
                    'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.')
          ]);

      when(mockClient.get(Uri.parse(baseUrl + path)))
          .thenAnswer((realInvocation) async => http.Response(response, 200));

      expect(await ApiService().restaurantList(mockClient), expected);
    });
    test(
        'should have no other key besides the defined by one of the restaurants',
        () async {
      const response = '''
{
    "error": false,
    "message": "success",
    "count": 1,
    "restaurants": [
        {
            "id": "www",
            "rating": 4.3,
            "pictureId": "14",
            "city": "Medan",
            "name": "Melting fire",
            "asdfghjhjk": 561560,
            "description": "the quick brown fox jumps over the lazy dog"
        }
    ]
}
      ''';

      when(mockClient.get(Uri.parse(baseUrl + path)))
          .thenAnswer((realInvocation) async => http.Response(response, 200));

      expect(
          (await ApiService().restaurantList(mockClient))
              .restaurants[0]
              .toJson()['description1'],
          null);
      expect(
          (await ApiService().restaurantList(mockClient))
              .restaurants[0]
              .toJson()['description2'],
          null);
      expect(
          (await ApiService().restaurantList(mockClient))
              .restaurants[0]
              .toJson()['description3'],
          null);
      expect(
          (await ApiService().restaurantList(mockClient))
              .restaurants[0]
              .toJson()['description4'],
          null);
    });
  });
}
