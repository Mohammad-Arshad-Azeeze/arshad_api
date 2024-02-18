part of 'data_bloc.dart';

 class DataState {
   List<DataModel>? datalist=[];

   DataState({ required this.datalist});
}

class DataInitial extends DataState {
  DataInitial({ required super.datalist});
}