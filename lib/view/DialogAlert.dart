import 'package:flutter/material.dart';

class DialogAlert{

  void showMessageDialog(BuildContext context, String titulo, String text) async {
    // flutter defined function
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(titulo),
          content: new Text(text),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Fechar", style: TextStyle(color: Colors.deepOrange),),
              onPressed: () {

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  void showProgressDialog(BuildContext context, String texto) async {
    // flutter defined function
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Center(
            child: Card(
              elevation: 4,
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: SizedBox(
                    height: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(texto),
                        )
                      ],
                    ),
                  )
              ),
            )
        );
      },
    );
  }

}