import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '/screens/all_medicine/all_medicine_screen.dart';

class AddMedicineScreen extends StatefulWidget {
  static const routeName = '/add_medicine_screen';

  @override
  _AddMedicineScreenState createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final _companyFocusNode = FocusNode();
  final _nameFocusNode = FocusNode();
  final _powerFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();

  TextEditingController _shelfController = TextEditingController();
  TextEditingController _companyController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _powerController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

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
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      //product manage [map]
      Map<String, dynamic> product = {
        'name': _nameController.text,
        'power':
            _powerController.text == '' ? '' : _powerController.text + ' mg',
        'company': _companyController.text,
        'shelf': _shelfController.text,
        'price': double.parse(_priceController.text),
        'searchKey': setSearchParam(_nameController.text.toLowerCase()),
      };

      // upload file to -> fire store collection
      FirebaseFirestore.instance
          .collection('lina-pharmacy')
          .add(product)
          .then((value) {
        //snack bar
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('Medicine uploading successfully'),
              duration: Duration(seconds: 2),
            ),
          );
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        titleSpacing: 0,
        title: Text('Add Medicine'),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AllMedicineScreen.routeName);
              },
              child: Text(
                'All Medicine',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/lina3.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.srcOver,
            ),
          ),
        ),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                // Text(
                //   'Add Product',
                //   textAlign: TextAlign.left,
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold,
                //     fontSize: 40,
                //     color: Colors.white,
                //   ),
                // ),
                SizedBox(height: 32),
                Row(
                  children: [
                    //shelf [text form field]
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Shelf',
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        keyboardType: TextInputType.text,
                        maxLength: 2,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_companyFocusNode);
                        },
                        textCapitalization: TextCapitalization.characters,
                        controller: _shelfController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter shelf';
                          }
                          return null;
                        },
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
                          fillColor: Colors.white,
                          filled: true,
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
                          FocusScope.of(context).requestFocus(_nameFocusNode);
                        },
                        textCapitalization: TextCapitalization.words,
                        controller: _companyController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter company';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                //name [text form field]
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                    filled: true,
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
                    FocusScope.of(context).requestFocus(_powerFocusNode);
                  },
                  textCapitalization: TextCapitalization.words,
                  controller: _nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Power',
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _powerController.clear();
                        });
                      },
                      child: Icon(Icons.clear),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  focusNode: _powerFocusNode,
                  controller: _powerController,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                    filled: true,
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                InkWell(
                  onTap: () {
                    uploadProduct();
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.black,
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Upload Medicine',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1),
                            ),
                          )),
                      Positioned(
                        left: 16,
                        child: Visibility(
                            visible: _isLoading,
                            child: CircularProgressIndicator(
                              color: Colors.red,
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
