
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