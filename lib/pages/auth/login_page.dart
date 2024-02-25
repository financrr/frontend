import 'dart:async';
import 'dart:math';

import 'package:financrr_frontend/data/host_repository.dart';
import 'package:financrr_frontend/main.dart';
import 'package:financrr_frontend/pages/core/dashboard_page.dart';
import 'package:financrr_frontend/themes.dart';
import 'package:financrr_frontend/util/extensions.dart';
import 'package:financrr_frontend/util/input_formatters.dart';
import 'package:financrr_frontend/util/text_utils.dart';
import 'package:financrr_frontend/widgets/animations/zoom_tap_animation.dart';
import 'package:financrr_frontend/widgets/async_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restrr/restrr.dart';

import '../../layout/adaptive_scaffold.dart';
import '../../router.dart';

class LoginPage extends StatefulWidget {
  static const PagePathBuilder pagePath = PagePathBuilder('/login');

  final String? redirectTo;

  const LoginPage({super.key, this.redirectTo});

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  late final AppLocalizations _locale = context.locale;
  late final TextTheme _textTheme = Theme.of(context).textTheme;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final MaterialStatesController _signInButtonStatesController = MaterialStatesController();

  final int _random = Random().nextInt(4) + 1;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      resizeToAvoidBottomInset: false,
      verticalBuilder: (_, __, size) => SafeArea(child: _buildVerticalLayout(size)),
    );
  }

  Widget _buildVerticalLayout(Size size) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
            child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.2,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ZoomTapAnimation(
                      onTap: () => FinancrrApp.of(context)
                          .changeAppTheme(theme: context.lightMode ? AppThemes.dark() : AppThemes.light()),
                      child: Icon(context.lightMode ? Icons.nightlight_round : Icons.wb_sunny)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SvgPicture.asset(context.appTheme.logoPath, width: 100),
            ),
           Text(
             style: _textTheme.titleLarge?.copyWith(color: context.theme.primaryColor),
                switch (_random) {
                  1 => _locale.signInMessage1,
                  2 => _locale.signInMessage2,
                  3 => _locale.signInMessage3,
                  4 => _locale.signInMessage4,
                  _ => _locale.signInMessage5,
                }),
            Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                    autofillHints: const [AutofillHints.username],
                  ),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      labelText: _locale.genericPassword,
                      suffixIcon: IconButton(
                          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                          onPressed: () => setState(() => _obscureText = !_obscureText))),
                  obscureText: _obscureText,
                  inputFormatters: [InputFormatters.password],
                  autofillHints: const [AutofillHints.password, AutofillHints.newPassword],
                ),
              ],
            )),
            Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _handleLogin,
                    statesController: _signInButtonStatesController,
                    child: Text(_locale.signInButton),
                  ),
                )),
          ]),
        )));
  }

  Widget _buildHostSection({RestResponse<HealthResponse>? response}) {
    final HostPreferences preferences = HostService.get();
    final String statusText = response == null
        ? 'Checking /api/status/health...'
        : response.hasData
            ? response.data!.healthy
                ? 'Healthy, API v${response.data!.apiVersion}'
                : response.data!.details ?? 'Unhealthy, check server logs'
            : 'Could not reach host';
    final IconData statusIcon = response == null
        ? Icons.access_time_outlined
        : response.hasData && response.data!.healthy
            ? Icons.check
            : Icons.warning_amber;
    return Column(
      children: [
        ZoomTapAnimation(
          child: Text(style: _textTheme.bodyMedium, preferences.hostUrl.isEmpty ? 'Click to select Host' : preferences.hostUrl),
        ),
        if (preferences.hostUrl.isNotEmpty)
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Icon(statusIcon, size: 15),
              ),
              Text(style: context.textTheme.labelSmall, statusText),
            ],
          ),
      ],
    );
  }

  Future<void> _handleLogin() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;
    if (username.isEmpty || password.isEmpty) {
      return;
    }
    final RestResponse<Restrr> response =
        await RestrrBuilder.login(uri: Restrr.hostInformation.hostUri!, username: username, password: password)
            .create();
    if (!mounted) return;
    if (response.hasData) {
      context.authNotifier.setApi(response.data!);
      context.goPath(DashboardPage.pagePath.build());
    } else {
      context.showSnackBar(response.error!.name);
    }
  }
}
