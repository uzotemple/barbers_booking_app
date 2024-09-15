// import 'package:barbersapp/model/appointment.dart';
// import 'package:barbersapp/services/firestore_services.dart';
// import 'package:flutter/material.dart';
// import 'package:uuid/uuid.dart';

// class ConfirmCustomerBookingPage extends StatefulWidget {
//   const ConfirmCustomerBookingPage({super.key, required Map barber});

//   @override
//   // ignore: library_private_types_in_public_api
//   _ConfirmCustomerBookingPageState createState() => _ConfirmCustomerBookingPageState();
// }

// class _ConfirmCustomerBookingPageState extends State<ConfirmCustomerBookingPage> {
//   final _formKey = GlobalKey<FormState>();
//   final FirestoreService _firestoreService = FirestoreService();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _contactController = TextEditingController();
//   DateTime _selectedDateTime = DateTime.now();
//   final String _status = 'Pending';
//   final _uuid = const Uuid();
//   String? _selectedBarberId;

//   Future<void> _selectDateTime(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: _selectedDateTime,
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//     );

//     if (pickedDate != null) {
//       final TimeOfDay? pickedTime = await showTimePicker(
//         // ignore: use_build_context_synchronously
//         context: context,
//         initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
//       );

//       if (pickedTime != null) {
//         setState(() {
//           _selectedDateTime = DateTime(
//             pickedDate.year,
//             pickedDate.month,
//             pickedDate.day,
//             pickedTime.hour,
//             pickedTime.minute,
//           );
//         });
//       }
//     }
//   }

//   Future<void> _confirmBooking() async {
//     if (_formKey.currentState!.validate()) {
//       final newAppointment = Appointment(
//         id: _uuid.v4(),
//         barberId: _selectedBarberId!,
//         customerId: _contactController.text,
//         dateTime: _selectedDateTime,
//         status: _status,
//       );
//       await _firestoreService.addAppointment(newAppointment);
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Booking Confirmed')),
//       );
//       Navigator.pop(context);
//     }
//   }

