import 'package:flutter/material.dart';

class CGPACalculation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CGPAState();
  }
}

class _CGPAState extends State<CGPACalculation> {
  TextEditingController creditController = TextEditingController();
  TextEditingController sgpaController = TextEditingController();
  List<double> gpaList = List<double>();
  List<double> semesterCreditList = List<double>();
  List<double> multiGpaCreditList = List<double>();
  final _formKey = GlobalKey<FormState>();
  var reMark = '';
  Color reMarkColor = Colors.teal[800];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: getListView(),
                ),
                getwidget(),
                SizedBox(
                    width: double.infinity,
                    height: 60.0,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: RaisedButton(
                          elevation: 7.0,
                          child: Text(
                            "Calculate",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          splashColor: Colors.blueGrey,
                          color: Colors.teal[800],
                          textColor: Theme.of(context).primaryColorLight,
                          onPressed: () {
                            setState(() {
                              if (gpaList.length > 0 &&
                                  semesterCreditList.length > 0 &&
                                  multiGpaCreditList.length > 0) {
                                var result = getCgpa().toStringAsFixed(2);
                                getRemark(getCgpa());
                                openAlertBox(result);

                                gpaList = [];
                                semesterCreditList = [];
                                multiGpaCreditList = [];
                              } else if (_formKey.currentState.validate()) {
                                return;
                              }
                            });
                          }),
                    ))
              ],
            )));
  }

  Widget getwidget() {
    return Card(
      elevation: 10.0,
      child: Row(
        children: <Widget>[
          Expanded(
              child: Padding(
                  padding: EdgeInsets.only(
                      left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter SGPA';
                      }
                    },
                    controller: sgpaController,
                    maxLengthEnforced: false,
                    decoration: InputDecoration(
                        labelText: 'SGPA',
                        hintText: 'Semester SGPA',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                    keyboardType: TextInputType.number,
                  ))),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.only(
                      left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Credit';
                      }
                    },
                    controller: creditController,
                    maxLengthEnforced: false,
                    decoration: InputDecoration(
                        labelText: 'Credit',
                        hintText: 'Credit Hour',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                    keyboardType: TextInputType.number,
                  ))),
          Padding(
              padding: EdgeInsets.only(
                  left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                elevation: 5,
                child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        if (_formKey.currentState.validate()) {
                          var creditValue = double.parse(creditController.text);
                          var gradeValue = double.parse(sgpaController.text);
                          gpaList.add(gradeValue);
                          semesterCreditList.add(creditValue);
                          multiGpaCreditList
                              .add(addValueToList(gradeValue, creditValue));
                          creditController.text = "";
                          sgpaController.text = "";
                        }
                      });
                    }),
              )),
        ],
      ),
    );
  }

  Widget getListView() {
    var listView = Padding(
        padding: EdgeInsets.only(bottom: 10.0),
        child: ListView.builder(
            itemCount: gpaList.length,
            itemBuilder: (context, index) {
              return Card(
                  color: Colors.white,
                  elevation: 5.0,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Padding(
                        padding:
                            EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0),
                        child: Text(
                          '${getSemesterNumber(index)} Semester',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 25.0, color: Colors.black),
                        ),
                      )),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20, top: 10.0, right: 10.0),
                              child: Text(
                                "SGPA: ${gpaList[index]}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.deepPurple[900]),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20,
                                  top: 10.0,
                                  bottom: 10.0,
                                  right: 5.0),
                              child: Text(
                                "Credit: ${semesterCreditList[index]}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.lightBlue),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ));
            }));

    return listView;
  }

  double addValueToList(double sgpa, double creditValue) {
    return sgpa * creditValue;
  }

  double getSum(List value) {
    var sum = 0.0;
    for (int i = 0; i < value.length; i++) {
      sum = sum + value[i];
    }
    return sum;
  }

  double getCgpa() {
    var totalGrade = getSum(multiGpaCreditList);
    var totalCredit = getSum(semesterCreditList);
    return totalGrade / totalCredit;
  }

  openAlertBox(String result) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            contentPadding: EdgeInsets.only(bottom: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: reMarkColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0)),
                      ),
                      child: Text(
                        reMark,
                        style: TextStyle(fontSize: 24.0, color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Text(
                        "Your CGPA : $result",
                        style: TextStyle(fontSize: 25.0),
                      )),
                ],
              ),
            ),
          );
        });
  }

  String getSemesterNumber(int value) {
    if (value == 0) {
      return '1st';
    } else if (value == 1) {
      return '2nd';
    } else if (value == 2) {
      return '3rd';
    } else if (value == 3) {
      return '4th';
    } else if (value == 4) {
      return '5th';
    } else if (value == 5) {
      return '6th';
    } else if (value == 6) {
      return '7th';
    } else if (value == 7) {
      return '8th';
    } else if (value == 8) {
      return '9th';
    } else if (value == 9) {
      return '10th';
    } else if (value == 10) {
      return '11th';
    } else if (value == 11) {
      return '12th';
    }
  }

  void getRemark(double result) {
    if (result == 4.00) {
      reMark = 'Outstanding';
      reMarkColor = Colors.teal[700];
    } else if (result >= 3.75 && result < 4.00) {
      reMark = 'Excellent';
      reMarkColor = Colors.cyan[800];
    } else if (result >= 3.50 && result < 3.75) {
      reMark = 'Very Good';
      reMarkColor = Colors.lightBlue[600];
    } else if (result >= 3.25 && result < 3.50) {
      reMark = 'Good';
      reMarkColor = Colors.indigo[400];
    } else if (result >= 3.00 && result < 3.25) {
      reMark = 'Satisfactory';
      reMarkColor = Colors.yellow[900];
    } else if (result >= 2.75 && result < 3.00) {
      reMark = 'Above Average';
      reMarkColor = Colors.orange[900];
    } else if (result >= 2.50 && result < 2.75) {
      reMark = 'Average';
      reMarkColor = Colors.deepOrange[900];
    } else if (result >= 2.25 && result < 2.50) {
      reMark = 'Bellow Average';
      reMarkColor = Colors.red[900];
    } else if (result >= 2.00 && result < 2.25) {
      reMark = 'Pass';
      reMarkColor = Colors.redAccent[700];
    }
  }
}
