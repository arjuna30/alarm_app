import 'package:flutter/material.dart';
import 'analog_clock_painter.dart';

class AnalogClock extends StatelessWidget {
  final DateTime? datetime;
  final bool showDigitalClock;
  final bool showTicks;
  final bool showNumbers;
  final bool showAllNumbers;
  final bool showSecondHand;
  final Color hourHandColor;
  final Color minuteHandColor;
  final Color secondHandColor;
  final Color tickColor;
  final Color digitalClockColor;
  final Color numberColor;
  final bool isLive;
  final double textScaleFactor;
  final double width;
  final double height;
  final BoxDecoration decoration;

  const AnalogClock(
      {this.datetime,
      this.showDigitalClock = true,
      this.showTicks = true,
      this.showNumbers = true,
      this.showSecondHand = true,
      this.showAllNumbers = false,
      this.hourHandColor = Colors.white,
      this.minuteHandColor = Colors.white,
      this.secondHandColor = Colors.redAccent,
      this.tickColor = Colors.white,
      this.digitalClockColor = Colors.white,
      this.numberColor = Colors.white,
      this.textScaleFactor = 1.0,
      this.width = double.infinity,
      this.height = double.infinity,
      this.decoration = const BoxDecoration(),
      isLive,
      Key? key})
      : isLive = isLive ?? (datetime == null),
        super(key: key);

  const AnalogClock.dark(
      {datetime,
      showDigitalClock = true,
      showTicks = true,
      showNumbers = true,
      showAllNumbers = false,
      showSecondHand = true,
      width = double.infinity,
      height = double.infinity,
      decoration = const BoxDecoration(),
      Key? key})
      : this(
            datetime: datetime,
            showDigitalClock: showDigitalClock,
            showTicks: showTicks,
            showNumbers: showNumbers,
            showAllNumbers: showAllNumbers,
            showSecondHand: showSecondHand,
            width: width,
            height: height,
            hourHandColor: Colors.white,
            minuteHandColor: Colors.white,
            secondHandColor: Colors.redAccent,
            tickColor: Colors.grey,
            digitalClockColor: Colors.white,
            numberColor: Colors.white,
            decoration: decoration,
            key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: decoration,
      child: Center(
          child: AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                  constraints:
                      const BoxConstraints(minWidth: 48.0, minHeight: 48.0),
                  width: double.infinity,
                  child: CustomPaint(
                    painter: AnalogClockPainter(
                        datetime: datetime ?? DateTime.now(),
                        showDigitalClock: showDigitalClock,
                        showTicks: showTicks,
                        showNumbers: showNumbers,
                        showAllNumbers: showAllNumbers,
                        showSecondHand: showSecondHand,
                        hourHandColor: hourHandColor,
                        minuteHandColor: minuteHandColor,
                        secondHandColor: secondHandColor,
                        tickColor: tickColor,
                        digitalClockColor: digitalClockColor,
                        textScaleFactor: textScaleFactor,
                        numberColor: numberColor),
                  )))),
    );
  }
}
