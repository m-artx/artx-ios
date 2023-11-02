import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'side_menu.dart';
import 'font_util.dart';

class ArtistProductList extends StatefulWidget {


  @override
  _ArtistProductListState createState() => _ArtistProductListState();
}

class _ArtistProductListState extends State<ArtistProductList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 23, 23, 23),
      appBar: CustomAppBar(),
      drawer: SideMenu(),
      body: SingleChildScrollView(
        child: Column(
        )
      )
    );
}
}
