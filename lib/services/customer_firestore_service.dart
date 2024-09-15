import 'package:barbersapp/model/appointment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Map<String, String>>> getBarbers() async {
    final snapshot = await _db.collection('barbers').get();
    return snapshot.docs.map((doc) {
      return {
        'id': doc.id,
        'name': doc['name'] as String,  // Ensure this is cast to String
      };
    }).toList();
  }

  Future<void> addAppointment(Appointment appointment) async {
    await _db.collection('appointments').doc(appointment.id).set(appointment.toMap());
  }
}
