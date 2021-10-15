import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UploadMedicineDialog extends StatefulWidget {
  const UploadMedicineDialog({this.shelfName});
  final String? shelfName;

  @override
  _UploadMedicineDialogState createState() => _UploadMedicineDialogState();
}

class _UploadMedicineDialogState extends State<UploadMedicineDialog> {
  //
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //
  TextEditingController _shelfController = TextEditingController();
  TextEditingController _companyController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _powerController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  //
  final _companyFocusNode = FocusNode();
  final _nameFocusNode = FocusNode();
  final _powerFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();

  //
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
  void uploadMedicine() {
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
              content: Text('Medicine upload successfully'),
              duration: Duration(seconds: 2),
            ),
          );
        setState(() {
          _isLoading = false;
        });

        //
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // set shelf name
    _shelfController.text = widget.shelfName!;

    return SingleChildScrollView(
      child: Dialog(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                    )),
                child: Text(
                  'Add Medicine',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                right: 8,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.clear,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          // SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            autofocus: true,
                            decoration: InputDecoration(
                              labelText: 'Shelf',
                            ),
                            maxLength: 2,
                            controller: _shelfController,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.characters,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_companyFocusNode);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter shelf name';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          flex: 4,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'company',
                              helperText: '',
                            ),
                            controller: _companyController,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            focusNode: _companyFocusNode,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_nameFocusNode);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter company name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Name',
                      ),
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.words,
                      focusNode: _nameFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_powerFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter medicine name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Power',
                      ),
                      controller: _powerController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      focusNode: _powerFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        return null;
                      },
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Price',
                      ),
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      focusNode: _priceFocusNode,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter medicine price';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24),
                    InkWell(
                      onTap: () {
                        //
                        uploadMedicine();
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                child: Text(
                                  'Upload Medicine',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1),
                                ),
                              )),
                          Positioned(
                            left: 16,
                            child: Visibility(
                                visible: _isLoading,
                                child: SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.red,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
