class MongoErrors {
  static String getMongoErrorMessage(dynamic response) {
    String msg = '';
    if (response['errors'] != null) {
      print(response['errors']);
      response['errors'].asMap().forEach((i, value) {
        msg += "\n ${value['message']}";
      });
    } else if (response['name'] == 'MongoError') {
      print(response['code']);

      switch (response['code']) {
        case 11000:
          msg = 'Email already Exists, please try another one';
      }
    } else {
      msg = 'Email or password might be wrong, retry your login';
    }
    return msg;
  }
}
