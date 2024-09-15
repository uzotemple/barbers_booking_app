// import 'package:flutter/material.dart';

// class CustomerProfileScreen extends StatelessWidget {
//   // Sample data for the customer's profile
//   final Map<String, dynamic> customerProfile = {
//     'name': 'Jane Doe',
//     'photoUrl': 'images/customer.png', // Replace with an actual image path or network URL
//     'email': 'janedoe@example.com',
//     'phone': '+1 234 567 890',
//     'upcomingAppointments': [
//       {
//         'date': DateTime.now().add(const Duration(days: 2)),
//         'time': '3:00 PM',
//         'service': 'Haircut',
//       },
//       {
//         'date': DateTime.now().add(const Duration(days: 5)),
//         'time': '10:00 AM',
//         'service': 'Beard Trim',
//       },
//     ],
//     'pastAppointments': [
//       {
//         'date': DateTime.now().subtract(const Duration(days: 2)),
//         'time': '1:00 PM',
//         'service': 'Shave',
//       },
//       {
//         'date': DateTime.now().subtract(const Duration(days: 10)),
//         'time': '11:00 AM',
//         'service': 'Hair Dye',
//       },
//     ],
//   };

//   CustomerProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Customer Profile'),
//         iconTheme: const IconThemeData(color: Colors.white),
//         backgroundColor: const Color(0xFF001F5F),
//         foregroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Customer photo
//             Center(
//               child: CircleAvatar(
//                 backgroundImage: AssetImage(customerProfile['photoUrl']),
//                 radius: 60.0,
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             // Customer name
//             Center(
//               child: Text(
//                 customerProfile['name'],
//                 style: const TextStyle(
//                   fontSize: 24.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8.0),
//             // Customer contact information
//             const SizedBox(height: 16.0),
//             const Text(
//               'Contact Information:',
//               style: TextStyle(
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8.0),
//             Text(
//               'Email: ${customerProfile['email']}',
//               style: const TextStyle(fontSize: 16.0),
//             ),
//             const SizedBox(height: 8.0),
//             Text(
//               'Phone: ${customerProfile['phone']}',
//               style: const TextStyle(fontSize: 16.0),
//             ),
//             const SizedBox(height: 16.0),
//             // Upcoming appointments
//             const Text(
//               'Upcoming Appointments:',
//               style: TextStyle(
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: customerProfile['upcomingAppointments'].length,
//               itemBuilder: (context, index) {
//                 var appointment = customerProfile['upcomingAppointments'][index];
//                 return ListTile(
//                   leading: const Icon(Icons.event, color: Colors.teal),
//                   title: Text(appointment['service']),
//                   subtitle: Text(
//                     'Date: ${appointment['date'].toString().substring(0, 10)}, Time: ${appointment['time']}',
//                   ),
//                 );
//               },
//             ),
//             const SizedBox(height: 16.0),
//             // Past appointments
//             const Text(
//               'Past Appointments:',
//               style: TextStyle(
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: customerProfile['pastAppointments'].length,
//               itemBuilder: (context, index) {
//                 var appointment = customerProfile['pastAppointments'][index];
//                 return ListTile(
//                   leading: const Icon(Icons.history, color: Colors.teal),
//                   title: Text(appointment['service']),
//                   subtitle: Text(
//                     'Date: ${appointment['date'].toString().substring(0, 10)}, Time: ${appointment['time']}',
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:barbersapp/screens/edit_customer_profile.dart';
import 'package:flutter/material.dart';

class CustomerProfileScreen extends StatelessWidget {
  // Sample data for the customer's profile
  final Map<String, dynamic> customerProfile = {
    'name': 'Jane Doe',
    'photoUrl': 'images/customer.jpg',
    'email': 'janedoe@example.com',
    'phone': '+1 234 567 890',
    'upcomingAppointments': [
      {
        'date': DateTime.now().add(const Duration(days: 2)),
        'time': '3:00 PM',
        'service': 'Haircut',
      },
      {
        'date': DateTime.now().add(const Duration(days: 5)),
        'time': '10:00 AM',
        'service': 'Beard Trim',
      },
    ],
    'pastAppointments': [
      {
        'date': DateTime.now().subtract(const Duration(days: 2)),
        'time': '1:00 PM',
        'service': 'Shave',
      },
      {
        'date': DateTime.now().subtract(const Duration(days: 10)),
        'time': '11:00 AM',
        'service': 'Hair Dye',
      },
    ],
  };

  CustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Profile'),
        iconTheme: const IconThemeData(color: Colors.white),
        // backgroundColor: const Color(0xFF001F5F),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const EditCustomerProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Customer photo
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage(customerProfile['photoUrl']),
                radius: 60.0,
              ),
            ),
            const SizedBox(height: 16.0),
            // Customer name
            Center(
              child: Text(
                customerProfile['name'],
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            // Customer contact information
            const SizedBox(height: 16.0),
            const Text(
              'Contact Information:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Email: ${customerProfile['email']}',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Phone: ${customerProfile['phone']}',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            // Upcoming appointments
            const Text(
              'Upcoming Appointments:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: customerProfile['upcomingAppointments'].length,
              itemBuilder: (context, index) {
                var appointment = customerProfile['upcomingAppointments'][index];
                return ListTile(
                  leading: const Icon(Icons.event, color: Color(0xFF001F5F)),
                  title: Text(appointment['service']),
                  subtitle: Text(
                    'Date: ${appointment['date'].toString().substring(0, 10)}, Time: ${appointment['time']}',
                  ),
                );
              },
            ),
            const SizedBox(height: 16.0),
            // Past appointments
            const Text(
              'Past Appointments:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: customerProfile['pastAppointments'].length,
              itemBuilder: (context, index) {
                var appointment = customerProfile['pastAppointments'][index];
                return ListTile(
                  leading: const Icon(Icons.history, color: Color(0xFF001F5F)),
                  title: Text(appointment['service']),
                  subtitle: Text(
                    'Date: ${appointment['date'].toString().substring(0, 10)}, Time: ${appointment['time']}',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
