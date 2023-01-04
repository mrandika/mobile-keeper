class ApplicationExceptions implements Exception{
  ApplicationExceptions([this._message, this._prefix]);

  final _message;
  final _prefix;

  String toString(){
    return "$_prefix$_message";
  }
}

class FetchDataException extends ApplicationExceptions{
  FetchDataException({String? message}) : super(message, "Failed to communicating with server.");
}