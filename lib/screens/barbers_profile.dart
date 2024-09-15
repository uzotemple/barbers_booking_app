import 'package:flutter/material.dart';

class BarberProfilePage extends StatelessWidget {
  final Map<String, dynamic> barber;

  const BarberProfilePage({required this.barber, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          barber['name'] ?? 'Barber Profile',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF001F5F),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage(barber['image'] ?? 'No Name',),
                radius: 50.0,
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: Text(
                barber['name'] ?? 'No Name',
                style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Services Offered',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            ...barber['services']?.map<Widget>((service) {
              return ListTile(
                title: Text(service['name'] ?? 'No Service Name'),
                trailing: Text('\$${service['price'] ?? 0}'),
                // Text('\$${service['price']}'),
              );
            }).toList() ?? [const Text('No services available')],
            const SizedBox(height: 20.0),
            const Text(
              'Availability Calendar',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            CalendarDatePicker(
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2101),
              onDateChanged: (date) {},
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Ratings and Reviews',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            ...barber['reviews']?.map<Widget>((review) {
              return ListTile(
                title: Text(review['reviewer'] ?? 'Anonymous'),
                subtitle: Text(review['comment'] ?? 'No Comment'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(5, (index) {
                    return Icon(
                      index < review['rating'] ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                    );
                  }),
                ),
              );
            }).toList() ?? [const Text('No reviews available')],
          ],
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> barbers = [
  {
    'name': 'Barber 1',
    'service': 'Service 1',
    'image': 'images/barber.png',
    'services': [
      {'name': 'Haircut', 'price': 20},
      {'name': 'Beard Trim', 'price': 15},
    ],
    'reviews': [
      {'reviewer': 'Alice', 'comment': 'Great service!', 'rating': 5},
      {'reviewer': 'Bob', 'comment': 'Good haircut', 'rating': 4},
    ],
  },
  // Add more barbers here, ensuring each has all fields populated
];
