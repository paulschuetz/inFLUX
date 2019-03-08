import 'package:meta/meta.dart';

class ContactData{
  final String firstName;
  final String lastName;
  final int age;

  ContactData({@required this.firstName, @required this.lastName, @required this.age}){
    if(firstName == null || firstName == "") throw ArgumentError("firstName can not be null or empty");
    if(lastName == null || lastName == "") throw ArgumentError("lastName can not be null or empty");
    if(age < 0) throw ArgumentError("age can not be a negative number");
  }
}