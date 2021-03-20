import 'package:app/core/models/transporter.dart';
import 'package:app/core/services/service_locator.dart';
import 'package:app/core/services/validation_service.dart';
import 'package:app/core/view_models/account_edit_view_model.dart';
import 'package:app/ui/common/style.dart';
import 'package:app/ui/common/view_state.dart';
import 'package:app/ui/widgets/utility/busy_overlay_screen.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class AccountEditingScreen extends StatefulWidget {
  final ValidationService _validator = locator<ValidationService>();
  static const route = '/accountEditingScreen';
  final formKey = GlobalKey<FormState>();
  final Transporter account;

  AccountEditingScreen({Key key, @required this.account}) : super(key: key);

  @override
  _AccountEditingScreenState createState() => _AccountEditingScreenState();
}

class _AccountEditingScreenState extends State<AccountEditingScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _userPhoneNumberController =
      TextEditingController();

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _userPhoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TemplateBaseViewModel<AccountEditViewModel>(
        onModelReady: (model) {
          _firstNameController.text = widget.account.firstName;
          _lastNameController.text = widget.account.lastName;
          _emailController.text = widget.account.userEmailAddress;
          _userPhoneNumberController.text = widget.account.userPhoneNumber;
          model.setTransporterAccount(widget.account);
        },
        builder: (context, model, child) => BusyOverlayScreen(
            show: model.state == ViewState.Busy,
            child: Scaffold(
                body: Center(
              child: SingleChildScrollView(
                  child: Form(
                key: widget.formKey,
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.all(5.0)),
                        Text(
                          'Edit Account',
                          style: TextStyle(
                              fontSize: LargeTextSize,
                              color: NavyBlue,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20.0,
                          ),
                        ),
                        CircleAvatar(
                          radius: 53,
                          backgroundColor: NavyBlue,
                          child: model.selectedImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.file(
                                    model.selectedImage,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    scale: 1.0,
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  width: 100,
                                  height: 100,
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.grey[800],
                                  ),
                                ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 40.0,
                          ),
                        ),
                        TextFormField(
                          key: ObjectKey("First Name"),
                          validator: widget._validator.stringFieldValidator,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "First Name"),
                          controller: _firstNameController,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20.0,
                          ),
                        ),
                        TextFormField(
                          key: ObjectKey("Last Name"),
                          validator: widget._validator.stringFieldValidator,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Last Name"),
                          controller: _lastNameController,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20.0,
                          ),
                        ),
                        TextFormField(
                          key: ObjectKey("Email"),
                          validator: widget._validator.emailValidator,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), labelText: "Email"),
                          controller: _emailController,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20.0,
                          ),
                        ),
                        TextFormField(
                          key: ObjectKey("Phone Number"),
                          controller: _userPhoneNumberController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Phone Number"),
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            PhoneInputFormatter(),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20.0,
                          ),
                        ),
                        SizedBox(
                          height: 42,
                          width: 200,
                          child: RaisedButton(
                            onPressed: () {
                              model.selectImage();
                            },
                            child: Text('Update Photo',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                            color: NavyBlue,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20.0,
                          ),
                        ),
                        SizedBox(
                          height: 42,
                          width: 200,
                          child: RaisedButton(
                            onPressed: () {
                              if (widget.formKey.currentState.validate()) {
                                model.saveTransporterAccount(
                                  userEmailAddress:
                                      _emailController.text.trim(),
                                  firstName: _firstNameController.text.trim(),
                                  lastName: _lastNameController.text.trim(),
                                  userPhoneNumber:
                                      _userPhoneNumberController.text.trim(),
                                );
                              }
                            },
                            child: Text('Save',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                            color: NavyBlue,
                          ),
                        ),
                        TextButton(
                          child: Text(
                            'Cancel and go back to your account',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(140, 129, 70, 1),
                            ),
                          ),
                          onPressed: () => model.navigateToAccount(),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
            ))));
  }
}
