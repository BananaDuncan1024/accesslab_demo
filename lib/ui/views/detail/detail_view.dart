import 'package:accesslab_demo/request/github/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'detail_viewmodel.dart';

class DetailView extends StackedView<DetailViewModel> {
  final UserModel userModel;

  const DetailView(this.userModel, {super.key});

  @override
  void onViewModelReady(DetailViewModel viewModel) {
    viewModel.init(userModel);
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    DetailViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: viewModel.isBusy
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : UserDetailCreate(viewModel: viewModel),
    );
  }

  @override
  DetailViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DetailViewModel();
}

class UserDetailCreate extends StatefulWidget {
  final DetailViewModel viewModel;

  const UserDetailCreate({super.key, required this.viewModel});
  @override
  State<StatefulWidget> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetailCreate> {
  bool _isEditing = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            widget.viewModel.pop();
          },
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit,
                color: Colors.black),
            onPressed: () {
              setState(() {
                if (_isEditing) {
                  // userName = widget.viewModel.nameController.text;
                  widget.viewModel
                      .setName(widget.viewModel.nameController.text);
                }
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  NetworkImage(widget.viewModel.userDetailModel.avatarUrl),
            ),
            const SizedBox(height: 8),
            _isEditing
                ? TextField(
                    controller: widget.viewModel.nameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your name',
                    ),
                  )
                : Text(
                    widget.viewModel.userDetailModel.name ?? '',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            const SizedBox(height: 4),
            Text(
              widget.viewModel.userDetailModel.bio ?? '',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const Divider(height: 32, thickness: 1),
            Row(
              children: [
                const Icon(Icons.person, size: 24),
                const SizedBox(width: 8),
                Text(widget.viewModel.userDetailModel.login,
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                if (widget.viewModel.userDetailModel.siteAdmin)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'STAFF',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.location_on, size: 24),
                const SizedBox(width: 8),
                Text(widget.viewModel.userDetailModel.location ?? '',
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.link, size: 24),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    widget.viewModel
                        .launchURL(widget.viewModel.userDetailModel.blog!);
                  },
                  child: Text(
                    widget.viewModel.userDetailModel.blog ?? '',
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
