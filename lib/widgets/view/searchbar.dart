import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../search/search.dart';
import 'style.dart';

//working perfectly with names table  in supabase 


class Searchbar extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MEDICINE Search',
      home: const Search(),
      theme: appTheme,
    );
  }
}