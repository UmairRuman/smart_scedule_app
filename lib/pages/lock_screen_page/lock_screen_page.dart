// import 'package:flutter/material.dart';

// class AppLockPage extends StatefulWidget {
//   const AppLockPage({Key? key}) : super(key: key);

//   @override
//   State<AppLockPage> createState() => _AppLockPageState();
// }

// class _AppLockPageState extends State<AppLockPage> {
//   final String _adminKey = "123456"; // Predefined admin key

//   Future<bool> _showUnlockDialog() async {
//     String enteredKey = '';
//     bool isUnlocked = false;

//     await showDialog(
//       context: context,
//       barrierDismissible: false, // Prevent closing dialog without action
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Enter Admin Key"),
//           content: TextField(
//             obscureText: true,
//             decoration: const InputDecoration(labelText: "Admin Key"),
//             onChanged: (value) {
//               enteredKey = value;
//             },
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 if (enteredKey == _adminKey) {
//                   isUnlocked = true;
//                   Navigator.of(context).pop();
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text("Invalid Admin Key!")),
//                   );
//                 }
//               },
//               child: const Text("Unlock"),
//             ),
//           ],
//         );
//       },
//     );

//     return isUnlocked;
//   }

//   Future<void> _preventExit() async {
//     const intent = AndroidIntent(
//       action: 'android.intent.action.MAIN',
//       category: 'android.intent.category.HOME',
//     );

//     await intent
//         .launch(); // Redirect user to the home screen to prevent app close
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         // Intercept back button press
//         bool isUnlocked = await _showUnlockDialog();
//         return isUnlocked; // Allow exit if unlocked
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("App Lock Example"),
//           automaticallyImplyLeading: false, // Disable default back button
//         ),
//         body: Center(
//           child: ElevatedButton(
//             onPressed: () async {
//               // Trigger when user tries to minimize
//               bool isUnlocked = await _showUnlockDialog();
//               if (!isUnlocked) {
//                 _preventExit(); // Redirect to home or prevent app closure
//               }
//             },
//             child: const Text("Minimize App"),
//           ),
//         ),
//       ),
//     );
//   }
// }
