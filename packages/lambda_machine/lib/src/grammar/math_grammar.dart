import 'package:petitparser/definition.dart';
import 'package:petitparser/parser.dart';

class MathGrammar extends GrammarDefinition {
  Parser num() => digit().plus().flatten().map((i) => double.parse(i));

  Parser parens() => ref0(term).skip(
        before: char('(').trim(),
        after: char(')').trim(),
      );

  Parser prod() => [
        ref0(num),
        [char('*').trim(), ref0(parens)].toSequenceParser().optional()
      ].toSequenceParser().map((e) {
        var [double a, mul] = e;

        if (mul != null) {
          var [_, b] = mul;
          return a * b;
        }

        return a;
      });

  Parser term() => [
        ref0(prod),
        [char('+').trim(), ref0(prod)].toSequenceParser().optional()
      ].toSequenceParser().map((e) {
        var [double a, mul] = e;

        if (mul != null) {
          var [_, b] = mul;
          return a + b;
        }

        return a;
      });

  @override
  Parser start() => ref0(term);
}
