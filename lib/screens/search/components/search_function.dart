import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lina_pharmacy/widgets/product_card_1.dart';

class SearchFunction extends StatelessWidget {
  const SearchFunction({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('lina-pharmacy')
          .where("searchKey", arrayContains: name.toLowerCase())
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView(
          children: snapshot.data!.docs.map((document) {
            return ProductCard1(document: document, editable: true);
          }).toList(),
        );
      },
    );
  }
}
