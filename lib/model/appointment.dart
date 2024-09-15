// // import 'package:barbersapp/model/services_model.dart';

// class Appointment {
//   final String id;
//   final String barberId;
//   final String customerId;
//   final DateTime dateTime;
//   final String status;

//   Appointment({
//     required this.id,
//     required this.barberId,
//     required this.customerId,
//     required this.dateTime,
//     required this.status,
//   });

//   // Convert Appointment object to a map
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'barberId': barberId,
//       'customerId': customerId,
//       'dateTime': dateTime.toIso8601String(),
//       'status': status,
//     };
//   }

//   // Create an Appointment object from a map
//   factory Appointment.fromMap(Map<String, dynamic> map) {
//     return Appointment(
//       id: map['id'],
//       barberId: map['barberId'],
//       customerId: map['customerId'],
//       dateTime: DateTime.parse(map['dateTime']),
//       status: map['status'],
//     );
//   }
// }

class Appointment {
  final String id;
  final String barberId;
  final String customerId;
  final DateTime dateTime;
  final String status;
  final List<Map<String, dynamic>> services; // Add services field

  Appointment({
    required this.id,
    required this.barberId,
    required this.customerId,
    required this.dateTime,
    required this.status,
    required this.services, // Initialize services
  });

  // Convert Appointment object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'barberId': barberId,
      'customerId': customerId,
      'dateTime': dateTime.toIso8601String(),
      'status': status,
      'services': services, // Add services to the map
    };
  }

  // Create an Appointment object from a map
  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'],
      barberId: map['barberId'],
      customerId: map['customerId'],
      dateTime: DateTime.parse(map['dateTime']),
      status: map['status'],
      services: List<Map<String, dynamic>>.from(map['services'] ?? []), // Parse services
    );
  }
}
