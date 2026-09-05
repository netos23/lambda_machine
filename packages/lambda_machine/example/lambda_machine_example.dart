import 'dart:isolate';

import 'package:lambda_machine/src/eval/strict_evel_visitor.dart';
import 'package:lambda_machine/src/grammar/lambda_grammar.dart';
import 'package:lambda_machine/src/util/pretty_print_visitor.dart';

void main() {
  final parser = LambdaGrammar().build();
  final res = parser.parse('(\\ a b. a) (\\a.a) (\\a.a)').value;
  print(res);
  print(res.accept(const PrettyPrintVisitor()));
  print(res.accept(StrictEvalVisitor()).accept(PrettyPrintVisitor()));
}
