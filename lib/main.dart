import 'package:arshad/DataBloc/data_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'adddnew.dart';
import 'model/DataModel.dart';

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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
      body: BlocBuilder<DataBloc, DataState>(
        builder: (context, state) {
          return state.datalist!.isNotEmpty
              ? ListView.builder(
                  itemCount: state.datalist?.length,
                  itemBuilder: (BuildContext context, int index) {
                    DataModel model = state.datalist![index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage('${model.imgLink}',scale: 1.0),
                      ),
                      title: Text("${model.title}"),
                      subtitle: Text("${model.description}"),
                      trailing: IconButton(icon: Icon(Icons.delete), onPressed: () {
                        context.read<DataBloc>().add(DeleteItem(email: model.email.toString(), id: model.id!));
                      },),
                    );
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
