import 'OCP - Open-Closed Principle/example.dart';
import 'SRP - Single Resposibility Principle/example.dart';

Future<void> main(List<String> arguments) async {
  print('SOLID EXAMPLES');
  await usageSRPExample();
  usageOCPExample();
}

Future<void> usageSRPExample() async {
  print('SRP Example');
  final dateTempCPU = DateTempCPU();
  print(await dateTempCPU.getCurrentInformation());
}

void usageOCPExample() {
  print('OCP Example');
  final figures = [Square(3), Square(6), Square(8), Cube(12)];

  for (final figure in figures) {
    figure.info();
    print('square = ${figure.getSquare()}');
    if (figure is Cube) {
      print('volume = ${figure.volume()}');
    }
  }
}
