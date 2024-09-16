import 'package:car_dealership/di/setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_bloc.dart';
import 'home_screen_content.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocProvider(
        create: (context) => getIt<HomeBloc>()..loadBasicData(),
        child: HomePageContent(),
      ),
    ));
  }
}
