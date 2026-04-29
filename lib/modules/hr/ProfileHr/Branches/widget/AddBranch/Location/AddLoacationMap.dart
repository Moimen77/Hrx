import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:hrx/modules/hr/ProfileHr/Branches/controllers/AddBranchLocationController.dart';

class AddLoacationMap extends GetView<AddBranchLocationController> {
  const AddLoacationMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FlutterMap(
        mapController: controller.mapController,
        options: MapOptions(
          initialZoom: 13,
          initialCenter: controller.currentCenter.value,
          onTap: (tap, latlang) {
            controller.addmark(latlang);
          },
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
            userAgentPackageName: 'com.example.shop',
          ),
          MarkerLayer(markers: controller.markers.toList()),
        ],
      ),
    );
  }
}
