import 'dart:html';

import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class SupabaseHandler {
  static String supaBaseURL = '';
  static String supaBaseKey = '';

  final client = SupabaseClient(supaBaseURL, supaBaseKey);

  readData() async {
    var response = await client
        .from("Medicine")
        .select('med_namme, med_type')
        .order('med_name', ascending: true)
        .execute();
    print(response);
    final dataList = response.data as List;
  }
}
