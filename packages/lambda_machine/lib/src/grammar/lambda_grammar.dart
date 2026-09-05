import 'package:lambda_machine/src/models/models.dart';
import 'package:petitparser/petitparser.dart';

class LambdaGrammar extends GrammarDefinition<Expression> {
  Parser<String> identifier() => word().plus().flatten();

  Parser<Variable> symbol() => identifier().map(Variable.new);

  Parser<Expression> parens() => ref0(expr).skip(
        before: char('(').trim(),
        after: char(')').trim(),
      );

  Parser<Expression> app() =>
      (ref0(symbol).trim() | ref0(parens).trim()).plus().map(
            (expr) => expr.reduce(
              (e, acc) => Application(expression: e, args: acc),
            ),
          );

  Parser<Expression> expr() =>
      (ref0(app) | ref0(parens) | ref0(symbol) | ref0(lambda)).cast();

  Parser<List<Variable>> lambdaArgs() => ref0(symbol).trim().plus().skip(
        before: (char('\\') | char('λ')).trim(),
        after: char('.').trim(),
      );

  Parser<Expression> lambda() =>
      seq2(ref0(lambdaArgs), ref0(expr)).map2((args, expr) =>
          args.reversed.fold(expr, (expr, arg) => Lambda(arg: arg, body: expr)));

  @override
  Parser<Expression> start() => ref0(expr).end();
}
