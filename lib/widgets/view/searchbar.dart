import 'package:flutter/material.dart';
import '../search/search.dart';
import 'style.dart';

//working perfectly with names table  in supabase

class Searchbar extends StatelessWidget {
  const Searchbar({Key? key}) : super(key: key);

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
