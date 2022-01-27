import 'SRP - Single Resposibility Principle/example.dart';

Future<void> main(List<String> arguments) async {
  print('SOLID EXAMPLES');
  await usageSRPExample();
}

Future<void> usageSRPExample() async {
  print('SRP Example');
  final dateTempCPU = DateTempCPU();
  print(await dateTempCPU.getCurrentInformation());
}
