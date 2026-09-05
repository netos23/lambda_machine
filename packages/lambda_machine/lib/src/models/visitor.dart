import 'models.dart';

abstract interface class Visitor<T> {
  T visitApplication(Application expression);

  T visitLambda(Lambda expression);

  T visitVariable(Variable expression);
}