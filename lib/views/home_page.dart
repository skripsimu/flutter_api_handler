import 'package:flutter/material.dart';
import 'package:flutter_api_handler/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_api_handler/api/bloc/bloc.dart';
import 'package:flutter_api_handler/api/repositories/repositories.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api Request Example'),
      ),
      body: BlocProvider(
        create: (context) => ApiBloc(methods: 'users', requestType: RequestType.GET),
        child: BlocBuilder<ApiBloc, ApiState>(
          builder: (context, state) {
            if (state is ApiEmpty) {
              BlocProvider.of<ApiBloc>(context).add(FetchApi());
            }
            if (state is ApiError) {
              return Center(
                child: Text('failed to fetch Api'),
              );
            }
            if (state is ApiLoaded) {
              List<UserModel> userModel = [];
              List item = state.response;
              item.forEach((element) {
                userModel.add(UserModel.fromJson(element));
              });
              return RefreshIndicator(
                onRefresh: () {
                  print('aaaaaaaaaaaaaaaaaaa');
                  return;
                },
                child: userModel.isNotEmpty ? ListView.builder(
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    return Text(userModel[index].name);
                  },
                ) : Center(
                  child: Text('Member is empty'),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
