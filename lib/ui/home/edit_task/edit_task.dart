import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/settings_provider.dart';
import 'package:todo_app/ui/utils/components.dart';
import 'package:todo_app/ui/utils/date_utils.dart';

import '../../../database/my_database.dart';
import '../../../database/tasks_model.dart';

class EditTask extends StatefulWidget {
  static const String routeName = 'edit-task';

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  TaskData? task;

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    task = ModalRoute.of(context)?.settings.arguments as TaskData;
    var provider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.title),
      ),
      body: Card(
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                AppLocalizations.of(context)!.edit_task,
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  style: provider.isDarkMode()
                      ? const TextStyle(color: Colors.white)
                      : const TextStyle(color: Colors.black),
                  onChanged: (value) {
                    task?.title = value;
                  },
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return AppLocalizations.of(context)!.valid1;
                    }
                    return null;
                  },
                  initialValue: task!.title,
                  decoration: InputDecoration(
                    label: Text(
                      AppLocalizations.of(context)!.title_sheet,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(color: Theme.of(context).primaryColor),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  style: provider.isDarkMode()
                      ? const TextStyle(color: Colors.white)
                      : const TextStyle(color: Colors.black),
                  maxLines: 4,
                  minLines: 4,
                  onChanged: (value) {
                    task?.description = value;
                  },
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return AppLocalizations.of(context)!.valid2;
                    }
                    return null;
                  },
                  initialValue: task!.description,
                  decoration: InputDecoration(
                    label: Text(
                      AppLocalizations.of(context)!.description,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(color: Theme.of(context).primaryColor),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  AppLocalizations.of(context)!.select,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    showTaskDatePicker();
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    MyDateUtils.formatDate(task!.dateTime),
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      showLoading(
                          context, AppLocalizations.of(context)!.loading);
                      showMessage(
                          context,
                          AppLocalizations.of(context)!.question2,
                          AppLocalizations.of(context)!.yes,
                          () {
                            editTask();
                            Navigator.pop(context);
                            showMessage(
                                context,
                                AppLocalizations.of(context)!.message3,
                                AppLocalizations.of(context)!.ok, () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              hideAlertDialog(context);
                            });
                          },
                          negButton: AppLocalizations.of(context)!.cancel,
                          negAction: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            hideAlertDialog(context);
                          });
                    }
                  },
                  child: Text(
                    AppLocalizations.of(context)!.save,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showTaskDatePicker() async {
    var userSelectedDate = await showDatePicker(
      context: context,
      initialDate: task!.dateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );
    if (userSelectedDate == null) {
      return;
    }
    setState(
      () {
        task!.dateTime = userSelectedDate;
      },
    );
  }

  void editTask() {
    updateTask(task!);
  }
}
