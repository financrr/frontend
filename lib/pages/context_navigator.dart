import 'package:financrr_frontend/pages/auth/server_info_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restrr/restrr.dart';

import '../data/host_repository.dart';
import '../layout/adaptive_scaffold.dart';
import '../router.dart';
import '../util/input_utils.dart';
import 'core/dashboard_page.dart';

class ContextNavigatorPage extends StatefulWidget {
  static const PagePathBuilder pagePath = PagePathBuilder('/');

  const ContextNavigatorPage({super.key});

  static PageRoute<T> pageRoute<T>() {
    return MaterialPageRoute(builder: (_) => const ContextNavigatorPage());
  }

  @override
  State<StatefulWidget> createState() => ContextNavigatorPageState();
}

class ContextNavigatorPageState extends State<ContextNavigatorPage> {

  @override
  void initState() {
    super.initState();
    _navigate();
  }

  /// Navigates the user to the correct route, based on whether the user is
  /// already logged in.
  Future _navigate() async {
    await Future.delayed(Duration(seconds: 3));
    // try to fetch user (user may still be logged in)
    final String hostUrl = HostService.get().hostUrl;
    if (hostUrl.isNotEmpty && InputValidators.url(context, hostUrl) == null) {
      final RestResponse<Restrr> response = await (RestrrBuilder.savedSession(uri: Uri.parse(hostUrl))..options = const RestrrOptions(isWeb: kIsWeb))
          .create();
      if (!mounted) return;
      if (response.hasData) {
        context.authNotifier.setApi(response.data);
        context.pushPath(DashboardPage.pagePath.build());
        return;
      } else {
        print('Failed resuming previous session: ${response.error?.name}');
      }
    }
    context.pushPath(ServerInfoPage.pagePath.build());
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(backgroundColor: Colors.red, verticalBuilder: (_, __, size) => const Center(child: CircularProgressIndicator()));
  }
}