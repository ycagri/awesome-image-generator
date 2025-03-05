import 'package:app/common/theme.dart';
import 'package:app/common/widget/base_scaffold.dart';
import 'package:app/common/widget/shimmer_loading_widget.dart';
import 'package:app/result/result_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../common/bloc_state.dart';
import '../common/injection.dart';
import 'home_bloc.dart';

class HomePage extends StatelessWidget {
  static const name = '/';

  HomePage({super.key});

  final TextEditingController _labelTextController = TextEditingController();
  final TextEditingController _descriptionTextController =
      TextEditingController();

  @override
  Widget build(BuildContext context) => BlocProvider<HomePageCubit>(
    create: (_) => getIt<HomePageCubit>(),
    child: BlocConsumer<HomePageCubit, HomePageState>(
      builder:
          (context, state) => BaseScaffold(
            title: AppLocalizations.of(context)!.appName,
            child: Shimmer(
              linearGradient: shimmerGradient,
              child: Center(
                child: FractionallySizedBox(
                  widthFactor: 0.95,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(defaultSpacing * 2),
                      child: Wrap(
                        runSpacing: defaultSpacing,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildTextField(
                            AppLocalizations.of(context)!.welcome,
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            state.isLoading,
                          ),
                          _buildTextField(
                            AppLocalizations.of(context)!.fillTheInput,
                            Theme.of(context).textTheme.bodyLarge,
                            state.isLoading,
                          ),
                          _buildInputField(
                            Key('label'),
                            context,
                            AppLocalizations.of(context)!.labelHint,
                            _labelTextController,
                            state.isLoading,
                          ),
                          _buildInputField(
                            Key('description'),
                            context,
                            AppLocalizations.of(context)!.descriptionHint,
                            _descriptionTextController,
                            state.isLoading,
                          ),
                          _buildSaveButton(
                            context,
                            state.canGenerate,
                            state.isLoading,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      listener: (context, state) {
        if (state.imageUrl != null) {
          context.goNamed(ResultPage.name, extra: state.imageUrl);
        } else if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error!),
              duration: Duration(seconds: 5),
            ),
          );
        }
      },
    ),
  );

  _buildTextField(String text, TextStyle? style, bool isLoading) =>
      ShimmerLoading(
        isLoading: isLoading,
        child: Text(text, style: style, textAlign: TextAlign.center),
      );

  _buildInputField(
    Key key,
    BuildContext context,
    String? hint,
    TextEditingController? controller,
    bool isLoading,
  ) => ShimmerLoading(
    isLoading: isLoading,
    child: TextField(
      key: key,
      enabled: !isLoading,
      controller: controller,
      style: Theme.of(
        context,
      ).textTheme.bodyLarge?.copyWith(color: Colors.black),
      onChanged:
          (text) => context.read<HomePageCubit>().onTextChanged(
            _labelTextController.text.isNotEmpty &&
                _descriptionTextController.text.isNotEmpty,
          ),
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: EdgeInsets.all(defaultSpacing),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), // Rounded corners
        ),
      ),
      cursorColor: Colors.black,
      keyboardType: TextInputType.text,
    ),
  );

  _buildSaveButton(BuildContext context, bool canGenerate, bool isLoading) =>
      Align(
        alignment: Alignment.bottomCenter,
        child: ShimmerLoading(
          isLoading: isLoading,
          child: SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all(
                  EdgeInsets.all(defaultSpacing),
                ),
              ),
              onPressed:
                  !isLoading && canGenerate
                      ? () => context.read<HomePageCubit>().generate(
                        _labelTextController.text,
                        _descriptionTextController.text,
                      )
                      : null,
              child: Text(AppLocalizations.of(context)!.generate),
            ),
          ),
        ),
      );
}
