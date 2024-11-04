import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const  apiLink = "https://opentdb.com/api.php?amount=20&category=18";


getQuizApp()async{
  final res = await http.get(Uri.parse(apiLink));
  if(res.statusCode == 200){
    final data = jsonDecode(res.body);
    return data;

  }
}