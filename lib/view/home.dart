import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hmais_argamassa/view/home_screen/points.dart';
import 'package:hmais_argamassa/view/home_screen/products.dart';



class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _page = 0;
  Widget contents = PointsView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        title:Center(child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 50,),
            Image.asset('img/logo.png', height: 40,)
          ],
        ),),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: (){},
            color: Colors.black87,
          )
        ],
      ),
      body: contents,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.deepOrange,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.shopping_cart, size: 30),
          Icon(Icons.list, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
            switch (_page) {
              case 0:
                contents = PointsView();
                break;
              case 1:
                contents = ProductsView();
                break;
              case 2:
//                contents = Finance();
                break;
            }
          });
        },
      ),
    );
  }
}
