import 'dart:html';

import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class MasterDBHandler {
  static String supaBaseURL = 'https://mgjdpeeyigrhdxcnqkaz.supabase.co';
  static String supaBaseKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1namRwZWV5aWdyaGR4Y25xa2F6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NDg0NDM1MDcsImV4cCI6MTk2NDAxOTUwN30.z-pRYrMNxlbSgmhw9B7AxYYukocvRpSdraPNA2QOHO8';

  final client = SupabaseClient(supaBaseURL, supaBaseKey);

  readMedicine() async {
    var response = await client
        .from("Medicine")
        .select(
            'med_id, med_namme, med_type, med_quantity, med_price, med_description')
        .order('med_id', ascending: true)
        .execute();
    print(response);
    final dataList = response.data as List;
    return dataList;
  }

  addMedicine(int medId, String medName, String medType, int medQuantity,
      int medPrice, String medDescription) async {
    var response = await client.from("Medicine").insert({
      'med_id': medId,
      'med_name': medName,
      'med_type': medType,
      'med_quantity': medQuantity,
      'med_price': medPrice,
      'med_description': medDescription
    }).execute();
    print(response);
  }

  updateMedicine(int medId, String medQuantity, String medPrice) async {
    var response = client
        .from("Medicine")
        .update({'med_Quantity': medQuantity, 'med_Price': medPrice})
        .eq('med_id', medId)
        .execute();
    print(response);
  }
}
