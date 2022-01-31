import 'LSP - Liskov Substitution Principle/example.dart';
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
  final images = <Image>[
    Image(10, 20, SaveToBMP()),
    Image(30, 40, SaveToJPG()),
    Image(100, 70, SaveToPNG()),
  ];

  for (final img in images) {
    img.saveTo('filename');
  }
}
