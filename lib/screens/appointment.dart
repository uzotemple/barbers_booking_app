// import 'package:barbersapp/services/firestore_service.dart';
import 'package:barbersapp/model/appointment.dart';
import 'package:barbersapp/services/firestore_services.dart';
import 'package:flutter/material.dart';

class AppointmentsPage extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();

  AppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Appointments',
      //   style: TextStyle(color: Colors.white),
      //   ),
      //   centerTitle: true,
      //   iconTheme: const IconThemeData(color: Colors.white),
      //   backgroundColor: const Color(0xFF001F5F),
      // ),
      body: StreamBuilder<List<Appointment>>(
        stream: firestoreService.getAppointments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No appointments found'));
          } else {
            var appointments = snapshot.data!;
            return ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                var appointment = appointments[index];
                return ListTile(
                  title: Text('Customer ID: ${appointment.customerId}'),
                  subtitle: Text('Appointment Date: ${appointment.dateTime}'),
                  trailing: Text('Status: ${appointment.status}'),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF001F5F),
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, '/barbersbooking');
        },
        tooltip: 'Book Appointment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
