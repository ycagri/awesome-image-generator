import 'dart:async';

import 'package:app/common/bloc_state.dart';
import 'package:app/common/injection.dart';
import 'package:app/home/home_bloc.dart';
import 'package:app/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../common/test_app.dart';
import 'home_page_test.mocks.dart';

@GenerateNiceMocks([MockSpec<HomePageCubit>(), MockSpec<GoRouter>()])
void main() {
  final router = MockGoRouter();
  final homeCubit = MockHomePageCubit();

  group('HomePageTests', () {
    setUp(() {
      getIt.registerFactory<HomePageCubit>(() => homeCubit);
    });

    tearDown(() {
      getIt.reset();
      clearInteractions(homeCubit);
      clearInteractions(router);
    });

    testWidgets('InitialScreenTest', (WidgetTester tester) async {
      when(
        homeCubit.state,
      ).thenAnswer((_) => HomePageState(isLoading: false, canGenerate: false));
      await tester.pumpWidget(
        wrapForTesting(router: router, child: HomePage()),
      );
      expect(find.text('Welcome to Imagify'), findsOneWidget);
      expect(
        find.text('Please fill the below fields to generate image'),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is TextField &&
              widget.decoration?.hintText ==
                  'Please provide a label for the image',
        ),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is TextField &&
              widget.decoration?.hintText ==
                  'Please provide a description for the image',
        ),
        findsOneWidget,
      );
      await tester.tap(find.text('Generate'));
      verifyNever(homeCubit.generate(any, any));
    });

    testWidgets('GenerationEnabledTest', (WidgetTester tester) async {
      when(
        homeCubit.state,
      ).thenAnswer((_) => HomePageState(isLoading: false, canGenerate: true));
      await tester.pumpWidget(
        wrapForTesting(router: router, child: HomePage()),
      );
      expect(find.text('Welcome to Imagify'), findsOneWidget);
      expect(
        find.text('Please fill the below fields to generate image'),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is TextField &&
              widget.decoration?.hintText ==
                  'Please provide a label for the image',
        ),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is TextField &&
              widget.decoration?.hintText ==
                  'Please provide a description for the image',
        ),
        findsOneWidget,
      );

      await tester.enterText(find.byKey(Key('label')), 'label');
      verify(homeCubit.onTextChanged(false)).called(1);
      await tester.enterText(find.byKey(Key('description')), 'description');
      verify(homeCubit.onTextChanged(true)).called(1);
      await tester.tap(find.text('Generate'));
      verify(homeCubit.generate('label', 'description'));
    });

    testWidgets('LoadingScreenTest', (WidgetTester tester) async {
      when(
        homeCubit.state,
      ).thenAnswer((_) => HomePageState(isLoading: true, canGenerate: true));
      await tester.pumpWidget(
        wrapForTesting(router: router, child: HomePage()),
      );
      expect(find.text('Welcome to Imagify'), findsNothing);
      expect(
        find.text('Please fill the below fields to generate image'),
        findsNothing,
      );
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is TextField &&
              widget.decoration?.hintText ==
                  'Please provide a label for the image' &&
              widget.enabled == false,
        ),
        findsNothing,
      );
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is TextField &&
              widget.decoration?.hintText ==
                  'Please provide a description for the image',
        ),
        findsNothing,
      );
      expect(find.text('Generate'), findsNothing);
    });

    testWidgets('ErrorTest', (WidgetTester tester) async {
      final streamController = StreamController<HomePageState>.broadcast();
      when(
        homeCubit.state,
      ).thenAnswer((_) => HomePageState(isLoading: false, canGenerate: false));
      when(homeCubit.stream).thenAnswer((_) => streamController.stream);
      await tester.pumpWidget(
        wrapForTesting(router: router, child: HomePage()),
      );
      streamController.add(
        HomePageState(
          isLoading: false,
          canGenerate: true,
          error: 'Test error!',
        ),
      );
      await tester.pump();
      expect(find.text('Welcome to Imagify'), findsOneWidget);
      expect(
        find.text('Please fill the below fields to generate image'),
        findsOneWidget,
      );
      expect(find.text('Generate'), findsOneWidget);
      expect(find.text('Test error!'), findsOneWidget);
    });
  });
}
