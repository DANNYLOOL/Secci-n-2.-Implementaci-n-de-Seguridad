import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String _location = 'Ubicación no disponible';

  Future<void> _getLocation() async {
    // Solicitar permiso de ubicación
    PermissionStatus permission = await Permission.location.request();
    if (permission.isGranted) {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _location = 'Lat: ${position.latitude}, Lng: ${position.longitude}';
      });
    } else {
      setState(() {
        _location = 'Permiso de ubicación denegado';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ubicación del dispositivo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_location),
            ElevatedButton(
              onPressed: _getLocation,
              child: Text('Obtener ubicación'),
            ),
          ],
        ),
      ),
    );
  }
}
