import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_sample_project/feature/common/view/post/viewmodel/post_view_model.dart';

class PostView extends StatelessWidget {
  PostView({Key? key}) : super(key: key);
  final _viewModel = PostViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFAB(),
      appBar: AppBar(),
      body: _buildBody(),
    );
  }

  Center _buildBody() {
    return Center(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Observer(builder: (_) {
            return _viewModel.isServiceRequest ? const CircularProgressIndicator() : _buildListView();
          })
        ],
      ),
    ));
  }

  ListView _buildListView() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _buildListItem(index);
      },
      itemCount: _viewModel.posts.length,
    );
  }

  ListTile _buildListItem(int index) {
    return ListTile(
      title: Text(_viewModel.posts[index].title!),
      subtitle: Text(_viewModel.posts[index].body!),
    );
  }

  FloatingActionButton _buildFAB() {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () => _viewModel.getAllPost(),
    );
  }
}
