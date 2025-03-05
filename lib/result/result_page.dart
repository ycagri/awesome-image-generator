import 'package:app/common/theme.dart';
import 'package:app/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../common/widget/base_scaffold.dart';

class ResultPage extends StatelessWidget {
  static const name = '/result';

  final String imageUrl;

  const ResultPage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) => BaseScaffold(
    title: AppLocalizations.of(context)!.appName,
    child: Stack(
      children: [
        Center(
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value:
                      loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.error,
                size: 50,
                color: Theme.of(context).primaryColor,
              );
            },
          ),
        ),
        _buildGenerateAnotherButton(context),
      ],
    ),
  );

  _buildGenerateAnotherButton(BuildContext context) => Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      width: double.infinity,
      margin: EdgeInsets.all(defaultSpacing),
      child: FilledButton(
        style: ButtonStyle(
          padding: WidgetStateProperty.all(EdgeInsets.all(defaultSpacing)),
        ),
        onPressed: () => context.goNamed(HomePage.name),
        child: Text(AppLocalizations.of(context)!.generateAnother),
      ),
    ),
  );
}
