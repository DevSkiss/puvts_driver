import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puvts_driver/core/constants/puvts_colors.dart';
import 'package:puvts_driver/features/profile/domain/bloc/profile_bloc.dart';
import 'package:puvts_driver/features/profile/domain/bloc/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: puvtsWhite,
            centerTitle: true,
            title: Text(
              'Profile',
              style: TextStyle(color: puvtsBlue),
            ),
            elevation: 0,
            toolbarHeight: 70,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'First Name: ${state.user?.firstname}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Last Name: ${state.user?.lastname}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Email: ${state.user?.email}',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
