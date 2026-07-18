import 'package:flutter/material.dart';

import 'CustomTheme.dart';
// import '../theme/CustomTheme.dart'; // Adjust path if needed

class GradientScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool resizeToAvoidBottomInset;
  final bool extendBody;

  const GradientScaffold({
    Key? key,
    this.appBar,
    required this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset = true,
    this.extendBody = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: CustomTheme.backgroundGradient(isDark),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar,
        body: body,
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: bottomNavigationBar,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        extendBody: extendBody,
      ),
    );
  }
}
