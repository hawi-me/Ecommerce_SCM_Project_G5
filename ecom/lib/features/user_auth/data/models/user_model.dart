import 'package:ecommerce_app_ca_tdd/features/user_auth/domain/entities/user_entitiy.dart';


class UserModel extends UserEntity{
  const UserModel({                        
    required String id,
    required String name, required String email, required String password,
    }) : super(id:id,name: name, email: email, password: password);


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      // TO be deleteed
      id : json['_id'],
      name: json['name'],
      email: json['email'],
      password: json['password']?? '',
      
    );
  }

  
  Map<String, String> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password ?? '',
      // 'access_token': '',
    };
  }
  


// ignore: empty_constructor_bodies
}