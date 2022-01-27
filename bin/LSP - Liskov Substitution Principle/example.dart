class DataProvider1 {
  int get data => 2;
}

class DataProvider2 {
  int get data => 1;
}

class Repository {
  final _dataProvider1 = DataProvider1();

  /// returns data between 1-100
  int getData() {
    final data = _dataProvider1.data;
    return data;
  }
}

class AdvancedRepository1 extends Repository {
  late DataProvider2 _dataProvider2;

  // Накладывает дополнительные ограничение на клиентский код
  void init() {
    _dataProvider2 = DataProvider2();
  }

  @override
  int getData() {
    final superData = super.getData();
    final data = _dataProvider2.data;
    return superData + data;
  }
}

class AdvancedRepository2 extends Repository {
  // Возвращает результат, который клиент не ожидал увидеть, т.к. в базовом классе "returns data between 1-100"
  @override
  int getData() {
    final superData = super.getData();
    return 100 + superData;
  }
}
