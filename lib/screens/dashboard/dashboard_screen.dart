import 'package:flutter/material.dart';

import '/screens/add_medicine/add_medicine_screen.dart';
import '/screens/all_medicine/all_medicine_screen.dart';
import '/screens/settings/settings_screen.dart';
import '/screens/shelf/shelf_screen.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = '/dashboard_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/lina3.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.srcOver),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(16),
                child: Text(
                  'Dashboard',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    padding: EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: [
                      MyBigButton(
                        title: 'All Medicine',
                        routeName: AllMedicineScreen.routeName,
                        color: Colors.green.shade200,
                        icon: 'assets/icons/medicine.png',
                      ),
                      MyBigButton(
                        title: 'Add Medicine',
                        routeName: AddMedicineScreen.routeName,
                        color: Colors.amber.shade200,
                        icon: 'assets/icons/plus.png',
                      ),
                      MyBigButton(
                        title: 'Shelf List',
                        routeName: ShelfScreen.routeName,
                        color: Color(0xff64dfdf),
                        icon: 'assets/icons/shelf.png',
                      ),
                      MyBigButton(
                        title: 'App Settings',
                        routeName: SettingsScreen.routeName,
                        color: Color(0xffffcdb2),
                        icon: 'assets/icons/settings.png',
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyBigButton extends StatelessWidget {
  const MyBigButton(
      {required this.title,
      this.routeName,
      required this.color,
      required this.icon});

  final String title;
  final String? routeName;
  final Color color;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        Navigator.pushNamed(context, routeName!);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color,
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 72,
              width: double.infinity,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(icon),
                ),
              ),
            ),
            Text(
              title,
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  letterSpacing: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}
