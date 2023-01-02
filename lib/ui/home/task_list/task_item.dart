import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/database/my_database.dart';
import 'package:todo_app/database/tasks_model.dart';
import 'package:todo_app/providers/settings_provider.dart';
import 'package:todo_app/ui/home/edit_task/edit_task.dart';

class TaskItem extends StatefulWidget {
  TaskData taskData;

  TaskItem(this.taskData);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color:
            provider.isArabic() ? Colors.red : Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                deleteTaskFromFirestore(widget.taskData.id);
              },
              backgroundColor: Colors.red,
              label: AppLocalizations.of(context)!.delete,
              icon: Icons.delete,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                bottomLeft: Radius.circular(18),
              ),
            ),
            SlidableAction(
              onPressed: (context) {
                Navigator.pushNamed(
                  context,
                  EditTask.routeName,
                  arguments: widget.taskData,
                );
              },
              backgroundColor: Theme.of(context).primaryColor,
              label: AppLocalizations.of(context)!.edit,
              icon: Icons.edit,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                bottomLeft: Radius.circular(18),
              ),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color:
                provider.isDarkMode() ? const Color(0xFF141922) : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                width: 4,
                height: 80,
                color: widget.taskData.isDone == true
                    ? Colors.green
                    : Theme.of(context).primaryColor,
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.taskData.title,
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: widget.taskData.isDone == true
                                ? Colors.green
                                : Theme.of(context).primaryColor,
                          ),
                    ),
                    Text(
                      widget.taskData.description,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    editIsDone(widget.taskData);
                  });
                },
                child: widget.taskData.isDone
                    ? Text(
                        AppLocalizations.of(context)!.done,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(color: Colors.green, fontSize: 23),
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Icon(
                          Icons.check,
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
