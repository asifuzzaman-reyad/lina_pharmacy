import 'package:flutter/material.dart';
import 'package:lina_pharmacy/screens/shelf/shelf_details_screen.dart';
import 'package:lina_pharmacy/widgets/color_changer.dart';

import '../../widgets/upload_medicine_dialog.dart';

class ShelfScreen extends StatelessWidget {
  static const routeName = '/shelf_screen';

  final List _shelfInSerial = [
    'A1',
    'A2',
    'A3',
    'A4',
    'B1',
    'B2',
    'B3',
    'B4',
    'B5',
    'C1',
    'C2',
    'C3',
    'C4',
    'C5',
    'D1',
    'D2',
    'D3',
    'D4',
    'D5',
    'E1',
    'E2',
    'E3',
    'E4',
    'E5',
    'F1',
    'F2',
    'F3',
    'F4',
    'F5',
    'G1',
    'G2',
    'G3',
    'G4',
    'G5',
    'H1',
    'H2',
    'H3',
    'H4',
    'H5',
    'I1',
    'I2',
    'I3',
    'I4',
    'I5',
    'J1',
    'J2',
    'J3',
    'J4',
    'J5',
    'K1',
    'K2',
    'K3',
    'K4',
    'K5',
    'L1',
    'L2',
    'L3',
    'L4',
    'L5',
    'M1',
    'M2',
    'M3',
    'M4',
    'M5',
    'N1',
    'N2',
    'N3',
    'O1',
    'O2',
    'P1',
    'P2',
    'Q1',
    'Q2',
    'X1',
    'X2',
    'X3',
    'Z1',
    'Z2',
    'Z3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shelf'),
        titleSpacing: 0,
      ),
      body: Scrollbar(
        isAlwaysShown: false,
        thickness: 8,
        radius: Radius.circular(8),
        child: GridView.count(
          crossAxisCount: 4,
          padding: EdgeInsets.all(12),
          // mainAxisSpacing: 8,
          // crossAxisSpacing: 8,
          children: _shelfInSerial.map((selfName) {
            return Card(
              color: colorChanger(selfName),
              child: InkWell(
                radius: 8,
                onTap: () {
                  print(selfName);
                  Navigator.pushNamed(context, ShelfDetailsScreen.routeName,
                      arguments: selfName);
                },
                child: Center(
                    child: Text(
                  selfName,
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                )),
              ),
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //
          showDialog(
              context: context,
              builder: (context) {
                return UploadMedicineDialog(shelfName: '');
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
