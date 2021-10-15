import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/screens/search/components/search_function.dart';
import '/widgets/product_card_1.dart';
import '../../widgets/upload_medicine_dialog.dart';

class AllMedicineScreen extends StatefulWidget {
  static const routeName = 'all_medicine_screen';
  @override
  _AllMedicineScreenState createState() => _AllMedicineScreenState();
}

class _AllMedicineScreenState extends State<AllMedicineScreen> {
  //
  final _stream = FirebaseFirestore.instance
      .collection('lina-pharmacy')
      .orderBy('shelf', descending: false)
      .snapshots();

  String name = '';
  TextEditingController _searchController = TextEditingController();
  FocusNode _searchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          'All Medicine ',
          style: TextStyle(),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Row(
              children: [
                Text('Total :'),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('lina-pharmacy')
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
          ),
        ],
      ),
      body: Column(
        children: [
          //search bar
          Container(
            // height: 64,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              // color: Colors.white.withOpacity(0.8),
              border: Border.all(color: Colors.black12),
            ),
            alignment: Alignment.center,
            child: TextFormField(
              // autofocus: true,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Find medicine by name...',
                hintStyle: TextStyle(fontSize: 20),
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
              controller: _searchController,
              focusNode: _searchFocusNode,
              onChanged: (val) {
                setState(() {
                  name = val;
                });
              },
            ),
          ),
          //
          Expanded(
              child: Container(
            // color: Colors.greenAccent,
            child:
                name.isNotEmpty ? SearchFunction(name: name) : buildColumn(""),
          )),
        ],
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

  // all medicine column
  Column buildColumn(String productCount) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder(
            stream: _stream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView(
                children: snapshot.data!.docs.map((document) {
                  return ProductCard1(
                    document: document,
                    editable: true,
                  );
                }).toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}
