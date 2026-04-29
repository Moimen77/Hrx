import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class AddBranchLocationController extends GetxController {
  final currentCenter = LatLng(30.0444, 31.2357).obs;
  RxList<Marker> markers = <Marker>[].obs;
  final MapController mapController = MapController();

  addmark(lang) {
    markers.clear();
    currentCenter.value = lang;
    markers.add(
      Marker(
        point: lang,
        child: const Icon(Icons.location_on, color: Colors.red, size: 40),
      ),
    );
    mapController.move(lang, 15);
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar("تنبيه", "يرجى تفعيل خدمات الموقع (GPS) في الجهاز");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar("تنبيه", "تم رفض إذن الوصول للموقع");
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    LatLng newPoint = LatLng(position.latitude, position.longitude);
    currentCenter.value = newPoint;
    markers.clear();
    markers.add(
      Marker(
        point: newPoint,
        child: const Icon(Icons.location_on, color: Colors.red, size: 40),
      ),
    );
    mapController.move(newPoint, 15);
  }

  returntoCurrent() {
    markers.clear();
    markers.add(
      Marker(
        point: currentCenter.value,
        child: const Icon(Icons.location_on, color: Colors.red, size: 40),
      ),
    );
    update();
  }

  @override
  void onInit() {
    markers.add(
      Marker(
        point: currentCenter.value,
        child: const Icon(Icons.location_on, color: Colors.red, size: 40),
      ),
    );
    super.onInit();
  }
}
