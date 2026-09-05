import 'package:lambda_machine/src/models/models.dart';
import 'package:lambda_machine/src/models/visitor.dart';

class StrictEvalVisitor implements Visitor<Expression> {
  @override
  Expression visitApplication(Application expression) {
    final arg = expression.args.accept(this);
    final exp = expression.expression.accept(this);

    if (exp is! Lambda) {
      return Application(expression: exp, args: arg);
    } else {
      return exp.body.replace(exp.arg, arg);
    }
  }

  @override
  Expression visitLambda(Lambda expression) {
    return expression;
  }

  @override
  Expression visitVariable(Variable expression) {
    return expression;
  }
}
