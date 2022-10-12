import 'package:flutter/material.dart';
import 'package:procure_aqui/models/user.dart';

class UserProfileExclusion extends StatefulWidget {
  const UserProfileExclusion( {required this.user, super.key});
  
  final User user;


  @override
  State<UserProfileExclusion> createState() => _UserProfileExclusionState();
}

class _UserProfileExclusionState extends State<UserProfileExclusion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exclusão da conta'),
      ),
    );
  }
}