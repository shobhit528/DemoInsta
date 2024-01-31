import 'package:chatapp/ListblocPage/list_bloc_page.dart';
import 'package:chatapp/Login/LoginController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  testWidgets('', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(BlocListPage());


    final list=find.byKey(const ValueKey("listKey"));
    final listTile=find.byKey(ValueKey("itemKey"));
    expect(find.byKey(const ValueKey("listKey")), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });


  testWidgets('Testing', (WidgetTester tester) async {
    await tester.pumpWidget(
      Builder(
        builder: (BuildContext context) {

          // The builder function must return a widget.
          return Placeholder();
        },
      ),
    );
  });
}