import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/database/my_database.dart';
import 'package:todo_app/providers/settings_provider.dart';
import 'package:todo_app/ui/home/task_list/task_item.dart';

import '../../../database/tasks_model.dart';

class TaskTab extends StatefulWidget {
  @override
  State<TaskTab> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return Column(
      children: [
        CalendarTimeline(
          initialDate: currentDate,
          firstDate: DateTime.now().subtract(
            const Duration(days: 365),
          ),
          lastDate: DateTime.now().add(
            const Duration(days: 365),
          ),
          onDateSelected: (date) {
            setState(() {
              currentDate = date;
            });
          },
          leftMargin: 20,
          monthColor: provider.isDarkMode() ? Colors.white : Colors.black,
          dayColor: provider.isDarkMode() ? Colors.white : Colors.black,
          activeDayColor: Colors.white,
          activeBackgroundDayColor: provider.isDarkMode()
              ? const Color(0xFF141922)
              : Theme.of(context).primaryColor,
          dotsColor: Colors.white,
          selectableDayPredicate: (date) => true,
          locale: 'en_ISO',
        ),
        StreamBuilder<QuerySnapshot<TaskData>>(
          stream: getTasksFromFireStore(currentDate),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                  child: Text(
                AppLocalizations.of(context)!.message2,
                style: Theme.of(context).textTheme.headline5,
              ));
            }
            var tasks =
                snapshot.data?.docs.map((doc) => doc.data()).toList() ?? [];
            if (tasks.isEmpty) {
              return Center(
                child: provider.isDarkMode()
                    ? Image.asset(
                        'assets/images/nodata_dark.png',
                        fit: BoxFit.fill,
                      )
                    : Image.asset(
                        'assets/images/nodata_light.png',
                        fit: BoxFit.fill,
                      ),
              );
            }
            return Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return TaskItem(tasks[index]);
                },
                itemCount: tasks.length,
              ),
            );
          },
        )
      ],
    );
  }
}
