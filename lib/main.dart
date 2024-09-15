// import 'package:barbersapp/screens/booking.dart';
// import 'package:barbersapp/screens/confirmation.dart';
// import 'package:barbersapp/screens/home.dart';
// import 'package:barbersapp/screens/login.dart';
// import 'package:barbersapp/screens/profile.dart';
// import 'package:barbersapp/screens/signup.dart';
import 'package:barbersapp/popupmenu/settings_page.dart';
import 'package:barbersapp/screens/appointment.dart';
import 'package:barbersapp/screens/available_services_booking.dart';
import 'package:barbersapp/screens/barbers_booking.dart';
import 'package:barbersapp/screens/barbers_profile.dart';
import 'package:barbersapp/screens/chatting_page.dart';
import 'package:barbersapp/screens/customer_booking_form.dart';
import 'package:barbersapp/screens/customers_profile.dart';
import 'package:barbersapp/screens/home.dart';
import 'package:barbersapp/screens/login.dart';
import 'package:barbersapp/screens/news_update.dart';
import 'package:barbersapp/screens/profile.dart';
import 'package:barbersapp/screens/signup.dart';
import 'package:barbersapp/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barber Booking App',
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context, AsyncSnapshot<User?> snapshot){
          if(snapshot.hasData && snapshot.data != null){
            return const LoginScreen();
          }else if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const HomeScreen();
        }
        ),
      // initialRoute: '/login',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/barbersbooking': (context) => const ConfirmBookingPage(),
        '/confirmation': (context) =>  AppointmentsPage(),
        '/profile': (context) => const ProfileScreen(),
        '/customersprofile': (context) => CustomerProfileScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/barbersprofile': (context) => const BarberProfilePage(barber: {},),
        '/customerbookingform': (context) => const ConfirmCustomerBookingPage(barber: {},),
        '/availableservicesbooking': (context) => const AvailableServicesBookingPage(),
        '/chatting': (context) => const ChatPage(),
        '/settings': (context) => const SettingsScreen(),
        '/newsupdate': (context) => const NewsScreen(),
      },
    );
  }
}
