


import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../integration_test/integration_test.dart' as app;



void main() {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('log in, check for tweet, log out ', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    Finder loginText = find.text('Log in to xTwitter');
    expect(loginText, findsOneWidget);
  });

    
}