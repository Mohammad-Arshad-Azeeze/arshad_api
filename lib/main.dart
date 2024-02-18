import 'package:arshad/DataBloc/data_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'UI/adddnew.dart';
import 'model/DataModel.dart';
import 'UI/edit_item.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<DataBloc>(
        create: (BuildContext context) =>
            DataBloc()..add(Fetchall(email: "arshad@gmail.com")),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Load Item'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title ?? "Home"),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Press the button to fetch data"),
              FloatingActionButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(builder: (context) => MyHomePage1(title: 'title',)),
                  );
                },
                tooltip: 'Load Item',
                child: const Icon(Icons.refresh_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePage1 extends StatefulWidget {
  const MyHomePage1({super.key, required this.title});

  final String? title;

  @override
  State<MyHomePage1> createState() => _MyHomePageState1();
}

class _MyHomePageState1 extends State<MyHomePage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("API USING BLOC"),
      ),
      body: BlocBuilder<DataBloc, DataState>(
        builder: (context, state) {
          return state.datalist!.isNotEmpty
              ? ListView.builder(
            itemCount: state.datalist?.length,
            itemBuilder: (BuildContext context, int index) {
              DataModel model = state.datalist![index];
              return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                    NetworkImage('${model.imgLink}', scale: 1.0),
                  ),
                  title: Text("${model.title}"),
                  subtitle: Text("${model.description}"),
                  trailing: Wrap(spacing: -15, children: [
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        context.read<DataBloc>().add(DeleteItem(
                            email: model.email.toString(),
                            id: model.id!));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.edit_sharp),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditItemPage()),
                        );
                      },
                    ),
                  ]));
            },
          )
              : Center(child: CircularProgressIndicator());
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItemPage()),
          );
        },
        tooltip: 'add new item',
        child: const Icon(Icons.add),
      ),
    );
  }
}


