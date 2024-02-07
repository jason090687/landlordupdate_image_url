import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key});

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  DateTime _selectedDate = DateTime.now();
  int guestsCount = 1;
  int roomCount = 1;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _decrementGuests() {
    setState(() {
      guestsCount = guestsCount > 1 ? guestsCount - 1 : 1;
    });
  }

  void _incrementGuests() {
    setState(() {
      guestsCount++;
    });
  }

  void _decrementRooms() {
    setState(() {
      roomCount = roomCount > 1 ? roomCount - 1 : 1;
    });
  }

  void _incrementRooms() {
    setState(() {
      roomCount++;
    });
  }

  Future<void> getCurrentLocationAndSaveToFirebase() async {
    // Initialize Firebase

    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionStatus;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        print('Location services are not enabled.');
        return;
      }
    }

    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        print('Location permissions are denied.');
        return;
      }
    }

    locationData = await location.getLocation();

    // Get latitude and longitude
    double latitude = locationData.latitude!;
    double longitude = locationData.longitude!;

    // Display location in text field
    TextEditingController _locationController = TextEditingController();
    _locationController.text = 'Latitude: $latitude, Longitude: $longitude';

    // Save location to Firebase
    FirebaseFirestore.instance.collection('locations').add({
      'latitude': latitude,
      'longitude': longitude,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ListView(
        children: <Widget>[
          const SizedBox(height: 10),
          const Text(
            'Step into your upcoming exploration!',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 6.0),
          const Row(
            children: [
              Text(
                'Explore an ideal stay with ',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Text(
                'CDO',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'seek',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(247, 195, 27, 0.612),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          const Row(
            children: [
              Text(
                'Where?',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(width: 15.0),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                hintText: 'Enter location',
                prefixIcon: const Icon(Icons.location_on, size: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          const Row(
            children: [
              Text(
                'Check-in',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10.0),
            ],
          ),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today),
                          const SizedBox(width: 10.0),
                          Text(DateFormat('d MMM, y').format(_selectedDate)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 40.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Guests',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 5.0),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: _decrementGuests,
                    ),
                    Text('$guestsCount'),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: _incrementGuests,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10.0),
              const Text(
                'Room',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 5.0),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: _decrementRooms,
                    ),
                    Text('$roomCount'),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: _incrementRooms,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30.0),
          ElevatedButton(
            onPressed: () {
              () => getCurrentLocationAndSaveToFirebase();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Text(
              'FIND',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: CustomBottomSheet(),
      ),
    ),
  ));
}
