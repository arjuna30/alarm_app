import 'package:clock_app/src/bloc/alarm_bloc.dart';
import 'package:clock_app/src/bloc/clock_bloc.dart';
import 'package:clock_app/src/bloc/notification_bloc.dart';
import 'package:clock_app/src/bloc/set_alarm_bloc.dart';
import 'package:clock_app/src/page/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

const _initializationSettingsAndroid = AndroidInitializationSettings('clock');
const _initializationSettingsIOS = IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true);
const _initializationSettings = InitializationSettings(
    android: _initializationSettingsAndroid, iOS: _initializationSettingsIOS);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await flutterLocalNotificationsPlugin.initialize(_initializationSettings,
      onSelectNotification: (payload) async {
    if (payload != null) {
      debugPrint('Nofitication Payload : ' + payload);
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiBlocProvider(
      providers: const [
        BlocProvider(create: ClockBloc.create),
        BlocProvider(create: AlarmBloc.create),
        BlocProvider(create: SetAlarmBloc.create),
        BlocProvider(create: NotificationBloc.create)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Clock App',
        theme: ThemeData.dark().copyWith(
            brightness: Brightness.dark, primaryColor: Colors.lightGreenAccent),
        home: const HomePage(),
      ),
    );
  }
}
