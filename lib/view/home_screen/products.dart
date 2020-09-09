import 'package:flutter/material.dart';
import 'package:hmais_argamassa/config/StringsConfig.dart';
import 'package:hmais_argamassa/model/ProductsModel.dart';

class ProductsView extends StatefulWidget {
  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 3, bottom: 15),
      child: FutureBuilder(
        future: ProductsModel().getData(),
        builder: (context, projectSnap) {
          if(projectSnap.data == null){
            return Container(
              child: Center(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(valueColor:  new AlwaysStoppedAnimation<Color>(Colors.white),),
                    SizedBox(height: 10,),
                    Text("Buscando Produtos...", style: TextStyle(color: Colors.white), )
                  ],
                ),
              ),
            );
          }


          return ListView.builder(
            itemCount: projectSnap.data == null ? 0 : projectSnap.data.length,
            itemBuilder: (context, index) {
              ProductsModel productsModel = projectSnap.data[index];
              return Padding(
                padding: EdgeInsets.only(left: 2, right: 2),
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: (){
//                    ProductsModel.selectedPost = post;
//                    Navigator.push(context, MaterialPageRoute(builder: (context)=>FeedViewDetails()));
                  },
                    child: Card(
                      elevation: 8,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: SizedBox(
                                  width: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(StringsConfig().urlAdmin+productsModel.picture, fit: BoxFit.fill,
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
//                    Image.network(""),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 8,),
                                    Text(productsModel.name, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18,),),
                                    Text(productsModel.description, style: TextStyle(color: Colors.black54, fontSize: 17, fontWeight: FontWeight.w300),maxLines: 3,overflow: TextOverflow.ellipsis,),
                                    Container(
                                      height: 30.0,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: productsModel.sizes == null ? 0 : productsModel.sizes.length,
                                        itemBuilder: (context, i){
                                          return Row(
                                            children: <Widget>[
                                              Chip(label: Text(productsModel.sizes[i]["size"]),),
                                              SizedBox(width: 5,)
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      height: 40.0,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: productsModel.colors == null ? 0 : productsModel.colors.length,
                                        itemBuilder: (context, i){
                                          return Row(
                                            children: <Widget>[
                                              Chip(label: Text(productsModel.colors[i]["name"], style: TextStyle(color: Colors.white, fontSize: 10),), backgroundColor: _colorFromHex(productsModel.colors[i]["hex"]),),
                                              SizedBox(width: 5,)
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 8,),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }
}
