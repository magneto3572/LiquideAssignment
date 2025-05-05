abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    // In a real application, we would use a connectivity package
    // but for our mock implementation, we'll always return true
    return true;
  }
}