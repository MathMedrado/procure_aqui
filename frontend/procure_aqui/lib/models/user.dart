
class User{
  int id;
  String? username;
  String? city;
  String? state;
  String? email;
  String? password;
  String? sex;
  DateTime? birthDate;

  User({
    required this.id, 
    required this.username,
    required this.city, 
    required this.email, 
    required this.password, 
    required this.sex, 
    required this.birthDate,
    required this.state
  });

  factory User.fromJson(Map json){
    return User(
      id: json['id'], 
      username: json['username'], 
      city: json['city'], 
      email: json['email'], 
      password: json['password'], 
      sex: json['sex'], 
      birthDate: json['birthDate'], 
      state: json['state']
    );
  }

  Map toJson(){
    return {
      'id': id,
      'username' : username,
      'city' : city,
      'email' : email,
      'password' : password,
      'sex' : sex,
      'birthDate' : birthDate,
      'state' : state
    };
  }
  int get getId{
    return id;
  }

  String? get getUsername{
    return username;
  }

  String? get getEmail{
    return email;
  }

  String? get getPassword{
    return password;
  }

  String? get getSex{
    return sex;
  }

  String? get getCity{
    return city;
  }

  String? get getState{
    return state;
  }
 
  DateTime? get getBirthDate{
    return birthDate;
  }

}