import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculate Mileage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FuelForm(),
    );
  }
}

class FuelForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FuelFormState();
}

class _FuelFormState extends State<FuelForm> {
  String result = '';
  final double _formDistance = 5.5;
  final _currencies = ['USD', 'EUR', 'GBP'];
  String _currency = 'USD';
  TextEditingController mileageController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController distanceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        title: Text("Mileage Calculator"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.only(top: _formDistance, bottom: _formDistance),
              child: TextField(
                //distance text field
                controller: distanceController,
                decoration: InputDecoration(
                    hintText: 'Enter distance here',
                    labelStyle: textStyle,
                    labelText: 'Distance',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: _formDistance, bottom: _formDistance),
              child: TextField(
                //mileage text field
                controller: mileageController,
                decoration: InputDecoration(
                    hintText: 'Mileage estimate',
                    labelStyle: textStyle,
                    labelText: 'Distance / unit',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
                padding:
                    EdgeInsets.only(top: _formDistance, bottom: _formDistance),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        //price text field
                        controller: priceController,
                        decoration: InputDecoration(
                            hintText: 'e.g. 3.5',
                            labelStyle: textStyle,
                            labelText: 'Petrol Price',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Container(width: _formDistance * 5),
                    Expanded(
                        child: DropdownButton<String>(
                      items: _currencies.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value:
                          _currency, //set the value of the button to the _currency string
                      onChanged: (String value) {
                        _onDrowpDownChanged(
                            value); //when the drop down menu selected item changes call change the value funtion
                      },
                    ))
                  ],
                )),
            // we use row here to make the two raised buttons beside each other
            // we use xpanded to make them file the width of the screen
            // we use container between them to make a white space between the tw buttons
            // I added an if condition to show error message if not all values are set
            Row(
              children: <Widget>[
                Expanded(
                    child: RaisedButton(
                  color: Theme.of(context).primaryColorDark,
                  textColor: Theme.of(context).primaryColorLight,
                  child: Text(
                    'Calculate',
                    textScaleFactor: 1.5,
                  ),
                  //this form will create a function on the fly , i.e. no name, just steps to execute, I dont like it but it's what they have in the course
                  onPressed: () {
                    setState(() {
                      if (distanceController.text != '' &&
                          mileageController.text != '' &&
                          priceController.text != '') {
                        result = _calculate();
                      } else {
                        result = 'Please enter all values';
                      }
                    });
                  },
                )),
                Container(
                  width: _formDistance * 5,
                ),
                Expanded(
                    child: RaisedButton(
                  color: Theme.of(context).buttonColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  child: Text(
                    'Reset',
                    textScaleFactor: 1.5,
                  ),
                  //the form below of coding will create a function on the fly , i.e. no name, just steps to execute, I dont like it but it's what they have in the course
                  onPressed: () {
                    setState(() {
                      result = '';
                      mileageController.text = '';
                      priceController.text = '';
                      distanceController.text = '';
                    });
                  },
                ))
              ],
            ),
            Text(result)
          ],
        ),
      ),
    );
  }

  //change the dropdown menu selection to the value
  _onDrowpDownChanged(String value) => setState(() {
        this._currency = value;
      });
  String _calculate() {
    double _distance = double.parse(distanceController.text);
    double _price = double.parse(priceController.text);
    double _mileage = double.parse(mileageController.text);
    double _totalCost = (_price * _distance / (_mileage));
    String _result =
        'Your trip cost is ' + _totalCost.toStringAsFixed(2) + ' ' + _currency;
    return _result;
  }
}
