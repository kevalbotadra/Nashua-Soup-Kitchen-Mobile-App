import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nsks/helpers/constants.dart';
import 'package:nsks/logic/blocs/posts/post_bloc.dart';
import 'package:nsks/logic/blocs/posts/post_event.dart';
import 'package:nsks/logic/blocs/posts/post_state.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(
      listener: (context, state) {
        if (state is PostCreated) {
          Navigator.pop(context);
          Flushbar(
            title: "Post Created",
            backgroundColor: Colors.green,
            flushbarPosition: FlushbarPosition.TOP,
            message: "Succesfully Created Volunteer Post",
            icon: Icon(
              Icons.check,
              size: 28.0,
              color: COLOR_WHITE,
            ),
            duration: Duration(seconds: 2),
          )..show(context);
        }
      },
      builder: (context, state) {
        return CreateForm();
      },
    );
  }
}

class CreateForm extends StatefulWidget {
  const CreateForm({Key? key}) : super(key: key);

  @override
  State<CreateForm> createState() => _CreateFormState();
}

class _CreateFormState extends State<CreateForm> {
  var imageFile;
  int _activeStepIndex = 0;

  DateTime _startDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();

  DateTime _endDate = DateTime.now().add(Duration(hours: 2));
  late TimeOfDay _endTime;

  @override
  void initState() {
    super.initState();
    _endTime = _startTime.replacing(
        hour: _startTime.hour + 2, minute: _startTime.minute);
  }

  // define some controllers
  TextEditingController title = new TextEditingController();
  TextEditingController body = new TextEditingController();
  TextEditingController hours = new TextEditingController();
  TextEditingController location = new TextEditingController();

  bool person1 = false;
  bool person2 = false;
  bool person3 = false;

