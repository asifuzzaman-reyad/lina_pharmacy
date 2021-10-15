import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  ProductCard({required this.document});
  final QueryDocumentSnapshot document;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        onLongPress: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('What do you?'),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        onTap: () {},
                        title: Text('Edit'),
                        leading: Icon(Icons.edit),
                      ),
                      ListTile(
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection('lina-pharmacy')
                              .doc(document.id)
                              .delete();
                          //
                          Navigator.pop(context);
                        },
                        title: Text('Delete'),
                        leading: Icon(Icons.delete),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: Text('Cancel'),
                        leading: Icon(Icons.clear),
                      ),
                    ],
                  ),
                );
              });
        },
        title: Text(document.get('name'),
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${document.get('power')}',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(document.get('company'),
                style: TextStyle(color: Colors.deepPurple)),
          ],
        ),
        trailing: Text('৳ ${document.get('price')}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        leading: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.black12, borderRadius: BorderRadius.circular(8)),
          child: Text(
            document.get('shelf'),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
      ),
    );
  }
}
