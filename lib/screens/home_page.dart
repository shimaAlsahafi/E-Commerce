

import 'package:commerceapps/constans.dart';
import 'package:commerceapps/tabs/home_tab.dart';
import 'package:commerceapps/tabs/saved_tab.dart';
import 'package:commerceapps/tabs/search_tab.dart';
import 'package:commerceapps/widget/custom_action_bar.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:commerceapps/widget/bottom_tabs.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
PageController _tabsPageController;
int _selectedtab=0;
class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    _tabsPageController=PageController();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _tabsPageController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Column(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Expanded(child:
        PageView(
          controller: _tabsPageController,onPageChanged: (num){
            setState(() {
              _selectedtab=num;
              print(_selectedtab);
            });
        },
          children: [
            HomeTab(),
            SearchTab(),
            SavedTab(),

        ],)),
          BottomTabs(selectedtab: _selectedtab,ontabPressed:(num) {
    _tabsPageController.animateToPage(
    num,
    duration: Duration(milliseconds: 300),
    curve: Curves.easeOutCubic);
    },)
        ],
      ),));

  }
}
