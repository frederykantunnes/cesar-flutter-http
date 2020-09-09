import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hmais_argamassa/config/StringsConfig.dart';
import 'package:hmais_argamassa/controller/UserController.dart';
import 'package:hmais_argamassa/model/RewardsModel.dart';
import 'package:hmais_argamassa/view/rewards_show.dart';

class PointsView extends StatefulWidget {
  @override
  _PointsViewState createState() => _PointsViewState();
}

class _PointsViewState extends State<PointsView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(height: 25,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 250,
                height: 250,
                child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("img/points.png", height: 70,),
                        Text(UserController.pointsUsuarioLogado.toString(), style: TextStyle(fontSize: 70, fontWeight: FontWeight.w500),),
                        Text(" Pontos Aculumados", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                        SizedBox(height: 30,)
                      ],
                    )
                ),
              )
            ],
          ),
          SizedBox(height: 30,),
          Row(
            children: <Widget>[
              SizedBox(width: 8,),
              Icon(Icons.shopping_basket, color: Colors.white,),
              Text(" Recompensas", style: TextStyle(color: Colors.white,fontSize: 23),),
            ],
          ),
          Expanded(
            child:FutureBuilder(
              future: RewardsModel().getData(),
              builder: (context, projectSnap){
                if(projectSnap.data == null){
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),),
                        SizedBox(height: 5,),
                        Text("Buscando Recompensas...", style: TextStyle(color: Colors.white),)
                      ],
                    ),

                  );
                }
                return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: projectSnap.data == null ? 0 : projectSnap.data.length,
                    itemBuilder: (context, index) {
                      RewardsModel beneficio = projectSnap.data[index];
                      return FlatButton(
                        padding: EdgeInsets.all(0),
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(StringsConfig().urlAdmin+beneficio.picture, fit: BoxFit.fill,
                                        loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                                          if (loadingProgress == null) return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              valueColor: new AlwaysStoppedAnimation<Color>(Colors.deepOrange), value: loadingProgress.expectedTotalBytes != null ?
                                            loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes : null,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
//                                Text(beneficio.name, style: TextStyle(color: Colors.black45),),
                                  SizedBox(height: 5,),
                                  Text( beneficio.points+" Pontos", style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w700, fontSize: 18),),
                                  SizedBox(height: 2,),
                                ],
                              ),
                            )
                        ),
                        onPressed: (){
                          RewardsModel.rewardsModelSelected = beneficio;
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>RewardsShow()));
                        },
                      );
                    }
                );
              },
            ),
          ),
          SizedBox(height: 15,),
        ],
      );
  }
}


