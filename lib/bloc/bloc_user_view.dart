import 'package:cubit_bloc_flutter/bloc/cats_cubit.dart';
import 'package:cubit_bloc_flutter/bloc/cats_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocCatsView extends StatefulWidget {
  const BlocCatsView({super.key});

  @override
  State<BlocCatsView> createState() => _BlocCatsViewState();
}

class _BlocCatsViewState extends State<BlocCatsView> with _PageProperties {
  @override
  void initState() {
    _initCubits();
    super.initState();
  }

  void _initCubits() {
    _catsCubit = context.read<UserCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          _catsCubit.emitInitial();
          return true;
        },
        child: buildScaffold(context));
  }

  Scaffold buildScaffold(BuildContext context) => Scaffold(
        appBar: AppBar(title: Center(child: Text('Flutter Bloc'))),
        body: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserError) {
              Scaffold.of(context).showBottomSheet((context) => Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(state.message)));
            }
          },
          builder: (context, state) {
            debugPrint(state.toString());
            if (state is CatsInitial) {
              return CatsInitialWidget(context);
            } else if (state is UserLoading) {
              return CatsLoadingWidget();
            } else if (state is UserCompleted) {
              return CatsCompletedWidget(state);
            } else {
              final error = state as UserError;
              return Text(error.message);
            }
          },
        ),
      );

  ListView CatsCompletedWidget(UserCompleted state) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
            child: Column(
          children: [
            Text(state.userModelList[index]!.name),
            Text(state.userModelList[index]!.surName),
            Text(state.userModelList[index]!.age.toString()),
          ],
        ));
      },
      itemCount: state.userModelList.length,
    );
  }

  Center CatsLoadingWidget() {
    return const Center(
      child: CircularProgressIndicator(color: Colors.black),
    );
  }

  Center CatsInitialWidget(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 200),
          const Text('Click Button'),
          SizedBox(height: 20),
          buttonCall(context),
        ],
      ),
    );
  }

  FloatingActionButton buttonCall(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.clear_all),
      onPressed: () async {
        await _catsCubit.getCats();
      },
    );
  }
}

mixin _PageProperties {
  late UserCubit _catsCubit;
}
