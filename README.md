# SOLID принципы на dart
В данном репозитории, представлены примеры соблюдения принципов проектирования SOLID.

## Плюсы
- Легкость поддержки кода;
- Масштабируемость;
- Код легко читать;
- Легкость переиспользования (reusability);

## SRP - Single Responsibility Principle (Принцип единственной ответственности)
Определение: Класс должен содержать только те поля и методы, которые относятся к одной задаче (вопросу).

Через класс должна проходить только одна ось изменений.

### Пример как не надо:
```dart
class DateTemp {
    final double temp;
    final DateTime time;

    /// Логика вычисления времени
    void calculateTime() {}
    /// Логика вычисления температуры
    void calculateTemp() {}
}
```
Когда где-то в коде понадобится функционал вычисления __времени__ из класса `DateTemp`, то придется:

- Делать копипаст в новый класс `DateTime` нужных свойств и методов __(плохо)__

Аналогично с функционалом вычисления __температуры__.

В итоге, будет 2 класса, которые частично выполняют тот же функционал из класса `DateTemp`.

Соответственно, при нахождении багов в классе `DateTemp`, фикс багов не будет попадать в новосозданные и не связанные классы.

### Пример как надо:
```dart
class DateTime {
    final DateTime time;

    void calculateTime() {}
}

class Temp {
    final double temp;

    void calculateTime() {}
}
```

Если нужен функционал из __обоих__ классов, то новый класс может содержать оба объекта класса и делегирует им выполнение этих методов.

Самое частое нарушение этого принципа - `God object`

> Смотреть пример bin/SRP - Single Responsibility Principle/example.dart

## OCP - Open-Closed Principle (Принцип открытости/закрытости)

Определение: Классы, модули, функции, открыты для __расширения__, закрыты для __изменения__.

### Плюсы

- При добавлении новой функциональности, не изменяя __предыдущую__, не будет новый багов;

### Как соблюдать OCP

Клиентский код должен зависеть от интерфейса, который неизменный.

### Пример

```dart
class Image {
  final int width;
  final int height;
  final ISave _saver;
  Image(this.width, this.height, this._saver);

  void saveTo(String path) {
    _saver.save(path, this);
  }
}

abstract class ISave {
  void save(String path, Image image);
}

class SaveToBMP implements ISave {
  @override
  void save(String path, Image image) {
    print('save image: ${image.width}, ${image.height} to bmp');
  }
}

class SaveToJPG implements ISave {
  @override
  void save(String path, Image image) {
    print('save image: ${image.width}, ${image.height} to jpg');
  }
}

class SaveToPNG implements ISave {
  @override
  void save(String path, Image image) {
    print('save image: ${image.width}, ${image.height} to png');
  }
}

void usageOCPExample() {
  final images = <Image>[
    Image(10, 20, SaveToBMP()),
    Image(30, 40, SaveToJPG()),
    Image(100, 70, SaveToPNG()),
  ];

  for (final img in images) {
    img.saveTo('filename');
  }
}
```

Это делается для того, чтобы клиентский код был независем от реализаций интерфейса.

> Смотреть пример bin/OCP - Open-Closed Principle/example.dart

## LSP - Liskov Substitution Principle (Принцип подстановки Барбары Лисков)

Определение: Поведение наследующих классов не должно противоречить поведению заданного в базовом классе.

- Наследники должны иметь тот же функционал что и parent;
- Подкласс не должен требовать от вызывающего кода больше, чем базовый класс; (эти методы ты вызывай, а эти методы не вызывай / ты с начала должен вызвать что-то дополнительное);
    - Не должен накладывать дополнительные ограничения на клиентский код;
- Подкласс не должен предоставлять коду меньше чем базовый; 
    - Не должен возвращать меньше, чем базовый класс;

### Пример как не надо:

```dart
class DB {
    void open() {}
    void close() {}
    void save() {}
}

class MockDB extends DB {
    @override
    void save() {
        // Здесь отключаешь ненужный метод
        throw UnimplementedError();
    }
}
```

MockDB нарушает этот принцип, так как он не имеет тот же функционал, который у __Parent'a__.

> Например в каком-то классе есть метод, который умеет принимать число от 1 до 100 и возвращать от 1 до 10. Если его заоверрайдить так, что новый будет уметь принимать 0..200, а возвращать 3..5 - существующий клиентский код будет доволен. А вот если переписать так, что новый метод умеет принимать только 1..50 или вдруг возвращает 0..20 - то существующий клиентский код может быть неприятно удивлён.

> Смотреть пример bin/LSP - Liskov Substitution/example.dart

## ISP - Interface Segregation Principle (Принцип разделения интерфейсов)

Определение: Клиенты не должны зависеть от методов, которые они не используют, тоесть если какой то метод в интерфейсе не используется клиентом, то изменения этого метода не должны приводить к необходимости изменять клиентский код.

### Пример

```dart
abstract class IClientUser {
  void fetch();
}

abstract class IClientAdmin {
  void crud();
}

class ClientUser implements IClientUser {
  @override
  void fetch() {
    print('fetch');
  }
}

// Или class ClientAdmin implements IClientAdmin, IClientUser и реализовать оба метода
class ClientAdmin extends ClientUser implements IClientAdmin {
  @override
  void crud() {
    print('crud');
  }
}
```

Интерфейсы являются принадлежностью клиента.

## DIP - Dependency Inversion Principle (Принцип инверсии зависимостей)

Определение: Модули верхних уровней не доолжны зависеть от модулей нижних уровней. Оба типа модулей должны зависеть от интерфейса.

Определение: Абстракции не должны зависеть от деталей. Детали должны зависеть от абстракций.

Зависимость на Абстракциях. Нет зависимости на что-то конкретное.

__Использовать все классы через интерфейсы__

```dart
abstract class Payment {
    void payment();
}

class PaymentCreditCard implements Payment {
    @override
    void payment(){
        // Логика
    }
}

class PaymentDebitCard implements Payment {
    @override
    void payment(){
        // Логика
    }
}

class CheckOut {
    // Класс CheckOut не знает как работает Payment, ему достаточно знать что есть методо payment
    void checkOut(Payment pay){
        pay.payment();
    }
}
```