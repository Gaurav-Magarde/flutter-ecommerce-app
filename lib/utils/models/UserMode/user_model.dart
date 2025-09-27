
import 'package:clone_shopping/features/personalization/Screens/Address/Models/address_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../formatters/formatter.dart';

class UserModel {
  // Keep these values final as they are not expected to change once set.
  final String id;
  final String email;
  final String username;

  // These values can be updated, so they are not final.
  String firstName;
  String lastName;
  String phoneNumber;
  String profilePicture;
  final AddressModel? defaultAddress;

  /// Constructor for UserModel.
  UserModel( {
    this.defaultAddress,
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.profilePicture,
  });

  /// Helper function to get the full name.
  String get fullName => '$firstName $lastName';

  /// Helper function to format the phone number.
  String get formattedPhoneNumber => TFormatter.formatPhoneNumber(phoneNumber);

  /// Static function to split full name into first and last name.
  static List<String> nameParts(String fullName) => fullName.split(" ");

  /// Static function to generate a username from a full name.
  static String generateUsername(String fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername = "$firstName$lastName"; // Combine first and last name
    String usernameWithPrefix = camelCaseUsername; // Add a prefix
    return usernameWithPrefix;
  }

  /// Static function to create an empty user model.
  static UserModel empty() =>
      UserModel(
        defaultAddress: null,
        id: '',
        email: '',
        username: '',
        firstName: '',
        lastName: '',
        phoneNumber: '',
        profilePicture: '',
      );

  /// Convert model to JSON structure for storing data in Firebase.
  Map<String, dynamic> toJson() {
    return {
      'DefaultAddress' : defaultAddress?.toJson(),
      'FirstName': firstName,
      'FullName': fullName,
      'LastName': lastName,
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
    };
  }

  /// Factory method to create a UserModel from a Firebase document snapshot.
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        defaultAddress: data['DefaultAddress'] == null ?  null : AddressModel.fromJson(data['DefaultAddress']),
        id: document.id,
        email: data['Email'] ?? '',
        username: data['Username'] ?? '',
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }
}