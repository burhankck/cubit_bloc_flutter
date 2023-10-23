import 'package:cubit_bloc_flutter/bloc/bloc_cats_view.dart';
import 'package:cubit_bloc_flutter/bloc/cats_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: MultiBlocProvider(providers: [
        BlocProvider(
          create: (context) => UserCubit(),
        ),
      ], child: BlocCatsView()),
    );
  }
}
