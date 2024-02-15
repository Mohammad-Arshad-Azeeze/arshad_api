part of 'data_bloc.dart';


abstract class DataEvent {}
class Fetchall extends DataEvent{
  late String email;

  Fetchall({required this.email});
}
class AddNewItem extends DataEvent {
  final String email;
  final String description;
  final String title;
  final String imgLink;

  AddNewItem({
    required this.email,
    required this.description,
    required this.title,
    required this.imgLink,
  });

  @override
  List<Object?> get props => [email, description, title, imgLink];
}
class DeleteItem extends DataEvent {
  final String email;
  final num id;


  DeleteItem({
    required this.email,
    required this.id

  });
}