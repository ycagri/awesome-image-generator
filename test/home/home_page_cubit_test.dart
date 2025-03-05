import 'package:app/common/bloc_state.dart';
import 'package:app/common/request.dart';
import 'package:app/home/home_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_page_cubit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<RequestHandler>()])
void main() {
  final requestHandler = MockRequestHandler();

  group('HomeCubitGenerateTest', () {
    blocTest<HomePageCubit, HomePageState>(
      'GenerateTest',
      build: () => HomePageCubit(requestHandler),
      setUp:
          () => when(
            requestHandler.generateImage('label', 'description'),
          ).thenAnswer((_) => Future.value('https://test/image.png')),
      tearDown: () {
        clearInteractions(requestHandler);
      },
      act: (bloc) => bloc.generate('label', 'description'),
      expect:
          () => [
            HomePageState(isLoading: true, canGenerate: false, imageUrl: null),
            HomePageState(
              isLoading: true,
              canGenerate: false,
              imageUrl: 'https://test/image.png',
            ),
          ],
      verify: (_) {
        verify(requestHandler.generateImage('label', 'description')).called(1);
        verifyNoMoreInteractions(requestHandler);
      },
    );

    blocTest<HomePageCubit, HomePageState>(
      'GenerateErrorTest',
      build: () => HomePageCubit(requestHandler),
      setUp:
          () => when(
            requestHandler.generateImage('label', 'description'),
          ).thenAnswer((_) => Future.error('Test error!')),
      tearDown: () {
        clearInteractions(requestHandler);
      },
      act: (bloc) => bloc.generate('label', 'description'),
      expect:
          () => [
            HomePageState(isLoading: true, canGenerate: false, imageUrl: null),
            HomePageState(
              isLoading: false,
              canGenerate: false,
              imageUrl: null,
              error: 'Test error!',
            ),
          ],
      verify: (_) {
        verify(requestHandler.generateImage('label', 'description')).called(1);
        verifyNoMoreInteractions(requestHandler);
      },
    );

    blocTest<HomePageCubit, HomePageState>(
      'OnTextChangedFalseTest',
      build: () => HomePageCubit(requestHandler),
      tearDown: () {
        clearInteractions(requestHandler);
      },
      act: (bloc) => bloc.onTextChanged(false),
      expect:
          () => [
            HomePageState(isLoading: false, canGenerate: false, imageUrl: null),
          ],
    );

    blocTest<HomePageCubit, HomePageState>(
      'OnTextChangedTrueTest',
      build: () => HomePageCubit(requestHandler),
      tearDown: () {
        clearInteractions(requestHandler);
      },
      act: (bloc) => bloc.onTextChanged(true),
      expect:
          () => [
            HomePageState(isLoading: false, canGenerate: true, imageUrl: null),
          ],
    );
  });
}