  List<Step> createSteps() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Basic Info'),
          content: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: title,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Post Title',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: body,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Post Body',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: hours,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Hours Value',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Checkbox(
                          value: person1,
                          onChanged: (bool? value) {
                            setState(() {
                              this.person1 = value!;
                              this.person2 = false;
                              this.person3 = false;
                            });
                          },
                        ),
                        Text("Michael"),
                      ],
                    ),
                    Column(
                      children: [
                        Checkbox(
                          value: person2,
                          onChanged: (bool? value) {
                            setState(() {
                              this.person1 = false;
                              this.person2 = value!;
                              this.person3 = false;
                            });
                          },
                        ),
                        Text("Carol"),
                      ],
                    ),
                    Column(
                      children: [
                        Checkbox(
                          value: person3,
                          onChanged: (bool? value) {
                            setState(() {
                              this.person1 = false;
                              this.person2 = false;
                              this.person3 = value!;
                            });
                          },
                        ),
                        Text("June"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Step(
            state:
                _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 1,
            title: const Text('Start & End Date, Location'),
            content: Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            // border: Border.all(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        padding: EdgeInsets.all(4.5),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat('MMM dd, yyyy')
                                    .format(_startDate)
                                    .toString(),
                              ),
                              TextButton(
                                onPressed: () async {
                                  final DateTime? date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(DateTime.now().year + 2),
                                    initialDatePickerMode: DatePickerMode.day,
                                    locale: Locale("en"),
                                  );
                                  setState(() {
                                    _startDate = date!;
                                    _endDate =
                                        _startDate.add(Duration(hours: 2));
                                  });
                                },
                                child: Text(
                                  'Change',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: 4,
                      // ),
                      Container(
                        // height: 63,
                        // width: 130,
                        decoration: BoxDecoration(
                            // border: Border.all(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        padding: EdgeInsets.all(4.5),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _startTime.format(context),
                              ),
                              TextButton(
                                onPressed: () async {
                                  final TimeOfDay? time = await showTimePicker(
                                    context: context,
                                    initialTime:
                                        TimeOfDay.fromDateTime(DateTime.now()),
                                  );
                                  setState(() {
                                    _startTime = time!;
                                    _endTime = _endTime.replacing(
                                        hour: _startTime.hour + 2,
                                        minute: _startTime.minute);
                                  });
                                },
                                child: Text(
                                  'Edit',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            // border: Border.all(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        padding: EdgeInsets.all(4.5),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat('MMM dd, yyyy')
                                    .format(_endDate)
                                    .toString(),
                              ),
                              TextButton(
                                onPressed: () async {
                                  final DateTime? date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(DateTime.now().year + 2),
                                    initialDatePickerMode: DatePickerMode.day,
                                    locale: Locale("en"),
                                  );
                                  setState(() {
                                    _endDate = date!;
                                  });
                                },
                                child: Text(
                                  'Change',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: 4,
                      // ),
                      Container(
                        decoration: BoxDecoration(
                            // border: Border.all(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        padding: EdgeInsets.all(4.5),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _endTime.format(context),
                              ),
                              TextButton(
                                onPressed: () async {
                                  final TimeOfDay? time = await showTimePicker(
                                    context: context,
                                    initialTime:
                                        TimeOfDay.fromDateTime(DateTime.now()),
                                  );
                                  setState(() {
                                    _endTime = time!;
                                  });
                                },
                                child: Text(
                                  'Edit',
                                  style: GoogleFonts.poppins(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: location,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Location',
                    ),
                  ),
                ],
              ),
            )),
        Step(
            state:
                _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 2,
            title: const Text('Add an Image'),
            content: Container(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      XFile? pickedFile = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                        maxWidth: 1800,
                        maxHeight: 1800,
                      );
                      if (pickedFile != null) {
                        setState(() {
                          imageFile = File(pickedFile.path);
                        });
                      } else {
                        return;
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 350,
                      decoration: BoxDecoration(
                          color: COLOR_GREEN,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      padding: EdgeInsets.all(5.0),
                      child: Center(
                        child: Text(
                          "Choose Image From Gallery",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: COLOR_WHITE,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      XFile? pickedFile = await ImagePicker().pickImage(
                        source: ImageSource.camera,
                        maxWidth: 1800,
                        maxHeight: 1800,
                      );
                      if (pickedFile != null) {
                        setState(() {
                          imageFile = File(pickedFile.path);
                        });
                      } else {
                        return;
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 350,
                      decoration: BoxDecoration(
                          color: COLOR_GREEN,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      padding: EdgeInsets.all(5.0),
                      child: Center(
                        child: Text(
                          "Take an Photo",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: COLOR_WHITE,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  imageFile != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: Image.file(imageFile),
                        )
                      : Center(
                          child: Text("No Image Selected"),
                        ),
                ],
              ),
            )),
        Step(
            state: StepState.complete,
            isActive: _activeStepIndex >= 3,
            title: const Text('Confirm'),
            content: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Title: ${title.text}'),
                Text('Body: ${body.text}'),
                Text('Hours: ${hours.text}'),
                Text(
                    "Start Date/Time: ${DateFormat('MMM dd, yyyy').format(_startDate).toString() + _startTime.format(context)}"),
                Text(
                    "End Date/Time: ${DateFormat('MMM dd, yyyy').format(_endDate).toString() + _endTime.format(context)}"),
                Text('Location : ${location.text}'),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text("Image: "),
                ),
                imageFile != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Image.file(imageFile),
                      )
                    : Text("No Image Selected"),
              ],
            )))
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          centerTitle: true,
          title: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "Create",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 28,
                  color: const Color(0xffFFFFFF)),
            ),
          ),
          backgroundColor: COLOR_GREEN,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          child: Container(
            child: Center(
              child: Theme(
                data: ThemeData(
                  colorScheme: ColorScheme.fromSwatch().copyWith(
                    primary: COLOR_GREEN,
                  ),
                ),
                child: Stepper(
                  type: StepperType.vertical,
                  currentStep: _activeStepIndex,
                  steps: createSteps(),
                  onStepContinue: () {
                    print(_activeStepIndex);
                    if (_activeStepIndex < (createSteps().length - 1)) {
                      setState(() {
                        _activeStepIndex += 1;
                      });
                    } else {
                      String person = "";
                      if (person1) {
                        person = "Michael";
                      } else if (person2) {
                        person = "Carol";
                      } else if (person3) {
                        person = "June";
                      }
                      BlocProvider.of<PostBloc>(context).add(CreatePost(
                        title: title.text,
                        body: body.text,
                        hours: double.parse(hours.text),
                        startDate: _startDate,
                        startTime: _startTime,
                        endDate: _endDate,
                        endTime: _endTime,
                        imageFile: imageFile,
                        location: location.text,
                        personToNotify: person,
                      ));
                    }
                  },
                  onStepCancel: () {
                    if (_activeStepIndex == 0) {
                      return;
                    }

                    setState(() {
                      _activeStepIndex -= 1;
                    });
                  },
                  onStepTapped: (int index) {
                    setState(() {
                      _activeStepIndex = index;
                    });
                  },
                  controlsBuilder: (context, controlDetails) {
                    final isLastStep =
                        _activeStepIndex == createSteps().length - 1;
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: controlDetails.onStepContinue,
                                child: (isLastStep)
                                    ? const Text('Submit')
                                    : const Text('Next'),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            if (_activeStepIndex > 0)
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: controlDetails.onStepCancel,
                                  child: const Text('Back'),
                                ),
                              )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ));
  }
}



