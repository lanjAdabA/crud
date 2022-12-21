import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationService extends StatefulWidget {
  const LocationService({
    Key? key,
  }) : super(key: key);

  @override
  State<LocationService> createState() => _LocationServiceState();
}

@override
class _LocationServiceState extends State<LocationService> {
  String? latitude;
  String? longitude;
  String finallocation = '';

  Position? _position;

  void _getCurrentLocation(void Function(void Function()) setState) async {
    Position position = await _determinePosition();
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _position = position;
      latitude = position.latitude.toString();
      longitude = position.longitude.toString();
      finallocation = "$latitude,$longitude";
    });

    prefs.setString("finalLocation", finallocation);
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton.icon(
          onPressed: () {
            _getCurrentLocation(setState);
          },
          label: const Text(
            "pin location   ",
          ),
          icon: const Icon(Icons.add_location_alt_outlined),
        ),
        _position != null
            ? Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Latitude : ",
                        ),
                        Text(
                          latitude!,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Longitude : ',
                        ),
                        Text(
                          longitude!,
                        )
                      ],
                    )
                  ],
                ),
              )
            : Column(
                children: const [
                  Text(
                    "Latitude : ....................",
                  ),
                  Text(
                    'Longitude : .................. ',
                  )
                ],
              ),
        const SizedBox(
          width: 60,
        )
      ],
    );
  }
}
