import 'package:flutter/material.dart';
import 'package:mood_tracker/config/palette.dart';
import 'package:mood_tracker/config/styles.dart';
import 'package:mood_tracker/widgets/widgets.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen>
    with TickerProviderStateMixin {
  CalendarController _calendarController;
  AnimationController _animationController;
  bool _isShowingMore = false;
  bool _isShowMoreButtonVisible = true;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTableCalendarWithBuilders(),
            const Divider(
              color: Colors.black54,
              indent: 20,
              endIndent: 20,
            ),
            _buildMoodInfoBox(context),
            Visibility(
              visible: _isShowMoreButtonVisible,
              child: _calendarController.calendarFormat == CalendarFormat.month
                  ? _buildReadMoreButton()
                  : Container(),
            ),
            Visibility(
              visible: _isShowingMore,
              child: _buildReadMoreInfo(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      calendarController: _calendarController,
      initialCalendarFormat: CalendarFormat.month,
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekdayStyle: TextStyle().copyWith(color: Colors.black54),
        weekendStyle: TextStyle().copyWith(color: Colors.black54),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle().copyWith(color: Colors.black54),
        weekendStyle: TextStyle().copyWith(color: Colors.black54),
      ),
      headerStyle: HeaderStyle(
        leftChevronVisible: false,
        rightChevronVisible: false,
        formatButtonVisible: false,
        headerPadding: EdgeInsets.symmetric(
          vertical: 25.0,
          horizontal: 16.0,
        ),
        titleTextStyle: TextStyle(
          color: Palette.primaryColor,
          fontSize: 28.0,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic,
        ),
      ),
      builders: CalendarBuilders(
        dayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(1.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
            decoration: BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    const Color(0xFFFFFFFF),
                    const Color(0xFFC0C0C0),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          );
        },
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.deepOrange[300],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.amber[400],
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
      ),
    );
  }

  Container _buildMoodInfoBox(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      height: MediaQuery.of(context).size.height * 0.17,
      decoration: BoxDecoration(
        color: Palette.secondaryColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'MOOD',
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black45,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.115,
            child: Row(
              children: <Widget>[
                Image.asset('assets/Happy.png'),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Happy',
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Consectetur nec convallis massa cursus. Etiam id.',
                          style: const TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildReadMoreButton() {
    setState(() {
      _isShowMoreButtonVisible = true;
    });

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton(
            padding: const EdgeInsets.symmetric(
              vertical: 14.0,
              horizontal: 24.0,
            ),
            onPressed: () => {showMore()},
            color: Colors.black54,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Text(
              'Read More',
              style: Styles.buttonTextStyle,
            ),
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }

  void showMore() {
    setState(() {
      _calendarController.toggleCalendarFormat();
    });

    setState(() {
      _isShowMoreButtonVisible = false;
    });

    setState(() {
      _isShowingMore = !_isShowingMore;
    });
  }

  Container _buildReadMoreInfo() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      height: MediaQuery.of(context).size.height * 0.17,
      decoration: BoxDecoration(
        color: Palette.secondaryColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'CHAT HISTORY',
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black45,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.115,
            child: Row(
              children: <Widget>[
                Image.asset('assets/Happy.png'),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Happy',
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Consectetur nec convallis massa cursus. Etiam id.',
                          style: const TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
