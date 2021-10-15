import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ActionList { edit, delete, cancel }

class MyPopupMenuButton extends StatefulWidget {
  const MyPopupMenuButton({required this.document});
  final QueryDocumentSnapshot document;

  @override
  _MyPopupMenuButtonState createState() => _MyPopupMenuButtonState();
}

class _MyPopupMenuButtonState extends State<MyPopupMenuButton> {
  final _companyFocusNode = FocusNode();
  final _nameFocusNode = FocusNode();
  final _powerFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();

  TextEditingController _shelfController = TextEditingController();
  TextEditingController _companyController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _powerController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  // create search key list
  setSearchParam(String caseNumber) {
    List<String> caseSearchList = [];
    String temp = "";
    for (int i = 0; i < caseNumber.length; i++) {
      temp = temp + caseNumber[i];
      caseSearchList.add(temp);
    }
    return caseSearchList;
  }

  // upload to firebase
  void uploadProduct() {
    //snack bar
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('product uploading...'),
          duration: Duration(seconds: 1),
        ),
      );

    //product manage [map]
    Map<String, dynamic> product = {
      'name': _nameController.text,
      'power': _powerController.text == '' ? '' : _powerController.text,
      'company': _companyController.text,
      'shelf': _shelfController.text,
      'price': double.parse(_priceController.text),
      'searchKey': setSearchParam(_nameController.text.toLowerCase()),
    };

    // upload file to -> fire store collection
    widget.document.reference.update(product);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (ActionList selectedValue) {
        setState(() {
          if (ActionList.edit == selectedValue) {
            //
            _shelfController.text = widget.document.get('shelf');
            _companyController.text = widget.document.get('company');
            _nameController.text = widget.document.get('name');
            _powerController.text = widget.document.get('power');
            _priceController.text = widget.document.get('price').toString();

            //
            showDialog(
                context: context,
                builder: (context) => Dialog(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        child: Form(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Edit Product',
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 32),
                              ),
                              SizedBox(height: 24),
                              Row(
                                children: [
                                  //shelf [text form field]
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Shelf',
                                        border: OutlineInputBorder(),
                                      ),
                                      keyboardType: TextInputType.text,
                                      maxLength: 2,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (_) {
                                        FocusScope.of(context)
                                            .requestFocus(_companyFocusNode);
                                      },
                                      textCapitalization:
                                          TextCapitalization.characters,
                                      controller: _shelfController,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  //company [text form field]
                                  Expanded(
                                    flex: 6,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Company',
                                        helperText: '',
                                        border: OutlineInputBorder(),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _companyController.clear();
                                            });
                                          },
                                          child: Icon(Icons.clear),
                                        ),
                                      ),
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      focusNode: _companyFocusNode,
                                      onFieldSubmitted: (_) {
                                        FocusScope.of(context)
                                            .requestFocus(_nameFocusNode);
                                      },
                                      textCapitalization:
                                          TextCapitalization.words,
                                      controller: _companyController,
                                    ),
                                  ),
                                ],
                              ),
                              //name [text form field]
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                  border: OutlineInputBorder(),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _nameController.clear();
                                      });
                                    },
                                    child: Icon(Icons.clear),
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                focusNode: _nameFocusNode,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_powerFocusNode);
                                },
                                textCapitalization: TextCapitalization.words,
                                controller: _nameController,
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  //power [text form field]
                                  Expanded(
                                    flex: 3,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Power',
                                        border: OutlineInputBorder(),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _powerController.clear();
                                            });
                                          },
                                          child: Icon(Icons.clear),
                                        ),
                                      ),
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (_) {
                                        FocusScope.of(context)
                                            .requestFocus(_priceFocusNode);
                                      },
                                      focusNode: _powerFocusNode,
                                      controller: _powerController,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  //price [text form field]
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Price',
                                        border: OutlineInputBorder(),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _priceController.clear();
                                            });
                                          },
                                          child: Icon(Icons.clear),
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.done,
                                      onFieldSubmitted: (_) {
                                        //todo: on later
                                        // uploadProduct();
                                      },
                                      focusNode: _priceFocusNode,
                                      controller: _priceController,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 24),
                              InkWell(
                                onTap: () {
                                  uploadProduct();
                                },
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.black,
                                    ),
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        'Update',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    )),
                              ),
                              OutlinedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel'))
                            ],
                          ),
                        ),
                      ),
                    ));
          } else if (ActionList.delete == selectedValue) {
            //
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Really want do delete?'),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('No')),
                        SizedBox(width: 8),
                        TextButton(
                            onPressed: () {
                              //
                              FirebaseFirestore.instance
                                  .collection('lina-pharmacy')
                                  .doc(widget.document.id)
                                  .delete()
                                  .whenComplete(() {
                                //
                                Navigator.pop(context);
                                //
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(SnackBar(
                                    duration: Duration(seconds: 2),
                                    content: Text('Delete successfully'),
                                  ));
                              }).onError((error, stackTrace) {
                                //
                                Navigator.pop(context);
                                //
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(SnackBar(
                                    duration: Duration(seconds: 2),
                                    content: Text(error.toString()),
                                  ));
                              });
                            },
                            child: Text('Yes')),
                      ],
                    ),
                  );
                });
          } else {
            print("filter: cancel");
          }
        });
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: ActionList.edit,
          child: Row(
            children: [
              Icon(Icons.edit),
              SizedBox(width: 16),
              Text('Edit'),
            ],
          ),
        ),
        PopupMenuItem(
          value: ActionList.delete,
          child: Row(
            children: [
              Icon(Icons.delete),
              SizedBox(width: 16),
              Text('Delete'),
            ],
          ),
        ),
        PopupMenuItem(
          value: ActionList.cancel,
          child: Row(
            children: [
              Icon(Icons.clear),
              SizedBox(width: 16),
              Text('Cancel'),
            ],
          ),
        ),
      ],
    );
  }
}
