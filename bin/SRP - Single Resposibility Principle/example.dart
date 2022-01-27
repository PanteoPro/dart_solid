class DateTempCPU {
  final CPUTempAPI _cpuTempAPI = CPUTempAPI();

  Future<Map<String, dynamic>> getCurrentInformation() async {
    await _cpuTempAPI.discover();
    final dateTime = FormatedDateTime(dateTime: DateTime.now());
    return <String, dynamic>{
      'startDate': dateTime.startDay,
      'endDate': dateTime.endDay,
      'temp': _cpuTempAPI.temp,
    };
  }
}

class FormatedDateTime {
  FormatedDateTime({required DateTime dateTime}) : _dateTime = dateTime;

  final DateTime _dateTime;

  DateTime get startDay => DateTime(_dateTime.year, _dateTime.month, _dateTime.day);
  DateTime get endDay => startDay.add(Duration(days: 1, milliseconds: -1));
}

class CPUTempAPI {
  double? _temp;

  /// Returns temperature. If unknown returns -1
  double get temp => _temp ?? -1;

  Future<void> discover() async {
    /// Заглушка получения температуры процессора
    Future<double> fetchCPUTemp() async {
      return Future.delayed(Duration(seconds: 2), () => 45.23);
    }

    _temp = await fetchCPUTemp();
  }
}
