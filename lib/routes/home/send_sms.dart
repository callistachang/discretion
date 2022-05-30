import 'package:flutter_sms/flutter_sms.dart';

void _sendSMS(String message, List<String> recipents) async {
  await sendSMS(message: message, recipients: recipents).catchError((onError) {
    print(onError);
  });
}

void sendSMSToContacts(String defaultMessage, List<String> numbers) {
  for (String number in numbers) {
    _sendSMS(defaultMessage, numbers);
  }
}
