abstract class Figure {
  double getSquare();
  void info();
}

class Square implements Figure {
  const Square(this.a);
  final int a;

  @override
  double getSquare() {
    return (a * a).toDouble();
  }

  @override
  void info() {
    print('Square(a: $a)');
  }
}

class Cube implements Figure {
  const Cube(this.a);
  final int a;

  @override
  double getSquare() {
    return a * a * 6;
  }

  @override
  void info() {
    print('Cube(a: $a)');
  }

  // Новый функционал
  double volume() {
    return (a * a * a).toDouble();
  }
}
