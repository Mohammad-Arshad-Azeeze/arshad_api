import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/DataModel.dart';

class ApiService {

  final String baseurl = "https://emergingideas.ae/test_apis";

  Future<List<DataModel>?> fetchData(String email) async {
    print("calling api");

    final String apiUrl = '${baseurl}/read.php?email=$email';
    print("calling api${apiUrl}");

    try {
      final response = await http.get(Uri.parse(apiUrl));
      print("calling api response:${response.body}");
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body) as List;
        return responseData.map((map) {
          return DataModel(
            id: map['id'] as int,
            title: map['title'] as String,
            description: map['description'] as String,
            imgLink: map['img_link'] as String,
            email: map['email'] as String,
          );
        }).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }
  Future<bool> addItem(String email, String discription, String title, String url) async {
    final String apiUrl = '$baseurl/create.php';
    print("api called:$apiUrl");
    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(<String, String>{
        'email': email,
        'description': discription,
        'title': title,
        'img_link': url,
      }),
    );
    print("api response:${response.body.toString()}");
    if (response.statusCode == 200) {
      // Item added successfully
      print('Item added successfully');
      return true;
    } else {
      // Failed to add item
      print('Failed to add item');
      return false;
    }
  }

  Future<void> deleteItem(String email, num id) async {
    final String apiUrl = '$baseurl/delete.php';
    print("calling delete:${apiUrl}");
    final http.Response response = await http.delete(
        Uri.parse('$apiUrl?email=${email}& id=${id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    print(" delete:${response.body}");

    if (response.statusCode == 200) {
      // Item deleted successfully
      print('Item deleted successfully');
    } else {
      // Failed to delete item
      print('Failed to delete item');
    }
  }

  Future<bool> editItem(String email, String discription, String title, String url) async {
    final String apiUrl = '$baseurl/edit.php';
    print("api called:$apiUrl");
    final response = await http.put(
      Uri.parse(apiUrl),
      body: jsonEncode(<String, String>{
        'email': email,
        'description': discription,
        'title': title,
        'img_link': url,
      }),
    );
    print("api response:${response.body.toString()}");
    if (response.statusCode == 200) {
      // Item added successfully
      print('Item edited successfully');
      return true;
    } else {
      // Failed to add item
      print('Failed to edit item');
      return false;
    }
  }

}
