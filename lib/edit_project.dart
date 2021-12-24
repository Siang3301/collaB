import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:../widget/date_picker_widget.dart';
import 'package:../widget/date_range_picker_widget.dart';
import 'package:../widget/datetime_picker_widget.dart';

class FormFour extends StatefulWidget {
  @override
  _FormFourState createState() => _FormFourState();
}

class _FormFourState extends State<FormFour> with Validator {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final double minValue = 8.0;

  int experienceIndex = 0;

  final TextStyle _errorStyle = TextStyle(
    color: Colors.red,
    fontSize: 16.6,
  );

  @override
  void initState() {
    _onCreated();
    super.initState();
  }

  void _onCreated() async {
    await SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  void _onTapEmoji(int index) {
    setState(() {
      experienceIndex = index;
    });
  }

  final Color activeColor = Colors.pink[400];
  final Color inActiveColor = Colors.grey[50];

  Widget buildPages() {
    switch (index) {
      case 0:
        return Scaffold(
          backgroundColor: Colors.pink,
          body: Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DatePickerWidget(),
                const SizedBox(height: 24),
                DateRangePickerWidget(),
              ],
            ),
          ),
        );
      case 1:
        return Scaffold(
          backgroundColor: Colors.pink,
          body: Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DatetimePickerWidget(),
              ],
            ),
          ),
        );
      default:
        return Container();
    }
  }

  Widget _buildName() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: minValue),
      child: TextFormField(
        controller: _nameController,
        validator: usernameValidator,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            errorStyle: _errorStyle,
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(vertical: minValue, horizontal: minValue),
            labelText: 'Project Name',
            labelStyle: TextStyle(fontSize: 16.0, color: Colors.black87)),
      ),
    );
  }

  Widget _buildEmail() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: minValue),
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.text,
        validator: validateEmail,
        onChanged: (String value) {},
        decoration: InputDecoration(
            errorStyle: _errorStyle,
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(vertical: minValue, horizontal: minValue),
            labelText: 'Collaborator',
            labelStyle: TextStyle(fontSize: 16.0, color: Colors.black87)),
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: minValue, vertical: minValue),
      child: TextFormField(
        controller: _messageController,
        keyboardType: TextInputType.text,
        maxLines: 2,
        decoration: InputDecoration(
            errorStyle: _errorStyle,
            border: InputBorder.none,
            labelText: 'Project Description',
            contentPadding: EdgeInsets.symmetric(horizontal: minValue),
            labelStyle: TextStyle(fontSize: 16.0, color: Colors.black87)),
      ),
    );
  }

  Widget _buildTextBackground(Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(2)),
      child: child,
    );
  }

  Widget _buildSubmitBtn() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: minValue * 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          gradient:
              LinearGradient(colors: [Colors.pink[700], Colors.pink[400]])),
      child: RaisedButton(
        onPressed: () => null,
        padding: EdgeInsets.symmetric(vertical: minValue * 2.4),
        elevation: 0.0,
        color: Colors.transparent,
        textColor: Colors.white,
        child: Text('SAVE'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/feedback-four-bg.webp'),
                fit: BoxFit.cover)),
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.bottomCenter, colors: [
            Colors.black.withOpacity(0.8),
            Colors.black.withOpacity(0.7)
          ])),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: minValue * 5,
                        ),
                        Text(
                          "Edit Project",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 48.0,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 110.0,
                          child: Container(
                            height: 4,
                            color: Colors.pink[400],
                          ),
                        ),
                        SizedBox(
                          height: minValue * 2,
                        ),
                        Text(
                          "Edit project name, collaborator, date \n and description",
                          style: TextStyle(
                              fontSize: 16.0, color: Colors.grey[200]),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: minValue * 7,
                        ),
                        Text(
                          "How was your experience?",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: minValue,
                        ),
                        _buildEmoji(),
                        SizedBox(
                          height: minValue * 4,
                        ),
                        _buildTextBackground(_buildName()),
                        SizedBox(
                          height: minValue * 2,
                        ),
                        _buildTextBackground(_buildEmail()),
                        SizedBox(
                          height: minValue * 2,
                        ),
                        _buildTextBackground(_buildDescription()),
                        SizedBox(
                          height: minValue * 6,
                        ),
                        _buildSubmitBtn()
                      ],
                    ),
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
