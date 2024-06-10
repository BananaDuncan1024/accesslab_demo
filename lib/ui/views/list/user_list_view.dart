import 'package:accesslab_demo/ui/views/list/user_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class UserListView extends StackedView<UserListViewModel> {
  const UserListView({super.key});

  @override
  void onViewModelReady(UserListViewModel viewModel) {
    viewModel.init();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    UserListViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: viewModel.isBusy
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                    child: CreateListView(viewModel: viewModel),
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Number of items: ${viewModel.userModel.length}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ));
  }

  @override
  UserListViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      UserListViewModel();
}

class CreateListView extends StatefulWidget {
  final UserListViewModel viewModel;

  const CreateListView({super.key, required this.viewModel});

  @override
  State<StatefulWidget> createState() => CreateListViewState();
}

class CreateListViewState extends State<CreateListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.viewModel.userModel.length,
        itemBuilder: (context, index) {
          // final user = widget.viewModel.userModel[index];
          return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
              child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          widget.viewModel.userModel[index].avatarUrl),
                    ),
                    onTap: () {
                      widget.viewModel.navigateToDetailPage(
                          widget.viewModel.userModel[index]);
                    },
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.viewModel.userModel[index].login),
                        if (widget.viewModel.userModel[index].siteAdmin)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
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
                  ))
              // separatorBuilder: (BuildContext context, int index) => const Divider(),
              );
        });
  }
}
