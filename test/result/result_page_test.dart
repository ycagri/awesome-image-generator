import 'package:app/result/result_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../common/extensions.dart';
import '../common/test_app.dart';
import 'result_page_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GoRouter>()])
void main() {
  final router = MockGoRouter();

  group('ResultPageTests', () {
    tearDown(() {
      clearInteractions(router);
    });

    testWidgets('GenerateAnotherTest', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapForTesting(
          router: router,
          child: ResultPage(
            imageUrl:
                'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bd/Test.svg/2560px-Test.svg.png',
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(
        find.byUrl(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bd/Test.svg/2560px-Test.svg.png',
        ),
        findsOneWidget,
      );
      expect(find.text('Generate Another'), findsOneWidget);
      await tester.tap(find.text('Generate Another'));
      verify(router.goNamed('/')).called(1);
    });
  });
}
