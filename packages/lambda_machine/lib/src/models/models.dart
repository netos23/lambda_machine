import 'package:lambda_machine/src/models/visitor.dart';

sealed class Expression {
  Expression replace(Variable variable, Expression exp);

  T accept<T>(Visitor<T> visitor);
}

class Application extends Expression {
  final Expression expression;
  final Expression args;

  Application({
    required this.expression,
    required this.args,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Application &&
          runtimeType == other.runtimeType &&
          expression == other.expression &&
          args == other.args;

  @override
  T accept<T>(Visitor<T> visitor) => visitor.visitApplication(this);

  @override
  int get hashCode => expression.hashCode ^ args.hashCode;

  @override
  String toString() {
    return 'Application{expression: $expression, args: $args}';
  }

  @override
  Expression replace(Variable variable, Expression exp) {
    return Application(
      expression: expression.replace(variable, exp),
      args: args.replace(variable, exp),
    );
  }
}

class Lambda extends Expression {
  final Variable arg;
  final Expression body;

  Lambda({required this.arg, required this.body});

  @override
  Expression replace(Variable variable, Expression exp) {
    return Lambda(arg: arg, body: body.replace(variable, exp));
  }

  @override
  T accept<T>(Visitor<T> visitor) => visitor.visitLambda(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Lambda &&
          runtimeType == other.runtimeType &&
          arg == other.arg &&
          body == other.body;

  @override
  int get hashCode => arg.hashCode ^ body.hashCode;

  @override
  String toString() {
    return 'Lambda{arg: $arg, body: $body}';
  }
}

class Variable extends Expression {
  final String name;

  Variable(this.name);

  @override
  Expression replace(Variable variable, Expression exp) {
    return variable == this ? exp : this;
  }

  @override
  T accept<T>(Visitor<T> visitor) => visitor.visitVariable(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Variable &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return 'Variable{name: $name}';
  }
}
