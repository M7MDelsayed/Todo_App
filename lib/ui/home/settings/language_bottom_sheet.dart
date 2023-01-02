import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../providers/settings_provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheet();
}

class _LanguageBottomSheet extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              settingsProvider.changeLanguage('ar');
            },
            child: settingsProvider.isArabic()
                ? getSelectedItem(
                    AppLocalizations.of(context)!.arabic,
                  )
                : getUnselectedItem(
                    AppLocalizations.of(context)!.arabic,
                  ),
          ),
          const SizedBox(
            height: 12,
          ),
          InkWell(
            onTap: () {
              settingsProvider.changeLanguage('en');
            },
            child: settingsProvider.isArabic()
                ? getUnselectedItem(
                    AppLocalizations.of(context)!.english,
                  )
                : getSelectedItem(
                    AppLocalizations.of(context)!.english,
                  ),
          ),
        ],
      ),
    );
  }

  Widget getSelectedItem(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline6?.copyWith(
                color: Theme.of(context).primaryColor,
              ),
        ),
        Icon(
          Icons.check,
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }

  Widget getUnselectedItem(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline6,
    );
  }
}
