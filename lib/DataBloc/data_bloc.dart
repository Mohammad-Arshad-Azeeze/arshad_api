import 'dart:async';

import 'package:arshad/Repo/apiservice.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/DataModel.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(DataInitial( datalist: [])) {
    ApiService apiService=ApiService();
    on<Fetchall>((event, emit) async {
      var list=await apiService.fetchData(event.email);
      emit(DataState(datalist:list));
    });
    on<AddNewItem>((event, emit) async {

      var s=await apiService.addItem(event.email,event.description,event.title,event.imgLink);
     if(s==true){
       var list=await apiService.fetchData("email@gmail.com");
       emit(DataState( datalist: list));

     }

    });
    on<DeleteItem>((event, emit) async {
    apiService.deleteItem(event.email, event.id);
      var list=await apiService.fetchData("email@gmail.com");
      emit(DataState( datalist: list));
    });

    on<EditItem>((event, emit) async {
      var b = await apiService.editItem(
          event.email, event.description, event.title, event.imgLink);
      if (b == true) {
        var list = await apiService.fetchData("email@gmail.com");
        emit(DataState(datalist: list));
      }
    });
  }
}
