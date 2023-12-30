import 'dart:convert';

import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:location/location.dart';

const String _apiKey = "658ed9ce6c658360849892eos752135";

class BuyPage extends StatefulWidget {
  const BuyPage({super.key});

  @override
  State<BuyPage> createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  bool isLoading = false;
  final location = Location();
  LocationData? _locationData;
  String? _address;
  bool hasFailed = false;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _getLocation();
    });
  }

  Future<void> _getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    setState(() {
      isLoading = true;
    });

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    // https://geocode.maps.co/reverse?lat=latitude&lon=longitude&api_key=api_key
    try {
      final url =
          "https://geocode.maps.co/reverse?lat=${_locationData?.latitude}&lon=${_locationData?.longitude}&api_key=$_apiKey";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) {
        setState(() {
          hasFailed = true;
          isLoading = false;
        });

        return;
      }

      final json = response.body;
      final data = jsonDecode(json);

      print(data);

      /*
        "address":{
      "building":Google Building 40,
      "road":"Amphitheatre Parkway",
      "city":"Mountain View",
      "county":"Santa Clara County",
      "state":"California",
      "postcode":94043,
      "country":"United States",
      "country_code":"us"
      },
      */

      Map<String, dynamic> address = data['address'];

      _address =
          "${address['building']}, ${address['road']}, ${address['city']}, ${address['state']}, ${address['country']}, ${address['postcode']}";

      setState(() {
        isLoading = false;
        hasFailed = false;
      });

      await Haptics.vibrate(HapticsType.success);
    } catch (e) {
      print(e);
      setState(() {
        hasFailed = true;
        isLoading = false;
      });

      await Haptics.vibrate(HapticsType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete your Purchase'),
      ),
      body: () {
        if (isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (hasFailed) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Something went wrong. Please try again later.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await _getLocation();
                  },
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        }

        if (_locationData == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Please enable location services to continue.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await _getLocation();
                  },
                  child: const Text('Enable Location Services'),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Image.asset(
                'assets/images/splash.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 20),
              const Text(
                'Your order has been placed!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Thank you for shopping with us. Your order will be delivered to you within 3-5 business days.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Your order will be delivered to:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                _address ?? "Unknown",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('Back to Home'),
              ),
            ],
          ),
        );
      }(),
    );
  }
}
