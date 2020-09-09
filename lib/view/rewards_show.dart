import 'package:flutter/material.dart';
import 'package:hmais_argamassa/config/StringsConfig.dart';
import 'package:hmais_argamassa/controller/UserController.dart';
import 'package:hmais_argamassa/model/RewardsModel.dart';


class RewardsShow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Recompensa"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[

                ClipRRect(
                  borderRadius: BorderRadius.only( bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                  child: Image.network(
                    StringsConfig().urlAdmin+RewardsModel.rewardsModelSelected.picture,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: (
                      Column(
                        children: <Widget>[
                          Text(RewardsModel.rewardsModelSelected.name, textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                          SizedBox(
                            height: 10,
                          ),
                          Text(RewardsModel.rewardsModelSelected.description, textAlign: TextAlign.justify, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),),
                          SizedBox(
                            height: 30,
                          ),
                          Text(RewardsModel.rewardsModelSelected.points, textAlign: TextAlign.justify, style: TextStyle(fontSize: 60, fontWeight: FontWeight.w700),),
                          Text("Pontos necessários para troca", textAlign: TextAlign.justify, style: TextStyle(fontSize:14),),
                          SizedBox(
                            height: 40,
                          ),
                          podeObter()?SizedBox(
                            width: size.width-20,
                            child: RaisedButton(
                              child: Text("Solicitar Troca de Pontos", style: TextStyle(color: Colors.white),),
                              color: Colors.deepOrange,
                              onPressed: (){},
                            ),
                          ):
                          SizedBox(
                            width: size.width-50,
                          child: Text("Ops, Você não tem pontos suficientes para realizar a troca por esse benefício", textAlign: TextAlign.center, style: TextStyle(color: Colors.redAccent),),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      )
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
  podeObter(){
    if(int.parse(RewardsModel.rewardsModelSelected.points) > UserController.pointsUsuarioLogado){
      return false;
    }
    return true;
  }
}
