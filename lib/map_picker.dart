import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

class MapPicker extends StatefulWidget {
  final Function(String) onLocationPicked;
  final LatLng? initialPosition;

  const MapPicker(
      {Key? key, required this.onLocationPicked, this.initialPosition})
      : super(key: key);

  @override
  MapPickerState createState() => MapPickerState();
}

class MapPickerState extends State<MapPicker> {
  late LatLng _currentPosition;
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  String _selectedAddress = '';

  @override
  void initState() {
    super.initState();
    _currentPosition = widget.initialPosition ??
        LatLng(37.7749, -122.4194); // Default to San Francisco if null
  }

  void _onTap(LatLng point) async {
    List<Placemark> placemarks =
    await placemarkFromCoordinates(point.latitude, point.longitude);
    if (placemarks.isNotEmpty) {
      setState(() {
        _selectedAddress =
        '${placemarks.first.street}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}';
        _currentPosition = point;
      });
    } else {
      setState(() {
        _selectedAddress = 'Address not found';
        _currentPosition = point;
      });
    }
  }

  void _searchLocation() async {
    String query = _searchController.text;
    if (query.isNotEmpty) {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        LatLng newPosition =
        LatLng(locations.first.latitude, locations.first.longitude);
        List<Placemark> placemarks = await placemarkFromCoordinates(
            newPosition.latitude, newPosition.longitude);
        setState(() {
          _currentPosition = newPosition;
          _selectedAddress =
          '${placemarks.first.street}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}';
        });
        _mapController.move(newPosition, 14.0);
      }
    }
  }

  void _acceptLocation() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentPosition.latitude, _currentPosition.longitude);
    if (placemarks.isNotEmpty) {
      String address =
          '${placemarks.first.street}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}';
      widget.onLocationPicked(address);
    } else {
      widget.onLocationPicked(_currentPosition.toString());
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Location'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _acceptLocation,
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: _currentPosition,
              zoom: 14.0,
              onTap: (tapPosition, point) => _onTap(point),
              interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
            ),
            children: [
              TileLayer(
                urlTemplate:
                'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: _currentPosition,
                    builder: (ctx) => const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (_selectedAddress.isNotEmpty)
            Positioned(
              top: 10.0,
              left: 10.0,
              right: 10.0,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.white.withOpacity(0.8),
                child: Text(
                  _selectedAddress,
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          Positioned(
            bottom: 20.0,
            left: 20.0,
            right: 20.0,
            child: Material(
              elevation: 8.0,
              borderRadius: BorderRadius.circular(30.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search location',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 20.0),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: _searchLocation,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
