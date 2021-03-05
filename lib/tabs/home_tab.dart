import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerceapps/screens/product_page.dart';
import 'package:commerceapps/widget/custom_action_bar.dart';
import 'package:commerceapps/widget/product_card.dart';
import 'package:flutter/material.dart';

import '../constans.dart';
class HomeTab extends StatelessWidget {
  final CollectionReference _productRef=FirebaseFirestore.instance.collection('Product');
  @override
  Widget build(BuildContext context) {
    return Container(child: Stack(
      children: [
      FutureBuilder<QuerySnapshot>(
          future: _productRef.get(),
          builder: (context,snapshot){
            if(snapshot.hasError){
              return Scaffold(body: Center(child: Text('erorr:${snapshot.error}',style: Constans.regularHeading,),),);
            }
            // Collection data ready to display
            if(snapshot.connectionState==ConnectionState.done){
              return ListView(
                padding: EdgeInsets.only(top: 107,bottom: 24),children: snapshot.data.docs.map((document) => ProductCard(
                title: document.data()['name'],
                imageUrl: document.data()['images'][0],
                price: '\$${document.data()['price']}',
                onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>ProductPage(porducId:document.id,)));
                },
              )).toList(),);

            }
            return Center(child: CircularProgressIndicator(),);


      }),
        CustomActionBar(hasBackArrow: false,hasTitle: true,title: 'Home',),

      ],
    ),);
  }
}
