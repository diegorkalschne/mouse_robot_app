class DeviceModel {
  DeviceModel({
    required this.name,
    required this.linkConnection,
  });

  factory DeviceModel.empty() {
    return DeviceModel(name: null, linkConnection: null);
  }

  factory DeviceModel.fromJson(Map data) {
    return DeviceModel(
      name: data['name'],
      linkConnection: data['linkConnection'],
    );
  }

  String? name;
  String? linkConnection;

  Map toJson() {
    return {
      'name': name,
      'linkConnection': linkConnection,
    };
  }

  DeviceModel clone() {
    return DeviceModel(
      name: name,
      linkConnection: linkConnection,
    );
  }
}
