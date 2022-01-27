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

void main() {
  final admin = ClientAdmin();
  final user = ClientUser();

  user.fetch();
}
