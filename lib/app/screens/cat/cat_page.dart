import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Cat {
  List<dynamic>? breeds;
  String? id;
  String? url;
  num? width;
  num? height;

  Cat({this.breeds, this.id, this.url, this.width, this.height});

  Cat.fromJson(Map<String, dynamic> json) {
    breeds = json['breeds'];
    id = json['id'];
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['breeds'] = breeds;
    data['id'] = id;
    data['url'] = url;
    data['width'] = width;
    data['height'] = height;
    return data;
  }
}

class CatModel {
  num? statusCode;
  List<Cat> data = [];

  CatModel({this.statusCode, required this.data});

  CatModel.fromList(List<dynamic> list) {
    data = [];
    for (var element in list) {
      data.add(Cat.fromJson(element));
    }
  }

  CatModel.fromJson(Map<String, dynamic> json) {
    data = [];
    json['data'].forEach((v) {
      data.add(Cat.fromJson(v));
    });
    statusCode = json[''];
  }
}

class CatPage extends StatefulWidget {
  @override
  State<CatPage> createState() => _CatPageState();
}

class _CatPageState extends State<CatPage> {
  late CatModel catData;
  var catImageUrl =
      'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif';
  final dio = Dio();

  void getCatData() async {
    const baseUrl = 'https://api.thecatapi.com/v1/';
    const apiKey =
        "live_ORgUELsOztLBCGbjozC3oqaIeXryfSvjgEKFiGOFt4eSXrghCLzlrZb4tPsP1wXp";
    const url = '${baseUrl}images/search';

    try {
      Response response = await dio.get(url,
          queryParameters: Map.from({'format': 'json'}),
          options: Options(headers: Map.from({'x-api-key': apiKey})));

      final data = CatModel.fromList(response.data).data;
      if (data.isNotEmpty) {
        print(data[0].url);
        setState(() {
          catImageUrl = data[0].url ?? '';
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(catImageUrl),
          ElevatedButton.icon(
            onPressed: () {
              getCatData();
            },
            icon: Icon(Icons.refresh),
            label: Text('Re-fetch'),
          ),
        ],
      ),
    );
  }
}
