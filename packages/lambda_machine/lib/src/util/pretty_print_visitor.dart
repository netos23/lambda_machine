import 'package:lambda_machine/src/models/models.dart';
import 'package:lambda_machine/src/models/visitor.dart';

class PrettyPrintVisitor implements Visitor<String> {
  const PrettyPrintVisitor();
  @override
  String visitApplication(Application expression) {
    String exp = expression.expression.accept(this);
    String arg = expression.args.accept(this);

    return '$exp $arg';
  }

  @override
  String visitLambda(Lambda expression) {
    String arg = expression.arg.accept(this);
    String body = expression.body.accept(this);

    return 'λ $arg.$body';
  }

  @override
  String visitVariable(Variable expression) {
    return expression.name;
  }
}
