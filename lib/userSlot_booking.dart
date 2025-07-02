import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tournament_app/constants/colors.dart';
import 'package:tournament_app/slot_payment.dart';

class UserslotBooking extends StatefulWidget {
  final T_name;
  const UserslotBooking({super.key, required this.T_name});

  @override
  State<UserslotBooking> createState() => _UserslotBookingState();
}

class _UserslotBookingState extends State<UserslotBooking> {
  List<String> slots = <String>['9AM-10AM', '11AM-12AM', '4PM-5PM', '9PM-10PM'];
  String Selected_slot = '9AM-10AM';
  String? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: bgc,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.T_name,
                style: GoogleFonts.aBeeZee(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    selectedDate != null
                        ? "Selected Date: $selectedDate"
                        : "Select Date",
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  _selectDate(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_month),
                    const Text('Calender'),
                  ],
                ),
              ),
              DropdownButton(
                  value: Selected_slot,
                  items: slots.map(
                    (String options) {
                      return DropdownMenuItem(
                        child: Text(
                          options,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        value: options,
                      );
                    },
                  ).toList(),
                  onChanged: (value) {
                    setState(() {
                      Selected_slot = value!;
                    });
                  }),
              SizedBox(
                height: 30,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext) {
                      return SlotPayment();
                    }));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'PAYMENT',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 30),
                      ),
                      Icon(
                        Icons.arrow_forward_sharp,
                        color: Colors.black,
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
