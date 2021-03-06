import 'package:flutter/material.dart';
import 'package:flutter_api_handler/api/bloc/bloc.dart';
import 'package:flutter_api_handler/api/repositories/repositories.dart';
import 'package:flutter_api_handler/common/common.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post Screen'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: BlocProvider(
              create: (context) => ApiBloc(methods: 'albums', requestType: RequestType.POST, context: context, onSuccess: () {
                Utility.customToast(context, message: 'Post Successfully!', color: Colors.green);
              }),
              child: BlocBuilder<ApiBloc, ApiState>(
                builder: (context, state) {
                  return RaisedButton(
                    onPressed: () {
                      if (state is IsEmpty || state is IsError  || state is IsNetworkError ) {
                        BlocProvider.of<ApiBloc>(context).add(FetchApi());
                      } else if (state is IsLoaded) {
                        Navigator.pop(context);
                      }
                    },
                    color: Colors.blue,
                    child: state is IsLoading ? Container(height: 20, width: 20, child: CircularProgressIndicator(backgroundColor: Colors.white,)) : state is IsLoaded ? Text('Done', style: TextStyle(color: Colors.white),) : Text('Post', style: TextStyle(color: Colors.white),),
                  );
                },
              )
            ),
          ),
        ],
      ),
    );
  }
}
