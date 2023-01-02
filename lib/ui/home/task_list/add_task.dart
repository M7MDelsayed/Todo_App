import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/database/my_database.dart';
import 'package:todo_app/database/tasks_model.dart';
import 'package:todo_app/providers/settings_provider.dart';
import 'package:todo_app/ui/utils/components.dart';
import 'package:todo_app/ui/utils/date_utils.dart';

class AddTask extends StatefulWidget {
  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppLocalizations.of(context)!.add_task,
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                style: provider.isDarkMode()
                    ? const TextStyle(color: Colors.white)
                    : const TextStyle(color: Colors.black),
                controller: titleController,
                validator: (input) {
                  if (input == null || input.trim().isEmpty) {
                    return AppLocalizations.of(context)!.valid1;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text(
                    AppLocalizations.of(context)!.title_sheet,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                style: provider.isDarkMode()
                    ? const TextStyle(color: Colors.white)
                    : const TextStyle(color: Colors.black),
                maxLines: 4,
                minLines: 4,
                controller: descriptionController,
                validator: (input) {
                  if (input == null || input.trim().isEmpty) {
                    return AppLocalizations.of(context)!.valid2;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text(
                    AppLocalizations.of(context)!.description,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                AppLocalizations.of(context)!.select,
                style: Theme.of(context).textTheme.headline6,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    showTaskDatePicker(context);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    MyDateUtils.formatDate(selectedDate),
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
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    TaskData task = TaskData(
                      title: titleController.text,
                      description: descriptionController.text,
                      dateTime: selectedDate,
                    );
                    showLoading(context, AppLocalizations.of(context)!.loading);
                    showMessage(
                        context,
                        AppLocalizations.of(context)!.question,
                        AppLocalizations.of(context)!.yes,
                        () {
                          addTaskToFirebaseFirestore(task);
                          Navigator.pop(context);
                          showMessage(
                              context,
                              AppLocalizations.of(context)!.message,
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
                  AppLocalizations.of(context)!.submit,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  var selectedDate = DateTime.now();

  void showTaskDatePicker(context) async {
    var userSelectedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
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
        selectedDate = userSelectedDate;
      },
    );
  }
}
