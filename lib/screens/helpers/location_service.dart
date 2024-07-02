import 'package:geocoding/geocoding.dart';

class LocationService {
  Future<Location?> getLocationFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      return locations.first;
    } catch (e) {
      print('Error occurred while searching for address: $e');
      return null;
    }
  }
}