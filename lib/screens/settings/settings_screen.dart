import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lina_pharmacy/widgets/custom_button.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings_screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Settings'),
        titleSpacing: 0,
      ),
      body: Column(
        children: [
          Spacer(),
          Card(
            margin: EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Developed by:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    Container(
                      height: 120,
                      width: 120,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // borderRadius: BorderRadius.circular(8),
                          color: Colors.pink.shade100,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/reyad.jpg'))),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Md. Asifuzzaman Reyad',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'UX Designer & App Developer',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        text: 'Mobile: ',
                        children: [
                          TextSpan(
                            text: '01704340860',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text.rich(
                      TextSpan(
                        text: 'Gmail: ',
                        children: [
                          TextSpan(
                            text: 'reyadcu19@gmail.com',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //mail
                          CustomButton(
                              type: 'mailto:',
                              link: 'asifreyad1@gmail.com',
                              icon: Icons.mail,
                              color: Colors.red),

                          SizedBox(width: 8),

                          //facebook
                          CustomButton(
                              type: '',
                              link: 'www.facebook.com/asifuzzaman.reyad',
                              icon: Icons.facebook,
                              color: Colors.blue),
                          SizedBox(width: 8),

                          //call
                          CustomButton(
                              type: 'tel:',
                              link: '01704340860',
                              icon: Icons.call,
                              color: Colors.green),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
