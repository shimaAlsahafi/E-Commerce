import 'package:commerceapps/screens/product_page.dart';
import 'package:flutter/material.dart';

import '../constans.dart';
class ProductCard extends StatelessWidget {
  final Function onPressed;
  final String productId;
  final String imageUrl;
  final String title;
  final String price;

  const ProductCard({Key key, this.onPressed, this.productId, this.imageUrl, this.title, this.price}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(height: 350,margin: EdgeInsets.symmetric(vertical: 12,horizontal: 24),
        child:Stack(children: [
          Container(height: 350,
              child: ClipRRect(borderRadius: BorderRadius.circular(12),
                  child: Image.network(imageUrl,fit:BoxFit.cover))),
          Positioned(bottom: 0,left: 0,right: 0,child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
              Text(title,style: Constans.regularHeading,),
              Text(price,style: TextStyle(color: Theme.of(context).accentColor,fontSize: 18,fontWeight: FontWeight.w600
              ),)
            ],),
          ))
        ],),),
    );
  }
}
