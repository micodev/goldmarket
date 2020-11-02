import 'dart:convert';

class SystemApi {
  List<String> users = [
    """{
  "status":true,
  "user":{
    "name":"ibrahim",
    "username":"mico",
    "role":"customer"
  }
}""",
    """{
  "status":true,
  "user":{
    "name":"qasim",
    "username":"qasim123",
    "role":"merchant"
  }
}"""
  ];
  String products = """{
  "status": true,
  "post": [
    {
      "name": "ذهب قلادة",
      "price": "1000 د.ع",
      "weight": "39",
      "description": "قلادة ذهبية جميلة الصنع و لماعة",
      "cover": "https://img.joomcdn.net/391df4787150301a58ee4b8e3f00ff8175afac5a_400_400.jpeg"
    },
    {
      "name": "ذهب محبس",
      "price": "1200 د.ع",
      "weight": "90",
      "description": "قلادة ذهبية امريكيه خالصه نقيه الصنع و لماعة",
      "cover": "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRJrTzGJGtwudR2-Rctt0W2GNhhhpy2B5-A4Q&usqp=CAU"
    },
    {
      "name": "ذهب تخم كامل",
      "price": "2030 د.ع",
      "weight": "39",
      "description": "قلادة ذهبية جميلة الصنع  غاليه نظيفه بيضاء و لماعة",
       "cover": "https://cdn.shopify.com/s/files/1/0881/0264/products/2020-02-15-04.45.21-4_750x502.jpg?v=1588207268"
    }
  ]
}""";
  String bezierChart = """{
  "status": true,
  "bezier": [
    {
      "day": 1,
      "value": 90
     
    },
    {
      "day": 2,
      "value": 35
     
    },
    {
      "day": 3,
      "value": 4
     
    }
  ]
}""";
  Future<dynamic> login(String username, String password) async {
    if (username == "ibrahim")
      return jsonDecode(users[0])["user"];
    else if (username == "qasim")
      return jsonDecode(users[1])["user"];
    else
      return null;
  }

  Future<dynamic> fetchPosts() async {
    return jsonDecode(products);
  }

  Future<dynamic> fetchBezier() async {
    return jsonDecode(bezierChart);
  }
}
