import 'package:arshad/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../DataBloc/data_bloc.dart';

class EditItemPage extends StatefulWidget {
  @override
  _EditItemPageState createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _imgLinkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dataBloc = BlocProvider.of<DataBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Item'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _imgLinkController,
              decoration: InputDecoration(labelText: 'Image Link'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                dataBloc.add(EditItem(email: _emailController.text, description: _descriptionController.text, title: _titleController.text, imgLink: _imgLinkController.text));
                //if(dataBloc.state.status==true){

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MyHomePage(title: 'Home',)),
                );
              },
              child: Text('Edit Item'),
            ),
          ],
        ),
      ),
    );
  }
}