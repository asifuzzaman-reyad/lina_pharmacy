import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/screens/add_medicine/add_medicine_screen.dart';
import '/screens/all_medicine/all_medicine_screen.dart';
import '/screens/dashboard/dashboard_screen.dart';
import '/screens/search/search_screen.dart';
import '/screens/settings/settings_screen.dart';
import '/screens/shelf/shelf_details_screen.dart';
import '/screens/shelf/shelf_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lina Pharmacy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      routes: {
        SearchScreen.routeName: (context) => SearchScreen(),
        DashboardScreen.routeName: (context) => DashboardScreen(),
        AllMedicineScreen.routeName: (context) => AllMedicineScreen(),
        AddMedicineScreen.routeName: (context) => AddMedicineScreen(),
        ShelfScreen.routeName: (context) => ShelfScreen(),
        ShelfDetailsScreen.routeName: (context) => ShelfDetailsScreen(),
        SettingsScreen.routeName: (context) => SettingsScreen(),
      },
      initialRoute: SearchScreen.routeName,
    );
  }
}
