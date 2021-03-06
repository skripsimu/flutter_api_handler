import 'package:flutter/material.dart';
import 'package:flutter_api_handler/api/repositories/repositories.dart';
import 'package:flutter_api_handler/models/models.dart';
import 'package:flutter_api_handler/views/detail_post_member.dart';
import 'package:flutter_api_handler/views/post_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_api_handler/api/bloc/bloc.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api Handler'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PostScreen()));
        },
        child: Icon(Icons.drive_file_move, color: Colors.white,),
      ),
      body: BlocProvider(
        create: (context) => ApiBloc(methods: 'users', requestType: RequestType.GET, context: context),
        child: BlocBuilder<ApiBloc, ApiState>(
          builder: (context, state) {
            if (state is IsEmpty) {
              BlocProvider.of<ApiBloc>(context).add(FetchApi());
            }
            if (state is IsError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text('Error connection with server, please try again later')),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<ApiBloc>(context).add(FetchApi());
                      },
                      child: Text('Reload', style: TextStyle(decoration: TextDecoration.underline),),
                    ),
                  )
                ],
              );
            }
            if (state is IsNetworkError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text('No internet connection, please try again later')),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<ApiBloc>(context).add(FetchApi());
                      },
                      child: Text('Reload', style: TextStyle(decoration: TextDecoration.underline),),
                    ),
                  )
                ],
              );
            }
            if (state is IsLoaded) {
              List<UserModel> userModel = [];
              List item = state.response;
              item.forEach((element) {
                userModel.add(UserModel.fromJson(element));
              });
              return RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<ApiBloc>(context).add(FetchApi());
                },
                child: userModel.isNotEmpty ? ListView.builder(
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPostMember(userModel[index])));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(color: Colors.grey),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(userModel[index].name),
                            Text(userModel[index].website + ' | ' + userModel[index].email, style: TextStyle(color: Colors.grey, fontSize: 13)),
                          ],
                        ),
                      ),
                    );
                  },
                ) : Center(
                  child: Text('There are no members available to you at this time'),
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
