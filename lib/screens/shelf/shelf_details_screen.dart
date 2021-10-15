import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lina_pharmacy/widgets/product_card_1.dart';

import '../../widgets/upload_medicine_dialog.dart';

class ShelfDetailsScreen extends StatefulWidget {
  static const routeName = 'shelf_details_screen';

  @override
  _ShelfDetailsScreenState createState() => _ShelfDetailsScreenState();
}

class _ShelfDetailsScreenState extends State<ShelfDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          title: Text.rich(
            TextSpan(text: 'Shelf: ', children: [
              TextSpan(
                  text: args,
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  )),
            ]),
          ),
          actions: [
            Row(
              children: [
                Text('Total :'),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('lina-pharmacy')
                        .where('shelf', isEqualTo: args.toString())
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          width: 64,
                          child: CupertinoActivityIndicator(),
                        );
                      }

                      String counter = snapshot.data!.size.toString();
                      print(counter);
                      //
                      return Container(
                        width: 64,
                        alignment: Alignment.center,
                        child: Text(
                          counter,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      );
                    }),
              ],
            ),
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('lina-pharmacy')
              .where('shelf', isEqualTo: args.toString())
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return snapshot.data!.docs.isEmpty
                ? Center(
                    child: Text(
                    'No Medicine Found !',
                    style: TextStyle(fontSize: 20),
                  ))
                : ListView(
                    padding: EdgeInsets.only(top: 8),
                    children: snapshot.data!.docs.map((document) {
                      return ProductCard1(
                        document: document,
                        editable: true,
                      );
                    }).toList(),
                  );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //
            showDialog(
                context: context,
                builder: (context) {
                  return UploadMedicineDialog(shelfName: args);
                });
          },
          child: Icon(Icons.add),
        ));
  }
}
