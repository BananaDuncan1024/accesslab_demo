import 'package:accesslab_demo/request/github/github_service.dart';
import 'package:accesslab_demo/services/api_service.dart';
import 'package:accesslab_demo/services/auth_service.dart';
import 'package:accesslab_demo/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:accesslab_demo/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:accesslab_demo/ui/views/detail/detail_view.dart';
import 'package:accesslab_demo/ui/views/list/user_list_view.dart';
import 'package:accesslab_demo/ui/views/login/login_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: LoginView),
    MaterialRoute(page: DetailView),
    MaterialRoute(page: UserListView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: ApiService),
    LazySingleton(classType: GithubService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
  logger: StackedLogger(),
)
class App {}
