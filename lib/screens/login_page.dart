import 'package:cartelera/screens/home_screen.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = '';
  String _password = '';
  String _name = '';
  String _user = 'admin';
  String _contra = 'admin';

  TextEditingController _inputFieldDateController = new TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ScrollController _scrollController = new ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar sesión'),
      ),
      body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          children: <Widget>[_iniciarSesion()]),
    );
  }

  Widget _iniciarSesion() {
    return Column(
      key: _formKey,
      children: <Widget>[
        _crearInput('Correo Electrónico', 'Correo', 'Correo Electrónico',
            Icon(Icons.account_circle), _emailController),
        Divider(),
        _crearInput('Password', 'Password', 'Password', Icon(Icons.lock),
            _passwordController),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _email = _emailController.text;
                _password = _passwordController.text;
              });
              if (_email == _user && _password == _contra) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute<Null>(builder: (context) => HomeScreen()),
                    (Route<dynamic> route) => false);
              } else {
                _mostrarAlert(context);
                print('La contraseña y/o usuario son inválidos');
              }
            },
            child: const Text('Submit'),
          ),
        ),
      ],
    );
  }

  Widget _crearInput(hint, label, helper, Icon, TextEditingController) {
    return TextFormField(
      controller: TextEditingController,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: hint,
        labelText: label,
        helperText: helper,
        icon: Icon,
      ),
      onChanged: (value) {
        setState(() {
          _name = value;
        });
      },
    );
  }

  void _mostrarAlert(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Datos incorrectos'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                    'El usuario y/o contraseña son incorrectos, inténtelo nuevamente.'),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancelar'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop(context);
                },
              ),
            ],
          );
        });
  }
}
