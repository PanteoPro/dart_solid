abstract class Payment {
  void payment();
}

class PaymentCreditCard implements Payment {
  @override
  void payment() {
    // Логика
  }
}

class PaymentDebitCard implements Payment {
  @override
  void payment() {
    // Логика
  }
}

class CheckOut {
  // Класс CheckOut не знает как работает Payment, ему достаточно знать что есть методо payment
  void checkOut(Payment pay) {
    pay.payment();
  }
}
