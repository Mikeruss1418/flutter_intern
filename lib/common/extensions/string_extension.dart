import 'package:flutter/material.dart';
import 'package:movie_app/presentation/app_localization.dart';

extension StringExtension on String {
  String toolongtrim() {
    return length > 15 ? '${substring(0, 15)}...' : this;
  }
   String t(BuildContext context) {
    return AppLocalizations.of(context)!.translate(this) ?? this;
  }
}
