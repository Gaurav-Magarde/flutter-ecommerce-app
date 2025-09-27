
import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {

  AddressModel({
    required this.id,
    required this.name,
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.pinCode,
    required this.phone,
  });

  final String id;
  final String name;
  final String street;
  final String city;
  final String state;
  final String country;
  final String pinCode;
  final String phone;

  factory AddressModel.fromSnapshot(DocumentSnapshot snapshot){
    final data = snapshot.data() as Map<String, dynamic>;

    return AddressModel(
      id: snapshot.id,
      name: data['Name'],
      street: data['Street'],
      city: data['City'],
      state: data['State'],
      country: data['Country'],
      pinCode: data['PinCode'],
        phone: data['Phone'],
    );
  }

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['Id'] ?? "",
      name: json['Name'] ?? "",
      street: json['Street'] ?? "",
      city: json['City'] ?? "",
      state: json['State'] ?? "",
      country: json['Country'] ?? "",
      pinCode: json['PinCode'] ?? "",
      phone: json['Phone'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Street': street,
      'City': city,
      'State': state,
      'Country': country,
      'PinCode': pinCode,
      'Phone': phone,

    };
  }

  factory AddressModel.empty() {
    return AddressModel(
      id: "",
      name: "",
      street: "",
      city: "",
      state: '', country: '',
      pinCode: '', phone: '',
    );
  }


}
