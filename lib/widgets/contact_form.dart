import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ContactFormState();
}

class ContactFormState extends State<ContactForm> {
  String name;
  String issue;
  int email;
  int phone;
  List<Step> steps;
  int stepperIndex = 0;
  var formKey = GlobalKey<FormState>();
  var isLoading = false;

  var nameController = TextEditingController();
  var nameValidate = false;


  void startNameValidate(){
    this.setState((){this.nameValidate = true;});
  }

  ContactFormState() {

    nameController.addListener(startNameValidate);

    steps = [
      Step(
          title: Text("User"),
          content: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                autocorrect: false,
                autovalidate: nameValidate,
                controller: nameController,
                onSaved: (name) {
                  this.name = name;
                },
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter name';
                  }
                },
                decoration: new InputDecoration(
                    labelText: 'Enter your name',
                    hintText: 'Enter a name',
                    //filled: true,
                    icon: const Icon(Icons.person),
                    labelStyle:
                        new TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                autovalidate: true,
                onSaved: (email) {
                  this.email = int.tryParse(email) ?? 420;
                },
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter your E-Mail';
                  }
                },
                decoration: new InputDecoration(
                    labelText: 'Enter your E-Mail',
                    hintText: 'Enter a E-Mail',
                    //filled: true,
                    icon: const Icon(Icons.mail),
                    labelStyle:
                    new TextStyle(decorationStyle: TextDecorationStyle.solid)),
              )
            ],
          )),
      Step(
          title: Text("Phone"),
          content: TextFormField(
            keyboardType: TextInputType.number,
            autocorrect: false,
            autovalidate: true,
            onSaved: (phone) {
              this.phone = int.tryParse(phone) ?? 420;
            },
            maxLines: 1,
            validator: (value) {
              if (value.isEmpty || value.length < 1) {
                return 'Please enter your phone number';
              }
            },
            decoration: new InputDecoration(
                labelText: 'phone number',
                hintText: 'phone number',
                //filled: true,
                icon: const Icon(Icons.phone),
                labelStyle:
                    new TextStyle(decorationStyle: TextDecorationStyle.solid)),
          )),
      Step(
          title: Text("Issue"),
          content: TextFormField(
            keyboardType: TextInputType.text,
            autocorrect: false,
            autovalidate: true,
            onSaved: (issue) {
              this.issue = issue ?? 420;
            },
            maxLines: 7,
            validator: (value) {
              if (value.isEmpty || value.length < 1) {
                return 'How can we help you?';
              }
            },
            decoration: new InputDecoration(
                labelText: 'issue',
                hintText: 'issue',
                //filled: true,
                icon: const Icon(Icons.chat),
                labelStyle:
                    new TextStyle(decorationStyle: TextDecorationStyle.solid)),
          )),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
      autovalidate: false,
      key: formKey,
      child:
          Stepper(
            steps: this.steps,
            type: StepperType.horizontal,
            currentStep: stepperIndex,
            onStepContinue: () {
              //if last step show confirmation dialog
              if(this.stepperIndex == this.steps.length-1){
                if(formKey.currentState.validate()){
                  formKey.currentState.save();
                  showDialog(
                      context: context,
                      builder: (BuildContext context){
                          return AlertDialog(
                            title: Text("Submit form"),
                            // content: isLoading ? Container(child: Center(child: CircularProgressIndicator()), height: 80): Container(),
                            actions: <Widget>[
                              RaisedButton(
                                color: Colors.green,
                                child: Text("Submit"),
                                textColor: Colors.white,
                                onPressed: () => print("send data: name: $name mail: $email phone: $phone issue: $issue")

                              ),
                              RaisedButton(
                                color: Colors.red,
                                child: Text("Cancel"),
                                textColor: Colors.white,
                                onPressed: () => print("no"),
                              )
                            ],
                        );
                      }
                  );
                }
              }
              else{
                setState(() {
                  this.stepperIndex++;
                });
              }
            },
            onStepCancel: () {
              setState(() {
                this.stepperIndex--;
              });
            },
            onStepTapped: (index) {
              setState(() {
                this.stepperIndex = index;
              });
            },
          )
    );
  }
}
