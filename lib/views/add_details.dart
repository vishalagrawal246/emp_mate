import 'package:employee_mate/blocs/add_emp_bloc/add_emp_bloc.dart';
import 'package:employee_mate/blocs/fetch_data_bloc/fetch_data_bloc.dart';
import 'package:employee_mate/widgets/custom_calendar.dart';
import 'package:employee_mate/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class AddDetailsPage extends StatefulWidget {
  const AddDetailsPage(
      {super.key,
      required this.title,
       this.keyy,
      this.name,
      this.role,
      this.fromDate,
      this.toDate});

  final String title;
  final String? name;
  final String? role;
  final String? fromDate;
  final String? toDate;
  final String? keyy;

  @override
  State<AddDetailsPage> createState() => _AddDetailsPageState();
}

class _AddDetailsPageState extends State<AddDetailsPage> {
  TextEditingController name = TextEditingController();
  TextEditingController role = TextEditingController();
  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  @override
  void initState() {
    fromDate.text = widget.fromDate ?? 'Today';
    toDate.text = widget.toDate ?? 'No Date';
    name.text = widget.name ?? '';
    role.text = widget.role ?? '';
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(0),

                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: Theme.of(context).primaryColor,
                      ), // Icon on the left
                      hintText: 'Employee name',

                      border: const OutlineInputBorder(),
                    ),
                    controller: name,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.work_outline,
                        color: Theme.of(context).primaryColor,
                      ),
                      contentPadding: const EdgeInsets.all(0),
                      suffixIcon: InkWell(
                          onTap: () {
                            _showBottomSheet(context);
                          },
                          child: Icon(
                            Icons.arrow_drop_down_outlined,
                            color: Theme.of(context).primaryColor,
                          )),
                      // Icon on the left
                      hintText: 'Select role',
                      border: const OutlineInputBorder(),
                    ),
                    readOnly: true,
                    controller: role,
                    onTap: () {
                      _showBottomSheet(context);
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: InkWell(
                              onTap: () async {
                                var selectedDay = await CustomCalender()
                                    .showDatePicker(context, 'from');
                                if (selectedDay ==
                                    DateFormat('dd MMM yyyy')
                                        .format(DateTime.now())) {
                                  fromDate.text = 'Today';
                                } else {
                                  fromDate.text = selectedDay;
                                }
                              },
                              child: Icon(
                                Icons.calendar_month_outlined,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(0),

                            // Icon on the left

                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          readOnly: true,
                          controller: fromDate,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Theme.of(context).primaryColor,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: InkWell(
                              onTap: () async {
                                var selectedDay = await CustomCalender()
                                    .showDatePicker(context, 'to');
                                if (selectedDay ==
                                    DateFormat('dd MMM yyyy')
                                        .format(DateTime(0))) {
                                  toDate.text = 'No Date';
                                } else {
                                  toDate.text = selectedDay;
                                }
                              },
                              child: Icon(
                                Icons.calendar_month_outlined,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(0),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            border: const OutlineInputBorder(),
                          ),
                          readOnly: true,
                          controller: toDate,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          const Divider(),
          BlocConsumer<AddEmpBloc, AddEmpState>(
            listener: (context, state) {
              if (state is AddEmpLoading) {
                CustomSnackbar.showSnackBarSimple('Please wait...', context);
              }
              if (state is AddEmpSuccess) {
                CustomSnackbar.showSnackBarSimple('Saved!', context);
                Navigator.pop(context);
                BlocProvider.of<FetchDataBloc>(context).add(FetchSavedEvent());
              }
              if (state is AddEmpFailed) {
                CustomSnackbar.showSnackBarSimple(state.error, context);
              }
            },
            builder: (context, state) {
              if (state is AddEmpLoading) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator()),
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0, bottom: 8),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.lightBlue[50]),
                            foregroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0, bottom: 8),
                    child: ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (name.text.trim().isEmpty) {
                            CustomSnackbar.showSnackBarSimple(
                                'Please enter name', context);
                          } else {
                            BlocProvider.of<AddEmpBloc>(context)
                                .add(AddNewEmp(empData: {
                              'name': name.text,
                              'role': role.text,
                              'from': fromDate.text,
                              'to': toDate.text,
                            }, keyy: widget.keyy));
                          }
                        },
                        child: const Text('Save')),
                  )
                ],
              );
            },
          )
        ],
      )),
    );

    // This trailing comma makes auto-formatting nicer for build methods.
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  setState(() {
                    role.text = 'Product Designer';
                  });
                  Navigator.pop(context);
                },
                title: const Center(
                  child: Text('Product Designer'),
                ),
              ),
              ListTile(
                onTap: () {
                  setState(() {
                    role.text = 'Flutter Developer';
                  });
                  Navigator.pop(context);
                },
                title: const Center(child: Text('Flutter Developer')),
              ),
              ListTile(
                onTap: () {
                  setState(() {
                    role.text = 'QA Tester';
                  });
                  Navigator.pop(context);
                },
                title: const Center(child: Text('QA Tester')),
              ),
              ListTile(
                onTap: () {
                  setState(() {
                    role.text = 'Product Owner';
                  });
                  Navigator.pop(context);
                },
                title: const Center(child: Text('Product Owner')),
              )
            ],
          ),
        );
      },
    );
  }
}
