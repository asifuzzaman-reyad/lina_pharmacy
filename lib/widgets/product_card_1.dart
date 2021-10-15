import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lina_pharmacy/screens/search/components/my_popup_button.dart';
import 'package:lina_pharmacy/widgets/color_changer.dart';

class ProductCard1 extends StatelessWidget {
  ProductCard1({required this.document, required this.editable});
  final QueryDocumentSnapshot document;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(12, 0, 12, 12),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //self
                Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: colorChanger(document.get('shelf')[0]),
                        borderRadius: BorderRadius.circular(4)),
                    child: Text(document.get('shelf'),
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold))),

                SizedBox(width: 10),

                //name and price
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //name
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(document.get('name'),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.3)),
                              SizedBox(height: 4),
                              SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    document.get('power'),
                                    style: TextStyle(),
                                  )),
                            ],
                          ),
                        ),
                      ),

                      //price
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                            color: Colors.pink.withOpacity(0.2),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                            )),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '৳ ',
                                style: TextStyle(),
                              ),
                              TextSpan(
                                text: document.get('price').toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // bottom
          Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 13),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade100,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        child: Text(document.get('company'),
                            style: TextStyle(letterSpacing: 2))),
                  ),
                  Visibility(
                      visible: editable,
                      child: MyPopupMenuButton(document: document)),
                ],
              ))
        ],
      ),
    );
  }
}
