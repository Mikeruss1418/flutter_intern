// import 'package:flutter/material.dart';
// import 'package:wiredash/wiredash.dart';
// //

// class WiredashApp extends StatelessWidget {
//   final navigatorKey;
//   final Widget child;
//   final String languageCode;

//   const WiredashApp({
//     Key key,
//     @required this.navigatorKey,
//     @required this.child,
//     @required this.languageCode,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Wiredash(
//       projectId: 'movie-app-tutorial-k1xtma1',
//       secret: 'wsmigg476q5l4k9mz2njmob4puuuwt58',
//       navigatorKey: navigatorKey,
//       child: child,
//       options: WiredashOptionsData(
//         showDebugFloatingEntryPoint: false,
//         locale: Locale.fromSubtags(
//           languageCode: languageCode,
//         ),
//       ),
//       theme: WiredashThemeData(
//         brightness: Brightness.dark,
//         primaryColor: AppColors.royalBlue,
//         secondaryColor: AppColors.violet,
//         secondaryBackgroundColor: AppColors.vulcan,
//         dividerColor: AppColors.vulcan,
//       ),
//     );
//   }
// }

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
      child: child,
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
    );
  }
}
