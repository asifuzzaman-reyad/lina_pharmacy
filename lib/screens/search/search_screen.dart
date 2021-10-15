import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/screens/dashboard/dashboard_screen.dart';
import '/screens/search/components/search_function.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search_screen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String name = '';
  TextEditingController _searchController = TextEditingController();
  FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // stop resize bg image
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
          image: AssetImage('assets/images/lina4.jpg'),
        )),
        child: SafeArea(
          child: Column(
            children: [
              //  custom header
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      child: Text(
                        'Lina\nPharmacy',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, DashboardScreen.routeName);
                        },
                        icon: Icon(
                          Icons.add_chart,
                          size: 32,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),

              //search bar
              Container(
                // height: 64,
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.white.withOpacity(0.8),
                  border: Border.all(color: Colors.black12),
                ),
                alignment: Alignment.center,
                child: TextFormField(
                  autofocus: true,
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
                child: SearchFunction(name: name),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
