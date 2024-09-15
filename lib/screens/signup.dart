// // import 'package:barbers_booking_app/screens/home_screen.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';


// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});


//   @override
//   // ignore: library_private_types_in_public_api
//   _SignupScreenState createState() => _SignupScreenState();
// }


// class _SignupScreenState extends State<SignupScreen> {
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();


//   // void _signup() {
//   //   // Implement signup logic here
//   //   Navigator.pushReplacementNamed(context, '/login');
//   // }


//   // void _navigateToLogin() {
//   //   Navigator.pushNamed(context, '/login');
//   // }


//   final _formkey= GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formkey,
//             child: Column(
//               // mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // Image.asset(
//                 //   'images/login.jpg',
//                 //   fit: BoxFit.cover,
//                 //   width: double.infinity,
//                 // ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const Text(
//                   'Create Account',
//                   style: TextStyle(
//                     fontSize: 25,
//                     color: Color(0xFF001F5F),
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 TextFormField(
//                   validator:(value) {
//                     if(value==null||value.isEmpty){
//                       return "Please Enter Name";
//                     }
//                     return null;
//                   },
//                   controller: _nameController,
//                   decoration: const InputDecoration(
//                     labelText: 'Name',
//                     filled: true,
//                     fillColor: Color(0xFFEDEDF0),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                       borderSide: BorderSide(color: Colors.blue, width: 1.0),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                       borderSide: BorderSide(color: Colors.blue, width: 2.0),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   validator:(value) {
//                     if(value==null||value.isEmpty){
//                       return "Please Enter Email";
//                     }
//                     return null;
//                   },
//                   controller: _emailController,
//                   decoration: const InputDecoration(labelText: 'Email',
//                   filled: true,
//                     fillColor: Color(0xFFEDEDF0),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                       borderSide: BorderSide(color: Colors.blue, width: 1.0),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                       borderSide: BorderSide(color: Colors.blue, width: 2.0),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   validator:(value) {
//                     if(value==null||value.isEmpty){
//                       return "Please Enter Password";
//                     }
//                     return null;
//                   },
//                   controller: _passwordController,
//                   decoration: const InputDecoration(labelText: 'Password',
//                   filled: true,
//                     fillColor: Color(0xFFEDEDF0),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                       borderSide: BorderSide(color: Colors.blue, width: 1.0),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                       borderSide: BorderSide(color: Colors.blue, width: 2.0),
//                     ),
//                   ),
//                   obscureText: true,
//                 ),
//                 const SizedBox(height: 10),
               
//                 ElevatedButton(
//                   onPressed: (){},
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF001F5F),
//                     foregroundColor: Colors.white,
//                   ),
//                   child: const Text('Sign Up'),
//                 ),
//                 TextButton(
//                   onPressed: (){},
//                   child: const Text(
//                     'Already have an account? Login',
//                     style: TextStyle(
//                       color: Color(0xFF001F5F),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to sign up: $e')),
          );
        }
      }
    }
  }

  void _navigateToLogin() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset("images/login.jpg"),
                const SizedBox(height: 15),
                const Text(
                  'Enter your details to create account',
                  style: TextStyle(
                    fontSize: 15,
                    // color: Color(0xFF001F5F),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Name";
                    }
                    return null;
                  },
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    filled: true,
                    // fillColor: Color(0xFFF0F0FF),
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
                ),
                const SizedBox(height: 10),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Email";
                    }
                    return null;
                  },
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    // fillColor: Color(0xFFF0F0FF),
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
                ),
                const SizedBox(height: 10),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Password";
                    }
                    return null;
                  },
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    // fillColor: Color(0xFFF0F0FF),
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
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _signup,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF001F5F),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Sign Up'),
                ),
                TextButton(
                  onPressed: _navigateToLogin,
                  child: const Text(
                    'Already have an account? Login',
                    // style: TextStyle(
                    //   color: Color(0xFF001F5F),
                    // ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