//   Future<List<Map<String, String>>> _fetchBarbers() async {
//     return await _firestoreService.getBarbers();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Customers Booking Form',
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//         iconTheme: const IconThemeData(color: Colors.white),
//         backgroundColor: const Color(0xFF001F5F),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: <Widget>[
//               TextFormField(
//                 controller: _nameController,
//                 decoration: const InputDecoration(
//                   labelText: 'Name',
//                   filled: true,
//                   fillColor: Color(0xFFF0F0FF),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                     borderSide: BorderSide(color: Colors.blue, width: 1.0),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                     borderSide: BorderSide(color: Colors.blue, width: 2.0),
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your name';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: _contactController,
//                 decoration: const InputDecoration(
//                   labelText: 'Contact Information',
//                   filled: true,
//                   fillColor: Color(0xFFF0F0FF),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                     borderSide: BorderSide(color: Colors.blue, width: 1.0),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                     borderSide: BorderSide(color: Colors.blue, width: 2.0),
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your contact information';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               FutureBuilder<List<Map<String, String>>>(
//                 future: _fetchBarbers(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const CircularProgressIndicator();
//                   } else if (snapshot.hasError) {
//                     return const Text('Error fetching barbers');
//                   } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return const Text('No barbers available');
//                   } else {
//                     return DropdownButtonFormField<String>(
//                       decoration: const InputDecoration(
//                         labelText: 'Select Barber',
//                         filled: true,
//                         fillColor: Color(0xFFF0F0FF),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                           borderSide: BorderSide(color: Colors.blue, width: 1.0),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                           borderSide: BorderSide(color: Colors.blue, width: 2.0),
//                         ),
//                       ),
//                       items: snapshot.data!.map((barber) {
//                         return DropdownMenuItem<String>(
//                           value: barber['id'],
//                           child: Text(barber['name']!),
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         setState(() {
//                           _selectedBarberId = value;
//                         });
//                       },
//                       validator: (value) {
//                         if (value == null) {
//                           return 'Please select a barber';
//                         }
//                         return null;
//                       },
//                     );
//                   }
//                 },
//               ),
//               const SizedBox(height: 20),
//               ListTile(
//                 title: const Text('Select Appointment Date and Time'),
//                 subtitle: Text(
//                   '${'${_selectedDateTime.toLocal()}'.split(' ')[0]} ${TimeOfDay.fromDateTime(_selectedDateTime).format(context)}',
//                 ),
//                 trailing: const CircleAvatar(
//                   backgroundColor: Color(0xFF001F5F),
//                   foregroundColor: Colors.white,
//                   child: Icon(Icons.calendar_today),
//                 ),
//                 onTap: () => _selectDateTime(context),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _confirmBooking,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF001F5F),
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: const Text('Confirm Booking'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _contactController.dispose();
//     super.dispose();
//   }
// }

import 'package:barbersapp/model/appointment.dart';
import 'package:barbersapp/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ConfirmCustomerBookingPage extends StatefulWidget {
  const ConfirmCustomerBookingPage({super.key, required Map barber});

  @override
  // ignore: library_private_types_in_public_api
  _ConfirmCustomerBookingPageState createState() =>
      _ConfirmCustomerBookingPageState();
}

class _ConfirmCustomerBookingPageState
    extends State<ConfirmCustomerBookingPage> {
  final _formKey = GlobalKey<FormState>();
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  DateTime _selectedDateTime = DateTime.now();
  final String _status = 'Pending';
  final _uuid = const Uuid();
  String? _selectedBarberId;
  final List<Map<String, dynamic>> _selectedServices =
      []; // List to store selected services

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        // ignore: use_build_context_synchronously
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  Future<void> _confirmBooking() async {
    if (_formKey.currentState!.validate()) {
      final newAppointment = Appointment(
        id: _uuid.v4(),
        barberId: _selectedBarberId!,
        customerId: _contactController.text,
        dateTime: _selectedDateTime,
        status: _status,
        services: _selectedServices, // Pass selected services
      );
      await _firestoreService.addAppointment(newAppointment);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking Confirmed')),
      );
      Navigator.pop(context);
    }
  }

  Future<List<Map<String, String>>> _fetchBarbers() async {
    return await _firestoreService.getBarbers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Customers Booking Form',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        // backgroundColor: const Color(0xFF001F5F),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/profile');
                },
                child: const Text('View Barber Profile'),
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  filled: true,
                  fillColor: Color(0xFFF0F0FF),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _contactController,
                decoration: const InputDecoration(
                  labelText: 'Contact Information',
                  filled: true,
                  fillColor: Color(0xFFF0F0FF),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your contact information';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              FutureBuilder<List<Map<String, String>>>(
                future: _fetchBarbers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text('Error fetching barbers');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No barbers available');
                  } else {
                    return DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Select Barber',
                        filled: true,
                        fillColor: Color(0xFFF0F0FF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
                        ),
                      ),
                      items: snapshot.data!.map((barber) {
                        return DropdownMenuItem<String>(
                          value: barber['id'],
                          child: Text(barber['name']!),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedBarberId = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a barber';
                        }
                        return null;
                      },
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              // Display the services with checkboxes
              const Text('Select Services'),
              ..._availableServices.map((service) => CheckboxListTile(
                    title: Text(service['name'] ?? 'Unknown Service'),
                    subtitle: Text(
                        '${service['duration']} mins - \$${service['price']}'),
                    value: _selectedServices.contains(service),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          _selectedServices.add(service);
                        } else {
                          _selectedServices.remove(service);
                        }
                      });
                    },
                  )),
              const SizedBox(height: 20),
              ListTile(
                title: const Text('Select Appointment Date and Time'),
                subtitle: Text(
                  '${'${_selectedDateTime.toLocal()}'.split(' ')[0]} ${TimeOfDay.fromDateTime(_selectedDateTime).format(context)}',
                ),
                trailing: const CircleAvatar(
                  backgroundColor: Color(0xFF001F5F),
                  foregroundColor: Colors.white,
                  child: Icon(Icons.calendar_today),
                ),
                onTap: () => _selectDateTime(context),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _confirmBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF001F5F),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Confirm Booking'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  // Sample available services, replace with your actual data source
  final List<Map<String, dynamic>> _availableServices = [
    {'name': 'Haircut', 'duration': 30, 'price': 15.0},
    {'name': 'Shave', 'duration': 15, 'price': 10.0},
    {'name': 'Beard Trim', 'duration': 15, 'price': 10.0},
    {'name': 'Facial', 'duration': 45, 'price': 25.0},
    {'name': 'Hair Dye', 'duration': 35, 'price': 20.0},
  ];
}
