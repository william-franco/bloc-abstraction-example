import 'package:bloc_abstraction_example/src/common/dependency_injectors/dependency_injector.dart';
import 'package:bloc_abstraction_example/src/common/states/state.dart';
import 'package:bloc_abstraction_example/src/common/widgets/refresh_button_widget.dart';
import 'package:bloc_abstraction_example/src/common/widgets/refresh_indicator_widget.dart';
import 'package:bloc_abstraction_example/src/common/widgets/skeleton_refresh_widget.dart';
import 'package:bloc_abstraction_example/src/common/widgets/state_builder_widget.dart';
import 'package:bloc_abstraction_example/src/features/settings/routes/setting_routes.dart';
import 'package:bloc_abstraction_example/src/features/users/controllers/user_controller.dart';
import 'package:bloc_abstraction_example/src/features/users/models/user_model.dart';
import 'package:bloc_abstraction_example/src/features/users/routes/user_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  late final UserController userController;

  @override
  void initState() {
    super.initState();
    userController = locator<UserController>();
    userController.getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Users'),
        actions: [
          RefreshButtonWidget(
            onPressed: () async {
              await userController.getAllUsers();
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              context.push(SettingRoutes.setting);
            },
          ),
        ],
      ),
      body: Center(
        child: RefreshIndicatorWidget(
          onRefresh: () async {
            await userController.getAllUsers();
          },
          child: StateBuilderWidget<UserController, AppState<List<UserModel>>>(
            controller: userController,
            builder: (context, userState, widget) {
              return switch (userState) {
                InitialState() => const Text('List is empty.'),
                LoadingState() => ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return const SkeletonRefreshWidget();
                  },
                ),
                SuccessState(data: final users) => ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (BuildContext context, int index) {
                    final user = users[index];
                    return InkWell(
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(user.name![0].toUpperCase()),
                          ),
                          title: Text(user.name ?? ''),
                          subtitle: Text(user.email ?? ''),
                        ),
                      ),
                      onTap: () {
                        context.push(UserRoutes.userDetail, extra: user);
                      },
                    );
                  },
                ),
                ErrorState(message: final message) => Text(message),
              };
            },
          ),
        ),
      ),
    );
  }
}
