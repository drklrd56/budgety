import 'package:flutter/material.dart';
import '../Pages/SearchPage.dart';
import '../Pages/GraphPage.dart';
import '../Pages/HomePage.dart';
import '../Pages/BackupRestore.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      elevation: 3,
      child: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xff50d6a4), Color(0xff4acd89)]),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.07,),
                  Image(
                  image: AssetImage('assets/wallet.png'),
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.2,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                      'Budgety',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                      ),
                      
                      Text(
                      'My Wallet',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    ],
                  )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
            child : Container(
              color: Colors.transparent,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.07,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget> [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Icon(
                    Icons.home,
                    size: 30,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.06,
                  ),
                  Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage(0)),
              );
            },
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.07,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget> [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Icon(
                    Icons.dehaze,
                    size: 30,
                    color: Colors.orange,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.06,
                  ),
                  Text(
                    'Records',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GraphPage()),
              );
            },
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.07,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget> [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Icon(
                    Icons.show_chart,
                    size: 30,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.06,
                  ),
                  Text(
                    'Graphs',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => BackupRestore()),
          //     );
          //   },
          //   child: Container(
          //     color: Colors.transparent,
          //     width: double.infinity,
          //     height: MediaQuery.of(context).size.height * 0.07,
          //     child: Row(
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: <Widget> [
          //         SizedBox(
          //           width: MediaQuery.of(context).size.width * 0.03,
          //         ),
          //         Icon(
          //           Icons.settings_backup_restore,
          //           size: 30,
          //           color: Colors.orange,
          //         ),
          //         SizedBox(
          //           width: MediaQuery.of(context).size.width * 0.06,
          //         ),
          //         Text(
          //           'Backup & Restore',
          //           style: TextStyle(
          //             fontSize: 18,
          //             fontWeight: FontWeight.w400,
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}