class BranchModel {
  int? id;
  final String name;
  final String address;
  final double lat;
  final double lng;

  BranchModel({
    this.id,
    required this.name,
    required this.address,
    required this.lat,
    required this.lng,
  });

  factory BranchModel.fromMap(Map<String, dynamic> map) {
    return BranchModel(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      lat: (map['lat'] as num).toDouble(),
      lng: (map['lng'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() => {
    "name": name,
    "address": address,
    "lat": lat,
    "lng": lng,
  };
}
