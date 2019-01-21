import 'package:cgpa_calculator/models/sgpa_model.dart';
import 'package:flutter/material.dart';

class SgpaCalculation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SgpaState();
  }
}

class SgpaState extends State<SgpaCalculation> {
  static var _grade = [
    'Select grade',
    'Grade A+ (4.00)',
    'Grade A (3.75)',
    'Grade A- (3.50)',
    'Grade B+ (3.25)',
    'Grade B (3.00)',
    'Grade B- (2.75)',
    'Grade C+ (2.50)',
    'Grade C (2.25)',
    'Grade D (2.00)'
  ];

  List<double> gradeList = List<double>();
  List<double> creditList = List<double>();
  List<double> sumList = List<double>();
  final _formKey = GlobalKey<FormState>();
  var count = 0;
  SgpaModel model = SgpaModel();
  var _currentItemSelected = _grade[0];
  TextEditingController credit = TextEditingController();
  var pos = 4.00;

  @override
  Widget build(BuildContext context) {
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
                              if (gradeList.length > 0 &&
                                  creditList.length > 0 &&
                                  sumList.length > 0) {
                                debugPrint(
                                    "Your SGPA :${getSgpa().toString()}");
                                var result = getSgpa().toStringAsFixed(2);
                                openAlertBox(result);

                                gradeList = [];
                                creditList = [];
                                sumList = [];
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
      elevation: 15.0,
      child: Row(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(5.0),
              child: DropdownButton<String>(
                /* validator: (value){
                  if(value.isEmpty){
                    return 'Please grade';
                  }
                },*/
                items: _grade.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                onChanged: (String newValueSelected) {
                  onChangeGrade(newValueSelected);
                  pos = _updateGradeAsString(newValueSelected);

                  // Your code to execute, when a menu item is selected from drop down
                },
                value: _currentItemSelected,
              )),
          Expanded(
              child: Padding(
                  padding:
                      EdgeInsets.only(left: 5.0, right: 5, top: 5, bottom: 5),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter credit';
                      }
                    },
                    controller: credit,
                    maxLengthEnforced: false,
                    decoration: InputDecoration(
                        labelText: 'Credit',
                        hintText: 'Enter Credit',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                    keyboardType: TextInputType.number,
                  ))),
          Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5, top: 5, bottom: 5),
              child: Card(
                elevation: 5,
                child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        if (_formKey.currentState.validate() && pos != 0.0) {
                          var creditValue = double.parse(credit.text);
                          gradeList.add(pos);
                          creditList.add(creditValue);
                          sumList.add(addValueToList(pos, creditValue));
                          onChangeGrade(_grade[0]);
                          credit.text = '';
                        }
                      });
                    }),
              )),
        ],
      ),
    );
  }

  Widget getListView() {
    var listView = ListView.builder(
      itemCount: gradeList.length,
      itemBuilder: (context, index) {
        return Card(
            color: Colors.white,
            elevation: 5.0,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0),
                  child: Text(
                    "Course ${index + 1}",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 25.0, color: Colors.black),
                  ),
                )),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.only(left: 20, top: 10.0, right: 10.0),
                        child: Text(
                          "Grade ${gradeList[index].toString()}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 20.0, color: Colors.deepPurple[900]),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20, top: 10.0, bottom: 10.0, right: 10.0),
                        child: Text(
                          "Credit ${creditList[index].toString()}",
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
      },
    );

    return listView;
  }

  String _updateGradeAsDouble(double selected) {
    if (selected == 4.00) {
      return 'Grade A+ (4.00)';
    } else if (selected == 3.75) {
      return 'Grade A (3.75)';
    } else if (selected == 3.50) {
      return 'Grade A- (3.50)';
    } else if (selected == 3.25) {
      return 'Grade B+ (3.25)';
    } else if (selected == 3.00) {
      return 'Grade B (3.00)';
    } else if (selected == 2.75) {
      return 'Grade B- (2.75)';
    } else if (selected == 2.50) {
      return 'Grade C+ (2.50)';
    } else if (selected == 2.25) {
      return 'Grade C (2.25)';
    } else if (selected == 2.00) {
      return 'Grade D (2.00)';
    }
  }

  double _updateGradeAsString(String selected) {
    if (selected == 'Select grade') {
      return 0.0;
    } else if (selected == 'Grade A+ (4.00)') {
      return 4.00;
    } else if (selected == 'Grade A (3.75)') {
      return 3.75;
    } else if (selected == 'Grade A- (3.50)') {
      return 3.50;
    } else if (selected == 'Grade B+ (3.25)') {
      return 3.25;
    } else if (selected == 'Grade B (3.00)') {
      return 3.00;
    } else if (selected == 'Grade B- (2.75)') {
      return 2.75;
    } else if (selected == 'Grade C+ (2.50)') {
      return 2.50;
    } else if (selected == 'Grade C (2.25)') {
      return 2.25;
    } else if (selected == 'Grade D (2.00)') {
      return 2.00;
    }
  }

  double addValueToList(double grade, double credit) {
    var calCulation = grade * credit;
    return calCulation;
  }

  double getSum(List value) {
    var sum = 0.0;
    for (int i = 0; i < value.length; i++) {
      sum = sum + value[i];
    }
    return sum;
  }

  double getSgpa() {
    var totalGrade = getSum(sumList);
    var totalCredit = getSum(creditList);
    return totalGrade / totalCredit;
  }

  void onChangeGrade(String value) {
    setState(() {
      _currentItemSelected = value;
    });
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
                  /*  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Congratulations",
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ],
                  ),*/
                  InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.teal[800],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0)),
                      ),
                      child: Text(
                        "Congratulations",
                        style: TextStyle(fontSize: 24.0, color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Text(
                        "Your SGPA  : $result",
                        style: TextStyle(fontSize: 25.0),
                      )),
                ],
              ),
            ),
          );
        });
  }
}
