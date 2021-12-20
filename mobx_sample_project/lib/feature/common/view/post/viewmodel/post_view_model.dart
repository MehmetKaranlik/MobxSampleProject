import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_sample_project/feature/common/view/post/model/post_model.dart';

part 'post_view_model.g.dart';

class PostViewModel = _PostViewModelBase with _$PostViewModel;

abstract class _PostViewModelBase with Store {
  final url = "https://jsonplaceholder.typicode.com/posts";
  @observable
  List<PostModel> posts = [];
  @observable
  bool isServiceRequest = false;
  
  @action
  Future<void> getAllPost() async {
    changeLoadingState();
    final response = await Dio().get(url);
    if (response.statusCode == HttpStatus.ok && response.data != null) {
      final bodyItems = response.data as List;
      posts = bodyItems.map((e) => PostModel.fromMap(e)).toList();
      changeLoadingState();
    }
  }

  @action
  void changeLoadingState() {
    isServiceRequest = !isServiceRequest;
  }
}
