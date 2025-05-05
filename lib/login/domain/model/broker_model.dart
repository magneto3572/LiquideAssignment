

import 'broker.dart';

class BrokerModel extends Broker {
  const BrokerModel({
    required super.id,
    required super.name,
    required super.logo,
  });

  factory BrokerModel.fromJson(Map<String, dynamic> json) {
    return BrokerModel(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
    };
  }
}