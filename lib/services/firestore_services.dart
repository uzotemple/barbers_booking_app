import 'package:barbersapp/model/appointment.dart';
// import 'package:barbersapp/model/appointments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:your_app_name/models/appointment.dart';

class FirestoreService {

  // Collection references
  final CollectionReference appointmentCollection = FirebaseFirestore.instance.collection('appointments');

  // Add an appointment
  Future<void> addAppointment(Appointment appointment) {
    return appointmentCollection.doc(appointment.id).set(appointment.toMap());
  }

  // Get appointment by ID
  Future<Appointment?> getAppointmentById(String id) async {
    var doc = await appointmentCollection.doc(id).get();
    if (doc.exists) {
      return Appointment.fromMap(doc.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  // Update an appointment
  Future<void> updateAppointment(Appointment appointment) {
    return appointmentCollection.doc(appointment.id).update(appointment.toMap());
  }

  // Delete an appointment
  Future<void> deleteAppointment(String id) {
    return appointmentCollection.doc(id).delete();
  }

  // Get all appointments
  Stream<List<Appointment>> getAppointments() {
    return appointmentCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Appointment.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  getBarbers() {}
}
