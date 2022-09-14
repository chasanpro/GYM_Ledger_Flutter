import 'package:flutter_sms/flutter_sms.dart';

import 'Firebase/parser.dart';

class sms {
  static Future<void> smscreate(String ph, name, DateTime doe) async {
    List<String> recipients = [];
    recipients.add(ph);
    String dueDate = doe.toString().substring(0, 10);

    var message =
        " Hey $name, Your subscription for Dharims💪Fitnesszone is created sucessfully ; Your Date of Expiry is ${dueparse(dueDate)}";
    try {
      // ignore: unused_local_variable
      String _result = await sendSMS(
        message: message,
        recipients: recipients,
          
      );
    } catch (error) {
      print(error.toString());
    }
  }

  static Future<void> smsupgrade(String ph, name, DateTime doe) async {
    List<String> recipients = [];
    recipients.add(ph);
    String dueDate = doe.toString().substring(0, 10);
    var message =
        " Hey $name, Your subscription for Dharims💪Fitnesszone is Upgraded sucessfully ; Your next Date of Expiry is ${dueparse(dueDate)}";

    try {
      // ignore: unused_local_variable
      String _result = await sendSMS(
        message: message,
        recipients: recipients,
          
      );
    } catch (error) {
      print("🤷‍♀️🤷‍♀️🤷‍♀️");
      print(error.toString());
    }
  }

  static Future<void> smsAlert(String ph, name, DateTime doe, int days) async {
    List<String> recipients = [];
    recipients.add(ph);

    if (days <= 0) {
      if (days == -1) {
        days = days * -1;
        var message =
            " Hey $name, Your subscription for Dharims💪Fitnesszone had expired $days day ago , Kindly make the payment asap ";
        // ignore: unused_local_variable
        String _result = await sendSMS(
          message: message,
          recipients: recipients,
            
        );
        return;
      } else {
        try {
          days = days * -1;
          var message =
              " Hey $name, Your subscription for Dharims💪Fitnesszone had expired $days days ago ,Kindly make the payment asap";
          // ignore: unused_local_variable
          String _result = await sendSMS(
            message: message,
            recipients: recipients,
              
          );
        } catch (error) {}
      }
    } else {
      try {
        if (days == 1) {
          var message =
              " Hey $name, Your subscription for Dharims💪Fitnesszone is about to expire in  $days day";

          await sendSMS(
            message: message,
            recipients: recipients,
              
          );
        } else {
          var message =
              " Hey $name, Your subscription for Dharims💪Fitnesszone is about to expire in  $days days";

          await sendSMS(
            message: message,
            recipients: recipients,
              
          );
        }
      } catch (error) {}
    }
  }
}
