import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerceapps/screens/product_page.dart';
import 'package:commerceapps/services/firebase_service.dart';
import 'package:commerceapps/widget/custom_action_bar.dart';
import 'package:flutter/material.dart';

import '../constans.dart';
class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override

  FirebaseServices _firebaseServices =FirebaseServices();
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(children: [
        FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.UserRef.doc(_firebaseServices.getUserid()).collection('Cart').get(),
            builder: (context,snapshot){
              if(snapshot.hasError){
                return Scaffold(body: Center(child: Text('erorr:${snapshot.error}',style: Constans.regularHeading,),),);
              }
              // Collection data ready to display
              if(snapshot.connectionState==ConnectionState.done){
                return ListView(
                  padding: EdgeInsets.only(top: 107,bottom: 24),children: snapshot.data.docs.map((document) => GestureDetector(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>ProductPage(porducId:document.id ,)));
                  },
                  child: FutureBuilder(
                    future: _firebaseServices.productRef.doc(document.id).get(),
                    builder: (context,productSnap){
                      if(productSnap.hasError){
                        return Container(child:Center(child:Text('${productSnap.error}')),);
                      }
                      if(productSnap.connectionState==ConnectionState.done){
                        Map _productMap=productSnap.data.data();
                        return Padding(padding: EdgeInsets.symmetric(vertical: 16,horizontal: 24),
                          child:Row(mainAxisAlignment: MainAxisAlignment.start,
                            children: [
Container(height: 90,width: 90,child: ClipRRect(borderRadius: BorderRadius.circular(8),
  child: Image.network('${_productMap['images'][0]}',fit: BoxFit.cover,),
),),

Container(padding: EdgeInsets.only(left: 16),child: Column(
  mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text('${_productMap['name']}',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.black),),
    Padding(padding: EdgeInsets.symmetric(vertical: 4),child: Text('${_productMap['price']}',
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,color: Theme.of(context).accentColor
    ),),)
,Text('Size - ${document.data()['size']}',
      style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,color:Colors.black
      ),)
  ],
),)
                            ],
                          ) ,);
                      }
                      return Container(child: Center(child: CircularProgressIndicator(),),);
                    },
                  ),
                )).toList(),);

              }
              return Center(child: CircularProgressIndicator(),);


            }),
        CustomActionBar(hasBackArrow: true,hasTitle: true,title: 'Cart',)
      ],),
    );
  }
}
