

import 'package:flutter/material.dart';
import 'package:movie_app/presentation/themes/app_colors.dart';
import 'package:wiredash/wiredash.dart';

class WiredashApp extends StatelessWidget {
  const WiredashApp({super.key, required this.child, required this.languagecode});
  final Widget child;
  final String languagecode;

  @override
  Widget build(BuildContext context) {
    return Wiredash(
      projectId: 'movieapp-6wt3f3h',
      secret: 'xwZXilU_vVYWL2hjgqvrZcFzYHbBD0tY',
      options: WiredashOptionsData(
        locale: Locale.fromSubtags(languageCode: languagecode)
      ),
      theme: WiredashThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.royalblue,
        secondaryColor: AppColors.violet,
        secondaryBackgroundColor: AppColors.vulcan,
        // dividerColor: AppColors.vulcan,
      ),
      child: child,
    );
  }
}
