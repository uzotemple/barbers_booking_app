// import 'package:flutter/material.dart';

// class ProfileScreen extends StatelessWidget {
//   // Sample local data for appointments
//   final List<Map<String, dynamic>> appointments = [
//     {
//       'date': DateTime.now().subtract(const Duration(days: 1)),
//       'time': '10:00 AM',
//     },
//     {
//       'date': DateTime.now(),
//       'time': '2:00 PM',
//     },
//     {
//       'date': DateTime.now().add(const Duration(days: 1)),
//       'time': '4:00 PM',
//     },
//   ];

//   ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Your Profile'),
//         iconTheme: const IconThemeData(color: Colors.white),
//         backgroundColor: const Color(0xFF001F5F),
//         foregroundColor: Colors.white,
//       ),
//       body: ListView.builder(
//         itemCount: appointments.length,
//         itemBuilder: (context, index) {
//           var appointment = appointments[index];
//           return ListTile(
//             title: Text('Appointment ${index + 1}'),
//             subtitle: Text(
//                 'Date: ${appointment['date'].toString().substring(0, 10)}, Time: ${appointment['time']}'),
//           );
//         },
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';

// class ProfileScreen extends StatelessWidget {
//   // Sample data for the barber's profile
//   final Map<String, dynamic> barberProfile = {
//     'name': 'John Doe',
//     'photoUrl': 'images/barber.png', // Replace with an actual image path or network URL
//     'bio': 'Experienced barber with over 10 years of experience. Specializes in modern and classic haircuts, shaves, and beard trims.',
//     'services': [
//       {'name': 'Haircut', 'price': '\$25'},
//       {'name': 'Beard Trim', 'price': '\$15'},
//       {'name': 'Shave', 'price': '\$20'},
//     ],
//     'reviews': [
//       {'customer': 'Alice', 'comment': 'Great service!', 'rating': 5},
//       {'customer': 'Bob', 'comment': 'Loved the haircut!', 'rating': 4},
//       {'customer': 'Charlie', 'comment': 'Very professional.', 'rating': 5},
//     ],
//   };

//   ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Barber Profile'),
//         iconTheme: const IconThemeData(color: Colors.white),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Navigator.of(context).pop(); // This pops the current screen off the navigation stack
//           },
//         ),
//         // backgroundColor: const Color(0xFF001F5F),
//         foregroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Barber photo
//             Center(
//               child: CircleAvatar(
//                 backgroundImage: AssetImage(barberProfile['photoUrl']),
//                 radius: 60.0,
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             // Barber name
//             Center(
//               child: Text(
//                 barberProfile['name'],
//                 style: const TextStyle(
//                   fontSize: 24.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8.0),
//             // Barber bio
//             Text(
//               barberProfile['bio'],
//               style: const TextStyle(fontSize: 16.0),
//             ),
//             const SizedBox(height: 16.0),
//             // Services offered
//             const Text(
//               'Services Offered:',
//               style: TextStyle(
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: barberProfile['services'].length,
//               itemBuilder: (context, index) {
//                 var service = barberProfile['services'][index];
//                 return ListTile(
//                   leading: const Icon(Icons.cut, color: Colors.teal),
//                   title: Text(service['name']),
//                   trailing: Text(service['price']),
//                 );
//               },
//             ),
//             const SizedBox(height: 16.0),
//             // Customer reviews
//             const Text(
//               'Customer Reviews:',
//               style: TextStyle(
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: barberProfile['reviews'].length,
//               itemBuilder: (context, index) {
//                 var review = barberProfile['reviews'][index];
//                 return ListTile(
//                   leading: const Icon(Icons.person, color: Colors.teal),
//                   title: Text(review['customer']),
//                   subtitle: Text(review['comment']),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: List.generate(
//                       review['rating'],
//                       (index) => const Icon(Icons.star, color: Colors.amber),
//                     ),
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

import 'package:barbersapp/screens/edit_barber_profile.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Sample data for the barber's profile
  Map<String, dynamic> barberProfile = {
    'name': 'John Doe',
    'photoUrl': 'images/barber.png', // Replace with an actual image path or network URL
    'bio': 'Experienced barber with over 10 years of experience. Specializes in modern and classic haircuts, shaves, and beard trims.',
    'services': [
      {'name': 'Haircut', 'price': '\$25'},
      {'name': 'Beard Trim', 'price': '\$15'},
      {'name': 'Shave', 'price': '\$20'},
    ],
    'reviews': [
      {'customer': 'Alice', 'comment': 'Great service!', 'rating': 5},
      {'customer': 'Bob', 'comment': 'Loved the haircut!', 'rating': 4},
      {'customer': 'Charlie', 'comment': 'Very professional.', 'rating': 5},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barber Profile'),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () async {
              final updatedProfile = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(barberProfile: barberProfile),
                ),
              );
              if (updatedProfile != null) {
                setState(() {
                  barberProfile = updatedProfile;
                });
              }
            },
          ),
        ],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Barber photo
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage(barberProfile['photoUrl']),
                radius: 60.0,
              ),
            ),
            const SizedBox(height: 16.0),
            // Barber name
            Center(
              child: Text(
                barberProfile['name'],
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            // Barber bio
            Text(
              barberProfile['bio'],
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            // Services offered
            const Text(
              'Services Offered:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: barberProfile['services'].length,
              itemBuilder: (context, index) {
                var service = barberProfile['services'][index];
                return ListTile(
                  leading: const Icon(Icons.cut, color: Colors.teal),
                  title: Text(service['name']),
                  trailing: Text(service['price']),
                );
              },
            ),
            const SizedBox(height: 16.0),
            // Customer reviews
            const Text(
              'Customer Reviews:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: barberProfile['reviews'].length,
              itemBuilder: (context, index) {
                var review = barberProfile['reviews'][index];
                return ListTile(
                  leading: const Icon(Icons.person, color: Colors.teal),
                  title: Text(review['customer']),
                  subtitle: Text(review['comment']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      review['rating'],
                      (index) => const Icon(Icons.star, color: Colors.amber),
                    ),
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




