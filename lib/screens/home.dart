import 'package:barbersapp/screens/appointment.dart';
import 'package:barbersapp/screens/chatting_page.dart';
import 'package:barbersapp/screens/news_update.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final PageController _pageController = PageController();

  final List<Widget> _pages = <Widget>[
    const HomeScreenContent(),
    AppointmentsPage(),
    const ChatPage(),
    const NewsScreen(),
  ];

  final List<String> _titles = [
    'Barbers Booking App',
    'Appointments',
    'Chat',
    'News',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // _pageController.jumpToPage(index);  // Use jumpToPage instead of animateToPage
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, '/login');
          });
          return const SizedBox.shrink();
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text(_titles[_selectedIndex]),
              actions: [
                PopupMenuButton<String>(
                  onSelected: (value) {
                    switch (value) {
                      case 'Appointments':
                        Navigator.pushNamed(context, '/confirmation');
                        break;
                      case 'Customer Profile':
                        Navigator.pushNamed(context, '/customersprofile');
                        break;
                      case 'Settings':
                        Navigator.pushNamed(context, '/settings');
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem<String>(
                        value: 'Appointments',
                        child: Text('Appointments'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Customer Profile',
                        child: Text('Customer Profile'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Settings',
                        child: Text('Settings'),
                      ),
                    ];
                  },
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
            body: _pages[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today),
                  label: 'Appointments',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat),
                  label: 'Chat',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.article),
                  label: 'News',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: const Color(0xFF001F5F),
              unselectedItemColor: Colors.grey[600],
              onTap: _onItemTapped,
            ),
          );
        }
      },
    );
  }
}

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenContentState createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search barbers...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(color: Color(0xFF001F5F), width: 2.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(color: Color(0xFF001F5F), width: 2.0),
                    ),
                  ),
                  onChanged: (value) {
                    // handle search query change
                  },
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                ),
                items: [
                  'images/banner1.png',
                  'images/banner2.png',
                  'images/banner3.png',
                  'images/banner4.jpg',
                  'images/banner5.jpg',
                  'images/banner6.jpg',
                  'images/banner7.jpg',
                ].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(i),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Available Barbers',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        SliverToBoxAdapter(
          child: SizedBox(
            height: 220.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5, // Number of barbers
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/customerbookingform');
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 8.0),
                        child: Container(
                          width: 100.0, // Adjust the width of the box
                          height: 100.0, // Adjust the height of the box
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle, // For circular images
                            image: DecorationImage(
                              image: AssetImage('images/barber.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                          height: 3.0), // Space between the card and text
                      const Text(
                        'Barber Name',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 1.0),
                      const Text(
                        'Service',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      const SizedBox(height: 1.0),
                      const Text(
                        'Rating: 4.5',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),

        // SliverToBoxAdapter(
        //   child: SizedBox(
        //     height: 220.0,
        //     child: ListView.builder(
        //       scrollDirection: Axis.horizontal,
        //       itemCount: 5, // Number of barbers
        //       itemBuilder: (context, index) {

        //         return GestureDetector(
        //   onTap: () {
        //     Navigator.pushNamed(context, '/customerbookingform');
        //   },
        //   child: Card(
        //     margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        //     child: Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           Container(
        //             width: 80.0, // Adjust the width of the box
        //             height: 80.0, // Adjust the height of the box
        //             decoration: const BoxDecoration(
        //               shape: BoxShape.circle, // For circular images
        //               image: DecorationImage(
        //                 image: AssetImage('images/barber.png'),
        //                 fit: BoxFit.cover,
        //               ),
        //             ),
        //           ),
        //           const SizedBox(height: 8.0),
        //           const Text(
        //             'Barber Name',
        //             style: TextStyle(
        //               fontSize: 16.0,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //           const SizedBox(height: 5.0),
        //           const Text(
        //             'Service',
        //             style: TextStyle(fontSize: 14.0),
        //           ),
        //           const SizedBox(height: 5.0),
        //           const Text(
        //             'Rating: 4.5',
        //             style: TextStyle(fontSize: 14.0),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // );

        //         // return GestureDetector(
        //         //   onTap: () {
        //         //     Navigator.pushNamed(context, '/customerbookingform');
        //         //   },
        //         //   child: const Card(
        //         //     margin:
        //         //         EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        //         //     child: Padding(
        //         //       padding: EdgeInsets.all(16.0),
        //         //       child: Column(
        //         //         children: [
        //         //           CircleAvatar(
        //         //             backgroundImage: AssetImage('images/barber.png'),
        //         //             radius: 40.0,
        //         //           ),
        //         //           SizedBox(height: 10.0),
        //         //           Text(
        //         //             'Barber Name',
        //         //             style: TextStyle(
        //         //               fontSize: 16.0,
        //         //               fontWeight: FontWeight.bold,
        //         //             ),
        //         //           ),
        //         //           SizedBox(height: 5.0),
        //         //           Text(
        //         //             'Service',
        //         //             style: TextStyle(fontSize: 14.0),
        //         //           ),
        //         //           SizedBox(height: 5.0),
        //         //           Text(
        //         //             'Rating: 4.5',
        //         //             style: TextStyle(fontSize: 14.0),
        //         //           ),
        //         //         ],
        //         //       ),
        //         //     ),
        //         //   ),
        //         // );
        //       },
        //     ),
        //   ),
        // ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Available Services',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildServiceCard(context, 'Haircut', 'Get a fresh new look.',
                  '\$25', Icons.cut),
              _buildServiceCard(context, 'Beard Trim', 'Keep your beard neat.',
                  '\$15', Icons.brush),
              _buildServiceCard(
                  context, 'Shave', 'Classic razor shave.', '\$20', Icons.face),
              _buildServiceCard(context, 'Dye',
                  'Enhance your style with vibrant color.', '\$25', Icons.cut),
              _buildServiceCard(
                  context,
                  'Facial',
                  'Refresh your skin with a soothing facial',
                  '\$25',
                  Icons.cut),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCard(BuildContext context, String title, String subtitle,
      String price, IconData icon) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/availableservicesbooking');
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: Icon(icon, color: const Color(0xFF001F5F)),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: Text(
            price,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}



// import 'dart:developer' as developer;

// import 'package:barbersapp/screens/appointment.dart';
// import 'package:barbersapp/screens/chatting_page.dart';
// import 'package:barbersapp/screens/profile.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;

//   final PageController _pageController = PageController();

//   // Define the pages for each tab
//   final List<Widget> _pages = <Widget>[
//     const HomeScreenContent(),
//     AppointmentsPage(),
//     const ChatPage(),
//     ProfileScreen(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     // _pageController.jumpToPage(index);
//   }

//   // @override
//   // void dispose() {
//   //   _pageController.dispose();
//   //   super.dispose();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (!snapshot.hasData) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             Navigator.pushReplacementNamed(context, '/login');
//           });
//           return const SizedBox.shrink();
//         } else {
//           return Scaffold(
//             appBar: AppBar(
//               // foregroundColor: Colors.white,
//               title: const Text('Barbers Booking App',
//                   style: TextStyle(color: Colors.white)),
//               // centerTitle: true,
//               // backgroundColor: const Color(0xFF001F5F),
//               actions: [
//                 PopupMenuButton<String>(
//                   onSelected: (value) {
//                     switch (value) {
//                       case 'Appointments':
//                         Navigator.pushNamed(context, '/confirmation');
//                         break;
//                       case 'Settings':
//                         Navigator.pushNamed(context, '/settings');
//                         break;
//                       case 'Help':
//                         Navigator.pushNamed(context, '/help');
//                         break;
//                       case 'Logout':
//                         Navigator.pushNamed(context, '/logout');
//                         break;
//                     }
//                   },
//                   itemBuilder: (BuildContext context) {
//                     return [
//                       const PopupMenuItem<String>(
//                         value: 'Appointments',
//                         child: Text('Appointments'),
//                       ),
//                       const PopupMenuItem<String>(
//                         value: 'Settings',
//                         child: Text('Settings'),
//                       ),
//                     ];
//                   },
//                   icon: const Icon(Icons.more_vert),
//                 ),
//               ],
//             ),
//             // backgroundColor: const Color(0xFF001F5F),
//             body: PageView(
//               controller: _pageController,
//               onPageChanged: (index) {
//                 setState(() {
//                   _selectedIndex = index;
//                   developer.log(
//                     'Tab tapped: $_selectedIndex',
//                     name: 'com.example.app',
//                     level: 0, // Default level, can be customized
//                   );
//                 });
//               },
//               children: _pages,
//             ),
//             // _pages[_selectedIndex],

//             bottomNavigationBar: BottomNavigationBar(
//               items: const <BottomNavigationBarItem>[
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.home),
//                   label: 'Home',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.calendar_today),
//                   label: 'Appointments',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.chat),
//                   label: 'Chat',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.person),
//                   label: 'Profile',
//                 ),
//               ],
//               currentIndex: _selectedIndex,
//               selectedItemColor: Colors.teal,
//               unselectedItemColor: Colors.grey,
//               onTap: _onItemTapped,
//             ),
//           );
//         }
//       },
//     );
//   }
// }

// class HomeScreenContent extends StatefulWidget {
//   const HomeScreenContent({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _HomeScreenContentState createState() => _HomeScreenContentState();
// }

// class _HomeScreenContentState extends State<HomeScreenContent>
//     with AutomaticKeepAliveClientMixin {
//   @override
//   Widget build(BuildContext context) {
//     super.build(context); // Required for AutomaticKeepAliveClientMixin
//     return CustomScrollView(
//       slivers: [
//         SliverToBoxAdapter(
//           child: Column(
//             children: [
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Search barbers...',
//                     prefixIcon: const Icon(Icons.search),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     enabledBorder: const OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       borderSide: BorderSide(color: Colors.teal, width: 2.0),
//                     ),
//                     focusedBorder: const OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       borderSide: BorderSide(color: Colors.teal, width: 2.0),
//                     ),
//                   ),
//                   onChanged: (value) {
//                     // handle search query change
//                   },
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'Available Barbers',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SliverToBoxAdapter(
//           child: SizedBox(
//             height: 220.0,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: 5, // Number of barbers
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.pushNamed(context, '/customerbookingform');
//                   },
//                   child: const Card(
//                     margin:
//                         EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
//                     child: Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: Column(
//                         children: [
//                           CircleAvatar(
//                             backgroundImage: AssetImage('images/barber.png'),
//                             radius: 40.0,
//                           ),
//                           SizedBox(height: 10.0),
//                           Text(
//                             'Barber Name',
//                             style: TextStyle(
//                               fontSize: 16.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(height: 5.0),
//                           Text(
//                             'Service',
//                             style: TextStyle(fontSize: 14.0),
//                           ),
//                           SizedBox(height: 5.0),
//                           Text(
//                             'Rating: 4.5',
//                             style: TextStyle(fontSize: 14.0),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//         SliverToBoxAdapter(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text(
//                   'Available Services',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               _buildServiceCard(context, 'Haircut', 'Get a fresh new look.',
//                   '\$25', Icons.cut),
//               _buildServiceCard(context, 'Beard Trim', 'Keep your beard neat.',
//                   '\$15', Icons.brush),
//               _buildServiceCard(
//                   context, 'Shave', 'Classic razor shave.', '\$20', Icons.face),
//               _buildServiceCard(context, 'Dye',
//                   'Enhance your style with vibrant color.', '\$25', Icons.cut),
//               _buildServiceCard(
//                   context,
//                   'Facial',
//                   'Refresh your skin with a soothing facial',
//                   '\$25',
//                   Icons.cut),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildServiceCard(BuildContext context, String title, String subtitle,
//       String price, IconData icon) {
//     return InkWell(
//       onTap: () {
//         Navigator.pushNamed(context, '/availableservicesbooking');
//       },
//       child: Card(
//         margin: const EdgeInsets.symmetric(vertical: 8),
//         child: ListTile(
//           leading: Icon(icon, color: Colors.teal),
//           title: Text(title),
//           subtitle: Text(subtitle),
//           trailing: Text(
//             price,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   bool get wantKeepAlive => true;
// }






// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final List<Map<String, String>> barbers = [
//     {
//       'name': 'Barber 1',
//       'service': 'Service 1',
//       'image': 'images/barber.png',
//       'rating': '4.5'
//     },
//     {
//       'name': 'Barber 2',
//       'service': 'Service 2',
//       'image': 'images/barber 1.png',
//       'rating': '4.0'
//     },
//     {
//       'name': 'Barber 3',
//       'service': 'Service 3',
//       'image': 'images/barber 2.png',
//       'rating': '4.8'
//     },
//     {
//       'name': 'Barber 4',
//       'service': 'Service 4',
//       'image': 'images/barber 3.png',
//       'rating': '3.9'
//     },
//     {
//       'name': 'Barber 5',
//       'service': 'Service 5',
//       'image': 'images/barber.png',
//       'rating': '4.2'
//     },
//     {
//       'name': 'Barber 6',
//       'service': 'Service 6',
//       'image': 'images/barber.png',
//       'rating': '4.7'
//     },
//     {
//       'name': 'Barber 7',
//       'service': 'Service 7',
//       'image': 'images/barber.png',
//       'rating': '4.1'
//     },
//     {
//       'name': 'Barber 8',
//       'service': 'Service 8',
//       'image': 'images/barber.png',
//       'rating': '4.3'
//     },
//   ];

//   String searchQuery = '';
//   String selectedLocation = 'All';
//   String selectedRating = 'All';
//   String selectedPriceRange = 'All';

//   int _selectedIndex = 0;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });

//     switch (index) {
//       case 0:
//         Navigator.pushNamed(context, '/home');
//         break;
//       case 1:
//         Navigator.pushNamed(context, '/confirmation');
//         break;
//       case 2:
//         Navigator.pushNamed(context, '/chatting');
//         break;
//       case 3:
//         Navigator.pushNamed(context, '/profile');
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (!snapshot.hasData) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             Navigator.pushReplacementNamed(context, '/login');
//           });
//           return const SizedBox.shrink();
//         } else {
//           return Scaffold(
//             appBar: AppBar(
//               foregroundColor: Colors.white,
//               leading: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.pushNamed(context, '/profile');
//                   },
//                   child: const Icon(Icons.person),
//                 ),
//               ),
//               title: const Text('Barbers Booking App',
//                   style: TextStyle(color: Colors.white)),
//               centerTitle: true,
//               backgroundColor: Colors.teal,
//               actions: [
//                 IconButton(
//                   onPressed: () {
//                     Navigator.pushNamed(context, '/confirmation');
//                   },
//                   icon: const Icon(Icons.book),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.logout),
//                   onPressed: () async {
//                     await FirebaseAuth.instance.signOut();
//                   },
//                 ),
//               ],
//             ),
//             body: CustomScrollView(
//               slivers: [
//                 SliverToBoxAdapter(
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: TextField(
//                           decoration: InputDecoration(
//                             hintText: 'Search barbers...',
//                             prefixIcon: const Icon(Icons.search),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             enabledBorder: const OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(10.0)),
//                               borderSide: BorderSide(
//                                   color: Color(0xFF001F5F), width: 1.0),
//                             ),
//                             focusedBorder: const OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(10.0)),
//                               borderSide: BorderSide(
//                                   color: Color(0xFF001F5F), width: 1.0),
//                             ),
//                           ),
//                           onChanged: (value) {
//                             setState(() {
//                               searchQuery = value.toLowerCase();
//                             });
//                           },
//                         ),
//                       ),
//                        Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: DropdownButtonFormField<String>(
//                                 value: selectedLocation,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     selectedLocation = value!;
//                                   });
//                                 },
//                                 items: [
//                                   'All',
//                                   'London',
//                                   'USA',
//                                   'Ghana',
//                                   'Autralia',
//                                   'UAE',
//                                   'China',
//                                   'India',
//                                   'Egypt',
//                                   'Japan',
//                                   'S.A',
//                                 ].map<DropdownMenuItem<String>>((String value) {
//                                   return DropdownMenuItem<String>(
//                                     value: value,
//                                     child: Text(value),
//                                   );
//                                 }).toList(),
//                                 decoration: const InputDecoration(
//                                   labelText: 'Location',
//                                   border: OutlineInputBorder(),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 8.0),
//                             Expanded(
//                               child: DropdownButtonFormField<String>(
//                                 value: selectedRating,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     selectedRating = value!;
//                                   });
//                                 },
//                                 items: [
//                                   'All',
//                                   '4.5+',
//                                   '4.0+',
//                                   '3.5+'
//                                 ].map<DropdownMenuItem<String>>((String value) {
//                                   return DropdownMenuItem<String>(
//                                     value: value,
//                                     child: Text(value),
//                                   );
//                                 }).toList(),
//                                 decoration: const InputDecoration(
//                                   labelText: 'Rating',
//                                   border: OutlineInputBorder(),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 8.0),
//                             Expanded(
//                               child: DropdownButtonFormField<String>(
//                                 value: selectedPriceRange,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     selectedPriceRange = value!;
//                                   });
//                                 },
//                                 items: [
//                                   'All',
//                                   '\$10',
//                                   '\$15',
//                                   '\$20',
//                                   '\$25',
//                                   '\$30',
//                                   '\$35',
//                                   '\$40',
//                                 ].map<DropdownMenuItem<String>>((String value) {
//                                   return DropdownMenuItem<String>(
//                                     value: value,
//                                     child: Text(value),
//                                   );
//                                 }).toList(),
//                                 decoration: const InputDecoration(
//                                   labelText: 'Price Range',
//                                   border: OutlineInputBorder(),
//                                 ),
//                               ),
//                             ),
//                             // Your dropdowns for location, rating, and price range
//                           ],
//                         ),
//                       ),
//                       const Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             'Available Barbers',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SliverToBoxAdapter(
//                   child: SizedBox(
//                     height: 220.0,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: barbers.length,
//                       itemBuilder: (context, index) {
//                         var barber = barbers[index];
//                         if (searchQuery.isNotEmpty &&
//                             !barber['name']!
//                                 .toLowerCase()
//                                 .contains(searchQuery)) {
//                           return const SizedBox.shrink();
//                         }
//                         if (selectedRating != 'All' &&
//                             double.parse(barber['rating']!) <
//                                 double.parse(selectedRating)) {
//                           return const SizedBox.shrink();
//                         }
//                         // Your filtering logic
//                         return GestureDetector(
//                           onTap: () {
//                             Navigator.pushNamed(
//                                 context, '/customerbookingform');
//                           },
//                           child: Card(
//                             margin: const EdgeInsets.symmetric(
//                                 vertical: 8.0, horizontal: 8.0),
//                             child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Column(
//                                 children: [
//                                   CircleAvatar(
//                                     backgroundImage:
//                                         AssetImage(barber['image']!),
//                                     radius: 40.0,
//                                   ),
//                                   const SizedBox(height: 10.0),
//                                   Text(
//                                     barber['name']!,
//                                     style: const TextStyle(
//                                       fontSize: 16.0,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 5.0),
//                                   Text(
//                                     barber['service']!,
//                                     style: const TextStyle(fontSize: 14.0),
//                                   ),
//                                   const SizedBox(height: 5.0),
//                                   Text(
//                                     'Rating: ${barber['rating']}',
//                                     style: const TextStyle(fontSize: 14.0),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 SliverToBoxAdapter(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Text(
//                           'Available Services',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       _buildServiceCard(context, 'Haircut',
//                           'Get a fresh new look.', '\$25', Icons.cut),
//                       _buildServiceCard(context, 'Beard Trim',
//                           'Keep your beard neat.', '\$15', Icons.brush),
//                       _buildServiceCard(context, 'Shave',
//                           'Classic razor shave.', '\$20', Icons.face),
//                       _buildServiceCard(
//                           context,
//                           'Hair Dye',
//                           'Enhance your style with vibrant color.',
//                           '\$40',
//                           Icons.color_lens),
//                       _buildServiceCard(
//                           context,
//                           'Facial',
//                           'Refresh your skin with a soothing facial',
//                           '\$40',
//                           Icons.color_lens),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             bottomNavigationBar: BottomNavigationBar(
//               type: BottomNavigationBarType.fixed,
//               selectedItemColor: Colors.teal,
//               unselectedItemColor: Colors.grey,
//               backgroundColor: Colors.white,
//               currentIndex: _selectedIndex,
//               onTap: _onItemTapped,
//               items: const <BottomNavigationBarItem>[
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.home),
//                   label: 'Home',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.book),
//                   label: 'Appointments',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.chat),
//                   label: 'Chat',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.person),
//                   label: 'Profile',
//                 ),
//               ],
//             ),
//           );
//         }
//       },
//     );
//   }

//   Widget _buildServiceCard(BuildContext context, String title, String subtitle,
//       String price, IconData icon) {
//     return InkWell(
//       onTap: () {
//         Navigator.pushNamed(context, '/availableservicesbooking');
//       },
//       child: Card(
//         margin: const EdgeInsets.symmetric(vertical: 8),
//         child: ListTile(
//           leading: Icon(icon, color: Colors.teal),
//           title: Text(title),
//           subtitle: Text(subtitle),
//           trailing: Text(
//             price,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// SLIDEABLE TABS

// import 'package:barbersapp/screens/appointment.dart';
// import 'package:barbersapp/screens/chatting_page.dart';
// import 'package:barbersapp/screens/profile.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   final List<Widget> _tabs = const <Widget>[
//     Tab(icon: Icon(Icons.home), text: 'Home'),
//     Tab(icon: Icon(Icons.calendar_today), text: 'Appointments'),
//     Tab(icon: Icon(Icons.chat), text: 'Chat'),
//     Tab(icon: Icon(Icons.person), text: 'Profile'),
//   ];

//   final List<Widget> _pages = <Widget>[
//     HomeScreenContent(),
//     AppointmentsPage(),
//     ChatPage(),
//     ProfileScreen(),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: _tabs.length, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (!snapshot.hasData) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             Navigator.pushReplacementNamed(context, '/login');
//           });
//           return const SizedBox.shrink();
//         } else {
//           return Scaffold(
//             appBar: AppBar(
//               title: const Text('Barbers Booking App', style: TextStyle(color: Colors.white)),
//               centerTitle: true,
//               backgroundColor: Colors.teal,
//               actions: [
//                 PopupMenuButton<String>(
//                   onSelected: (value) {
//                     switch (value) {
//                       case 'Appointments':
//                         Navigator.pushNamed(context, '/confirmation');
//                         break;
//                       case 'Settings':
//                         Navigator.pushNamed(context, '/settings');
//                         break;
//                       case 'Help':
//                         Navigator.pushNamed(context, '/help');
//                         break;
//                       case 'Logout':
//                         Navigator.pushNamed(context, '/logout');
//                         break;
//                     }
//                   },
//                   itemBuilder: (BuildContext context) {
//                     return [
//                       const PopupMenuItem<String>(
//                         value: 'Appointments',
//                         child: Text('Appointments'),
//                       ),
//                       const PopupMenuItem<String>(
//                         value: 'Settings',
//                         child: Text('Settings'),
//                       ),
//                     ];
//                   },
//                   icon: const Icon(Icons.more_vert),
//                 ),
//               ],
//               bottom: TabBar(
//                 controller: _tabController,
//                 tabs: _tabs,
//                 labelColor: Colors.white,
//                 unselectedLabelColor: Colors.grey,
//                 indicatorColor: Colors.white,
//               ),
//             ),
//             body: TabBarView(
//               controller: _tabController,
//               children: _pages,
//             ),
//           );
//         }
//       },
//     );
//   }
// }

// class HomeScreenContent extends StatefulWidget {
//   const HomeScreenContent({super.key});

//   @override
//   _HomeScreenContentState createState() => _HomeScreenContentState();
// }

// class _HomeScreenContentState extends State<HomeScreenContent> with AutomaticKeepAliveClientMixin {
//   @override
//   Widget build(BuildContext context) {
//     super.build(context); // Required for AutomaticKeepAliveClientMixin
//     return CustomScrollView(
//       slivers: [
//         SliverToBoxAdapter(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Search barbers...',
//                     prefixIcon: const Icon(Icons.search),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30.0),
//                     ),
//                     enabledBorder: const OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(30.0)),
//                       borderSide: BorderSide(color: Colors.teal, width: 2.0),
//                     ),
//                     focusedBorder: const OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(30.0)),
//                       borderSide: BorderSide(color: Colors.teal, width: 2.0),
//                     ),
//                   ),
//                   onChanged: (value) {
//                     // handle search query change
//                   },
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'Available Barbers',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SliverToBoxAdapter(
//           child: SizedBox(
//             height: 220.0,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: 5, // Number of barbers
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.pushNamed(context, '/customerbookingform');
//                   },
//                   child: const Card(
//                     margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
//                     child: Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: Column(
//                         children: [
//                           CircleAvatar(
//                             backgroundImage: AssetImage('images/barber.png'),
//                             radius: 40.0,
//                           ),
//                           SizedBox(height: 10.0),
//                           Text(
//                             'Barber Name',
//                             style: TextStyle(
//                               fontSize: 16.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(height: 5.0),
//                           Text(
//                             'Service',
//                             style: TextStyle(fontSize: 14.0),
//                           ),
//                           SizedBox(height: 5.0),
//                           Text(
//                             'Rating: 4.5',
//                             style: TextStyle(fontSize: 14.0),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//         SliverToBoxAdapter(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text(
//                   'Available Services',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               _buildServiceCard(context, 'Haircut', 'Get a fresh new look.', '\$25', Icons.cut),
//               _buildServiceCard(context, 'Beard Trim', 'Keep your beard neat.', '\$15', Icons.brush),
//               _buildServiceCard(context, 'Shave', 'Classic razor shave.', '\$20', Icons.face),
//               _buildServiceCard(context, 'Dye', 'Enhance your style with vibrant color.', '\$25', Icons.cut),
//               _buildServiceCard(context, 'Facial', 'Refresh your skin with a soothing facial', '\$25', Icons.cut),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildServiceCard(BuildContext context, String title, String subtitle, String price, IconData icon) {
//     return InkWell(
//       onTap: () {
//         Navigator.pushNamed(context, '/availableservicesbooking');
//       },
//       child: Card(
//         margin: const EdgeInsets.symmetric(vertical: 8),
//         child: ListTile(
//           leading: Icon(icon, color: Colors.teal),
//           title: Text(title),
//           subtitle: Text(subtitle),
//           trailing: Text(
//             price,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   bool get wantKeepAlive => true;
// }
