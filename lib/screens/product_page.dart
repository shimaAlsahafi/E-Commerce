import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerceapps/services/firebase_service.dart';
import 'package:commerceapps/widget/custom_action_bar.dart';
import 'package:commerceapps/widget/image_swipe.dart';
import 'package:commerceapps/widget/product_size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constans.dart';
class ProductPage extends StatefulWidget {
  final String porducId;

  const ProductPage({Key key, this.porducId}) : super(key: key);
  @override
  _ProductPageState createState() => _ProductPageState();
}


class _ProductPageState extends State<ProductPage> {

  FirebaseServices _firebaseServices =FirebaseServices();
  final SnackBar _snackBar=SnackBar(content: Text('Product added to to the cart'));
  final SnackBar _snackBarOfS=SnackBar(content: Text('Product added to to the saved'));
  String _selectdProductSize='0';

  Future addToCart(){
    return _firebaseServices.UserRef.
    doc(_firebaseServices.getUserid()).
    collection('Cart').
    doc(widget.porducId).set({
      'size':_selectdProductSize
    }
    );
  }
  Future addToSaved(){
    return _firebaseServices.UserRef.
    doc(_firebaseServices.getUserid()).
    collection('Saved').
    doc(widget.porducId).set({
      'size':_selectdProductSize
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
          FutureBuilder(future:_firebaseServices.productRef.doc(widget.porducId).get() ,builder:(context,snapshot){
            if(snapshot.hasError){
              return Scaffold(body: Center(child: Text('erorr:${snapshot.error}',style: Constans.regularHeading,),),);
            }
            // loading data of product
            if(snapshot.connectionState==ConnectionState.done){
              // firebase documemt data map
              Map<String,dynamic> documentData=snapshot.data.data();
              // list of images
              List imageList=documentData['images'];
              List productSizes=documentData['size'];
              _selectdProductSize=productSizes[0];
              return ListView(padding: EdgeInsets.all(0),
                children: [
                  ImageSwipe(imagelist:imageList)
                 , Padding(
                   padding: const EdgeInsets.only(top: 24,left: 24,right: 24,bottom: 24),
                   child: Text('${documentData['name']} '??'Produt Name',style: Constans.boldHeading,),
                 ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 24),
                    child: Text('\$${documentData['price']} '??'Price',style: TextStyle(color: Theme.of(context).accentColor,fontWeight: FontWeight.w600,fontSize: 18),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 24),
                    child: Text('${documentData['desc']} '??'description',style: TextStyle(fontSize: 16),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 24),
                    child: Text('Select Size',style: Constans.regularHeading,),
                  ),
                  ProductSize(proudctSize: productSizes,onSelected: (size){
                    _selectdProductSize=size;
                  },),
                  SizedBox(height: 23,),Padding(
                    padding: const EdgeInsets.all(24.0),

                    child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [

                      GestureDetector(onTap: ()async{
                        await addToSaved();
                        Scaffold.of(context).showSnackBar(_snackBarOfS);
                      },
                        child: Container(height: 65,width: 65,
                          decoration: BoxDecoration(color: Color(0xFFDCDCDC),
                              borderRadius: BorderRadius.circular(12)),
                          child: Image(image: AssetImage('assets/images/tab_saved.png'),height: 12,),),
                      ),

Expanded(
    child:GestureDetector(onTap: ()async{
       await addToCart();
     Scaffold.of(context).showSnackBar(_snackBar);
     },
      child: Container(
        alignment: Alignment.center,margin: EdgeInsets.only(left: 16),height: 65,
        decoration: BoxDecoration(color:Colors.black,borderRadius: BorderRadius.circular(12) ),
  child: Text('Add To Cart ',
      style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w600),),),
    )
)                    ],),
                  )

                ],
              );
            }

            return Scaffold(body: Center(child: CircularProgressIndicator(),),);

          })
   , CustomActionBar(hasTitle: false,hasBackArrow: true,hasbackground: false,)    ],


      ),
    );
  }
}
