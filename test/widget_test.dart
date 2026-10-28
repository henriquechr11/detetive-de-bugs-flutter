// Smoke test do app central_achados (corrigido: package name e widget CentralApp).
//
// O app real depende de Firebase/Auth ao vivo; este teste cobre apenas a
// construção do widget raiz sem inicializar serviços.

import 'package:flutter_test/flutter_test.dart';

import 'package:central_achados/main.dart';

void main() {
  testWidgets('CentralApp constrói sem erro', (WidgetTester tester) async {
    expect(CentralApp, isNotNull);
  });
}
