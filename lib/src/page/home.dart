import 'package:clock_app/src/bloc/alarm_bloc.dart';
import 'package:clock_app/src/bloc/clock_bloc.dart';
import 'package:clock_app/src/bloc/notification_bloc.dart';
import 'package:clock_app/src/bloc/set_alarm_bloc.dart';
import 'package:clock_app/src/model/alarm.dart';
import 'package:clock_app/src/widget/analog_clock.dart';
import 'package:clock_app/src/widget/custom_circle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_switch/flutter_switch.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DateTime time;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClockBloc, ClockState>(
      builder: (context, state) {
        if (state is CurrentTimeState) {
          time = state.dateTime;
          return const Scaffold(body: _BodyHomePage());
        }
        if (state is ErrorTimeState) {
          return Scaffold(
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  const Text('Something went wrong..',
                      style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () {
                        context.read<ClockBloc>().add(GetTimeEvent());
                      },
                      child: const SizedBox(
                          height: 50,
                          child: Icon(Icons.refresh,
                              size: 25, color: Colors.white)),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.black54),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              const CircleBorder())))
                ])),
          );
        }
        return const Scaffold(body: SizedBox.shrink());
      },
    );
  }
}

class _BodyHomePage extends StatelessWidget {
  const _BodyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var verticalRange = 0.0;
    late DateTime time;
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<AlarmBloc, AlarmState>(
              builder: (context, state) {
                if (state is TimeState) {
                  time = state.dateTime;
                  return Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      GestureDetector(
                        onHorizontalDragUpdate: (details) {
                          if (details.delta.dx > 0) {
                            context.read<AlarmBloc>().add(
                                  UpdateHourEvent(time.add(
                                    const Duration(seconds: 30),
                                  )),
                                );
                          }
                          if (details.delta.dx < 0) {
                            context.read<AlarmBloc>().add(
                                  UpdateHourEvent(time.subtract(
                                    const Duration(seconds: 30),
                                  )),
                                );
                          }
                        },
                        onVerticalDragUpdate: (details) {
                          if (details.delta.dy < 0) {
                            verticalRange += details.delta.distance;
                            if (verticalRange.round() % 2 == 0) {
                              context.read<AlarmBloc>().add(
                                    UpdateHourEvent(
                                      time.add(const Duration(hours: 1)),
                                    ),
                                  );
                            }
                          }
                          if (details.delta.dy > 0) {
                            verticalRange -= details.delta.distance;
                            if (verticalRange.round() % 2 == 0) {
                              context.read<AlarmBloc>().add(
                                    UpdateHourEvent(
                                      time.subtract(const Duration(hours: 1)),
                                    ),
                                  );
                            }
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(35.0),
                          child: AnalogClock(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 8.0, color: Colors.black),
                                color: Colors.transparent,
                                shape: BoxShape.circle),
                            datetime: time,
                            hourHandColor: Colors.lightGreenAccent,
                            minuteHandColor: Colors.white,
                            tickColor: Colors.white,
                            numberColor: Colors.lightGreenAccent,
                            showSecondHand: false,
                            showNumbers: true,
                            textScaleFactor: 1.4,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0, right: 15),
                          child: BlocBuilder<ClockBloc, ClockState>(
                            builder: (context, state) {
                              if (state is CurrentTimeState) {
                                final hourMinute =
                                    DateFormat('jm').format(state.dateTime);
                                return GestureDetector(
                                  onTap: () {
                                    context
                                        .read<AlarmBloc>()
                                        .add(GetCurrentTimeEvent());
                                  },
                                  child: Text(hourMinute),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30, bottom: 12),
                        child: CustomCircleButton(
                          onPressed: () {
                            context
                                .read<SetAlarmBloc>()
                                .add(AddAlarmEvent(time));
                            context
                                .read<NotificationBloc>()
                                .add(SetNotificationEvent(time));
                          },
                        ),
                      )
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<SetAlarmBloc, SetAlarmState>(
              builder: (context, state) {
                if (state is SuccessGetAlarmState) {
                  final alarms = state.alarms;
                  if (alarms.isEmpty) {
                    return const Center(
                        child: Text(
                      'No alarm has been set.',
                      style: TextStyle(color: Colors.white30),
                    ));
                  }
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: alarms
                          .map((alarm) => _AlarmCard(
                                alarm: alarm,
                                onLongPressed: () {
                                  context
                                      .read<SetAlarmBloc>()
                                      .add(DeleteAlarmEvent(alarm));
                                  context
                                      .read<NotificationBloc>()
                                      .add(RemoveNotificationEvent(alarm));
                                },
                                onToggle: (_) {
                                  context
                                      .read<SetAlarmBloc>()
                                      .add(ToggleIsActiveEvent(alarm));
                                  (alarm.isActive)
                                      ? context
                                          .read<NotificationBloc>()
                                          .add(RemoveNotificationEvent(alarm))
                                      : context
                                          .read<NotificationBloc>()
                                          .add(SetNotificationEvent(time));
                                },
                              ))
                          .toList(),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          )
        ],
      ),
    );
  }
}

class _AlarmCard extends StatelessWidget {
  final Alarm alarm;
  final VoidCallback? onLongPressed;
  final void Function(bool value) onToggle;

  const _AlarmCard(
      {Key? key,
      required this.alarm,
      this.onLongPressed,
      required this.onToggle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String day = DateFormat('EEEE').format(alarm.alarmTime);
    final String hour = DateFormat('jm').format(alarm.alarmTime);

    return GestureDetector(
      onLongPress: onLongPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          boxShadow: const [
            BoxShadow(
                color: Colors.black38, offset: Offset(4.0, 4.0), blurRadius: 7)
          ],
        ),
        height: 75,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$day, $hour', style: const TextStyle(fontSize: 18)),
            FlutterSwitch(
              activeColor: Colors.green,
              inactiveColor: Colors.black26,
              value: alarm.isActive,
              height: 30,
              width: 60,
              onToggle: onToggle,
            ),
          ],
        ),
      ),
    );
  }
}
