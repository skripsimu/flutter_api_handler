import 'package:flutter/material.dart';
import 'package:flutter_api_handler/api/bloc/bloc.dart';
import 'package:flutter_api_handler/api/repositories/repositories.dart';
import 'package:flutter_api_handler/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPostMember extends StatelessWidget {
  final UserModel userModel;
  DetailPostMember(this.userModel);
  List<PostModel> postModel = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(userModel.name),
      ),
      body: BlocProvider(
        create: (context) => ApiBloc(methods: 'posts?userId=${userModel.id}', requestType: RequestType.GET, context: context),
        child: BlocBuilder<ApiBloc, ApiState>(
          builder: (context, state) {
            if (state is ApiEmpty) {
              BlocProvider.of<ApiBloc>(context).add(FetchApi());
            }
            if (state is ApiError) {
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
            if (state is ApiNetworkError) {
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
            if (state is ApiLoaded) {
              List item = state.response;
              item.forEach((element) {
                postModel.add(PostModel.fromJson(element));
              });
              return RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<ApiBloc>(context).add(FetchApi());
                },
                child: postModel.isNotEmpty ? ListView.builder(
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    return Container(
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
                          Text(postModel[index].title),
                          Text(postModel[index].body, style: TextStyle(color: Colors.grey, fontSize: 13)),
                        ],
                      ),
                    );
                  },
                ) : Center(
                  child: Text('${userModel.name} doesn\'t have any post'),
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
