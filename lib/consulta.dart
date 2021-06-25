import 'package:flutter/material.dart';
import 'api.dart';

class Consulta extends StatefulWidget {
  @override
  ConsultaState createState() => ConsultaState();
}

class ConsultaState extends State<Consulta> {
  final API api = API('ws.correios.com.br');
  late TextEditingController _controllerCdServico;
  late TextEditingController _controllerCepOrigem;
  late TextEditingController _controllerCepDestino;

  static const defaultMargin = 10.0;
  static const defaultFontSize = 16.0;

  @override
  void initState() {
    super.initState();
    _controllerCdServico = TextEditingController();
    _controllerCepOrigem = TextEditingController();
    _controllerCepDestino = TextEditingController();
  }

  @override
  void dispose() {
    _controllerCdServico.dispose();
    _controllerCepOrigem.dispose();
    _controllerCepDestino.dispose();
    super.dispose();
  }

  void alert(String title, String content, {bool buttonless = false}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              if (buttonless)
                TextButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
            ],
          );
        });
  }

  Widget _label(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: defaultFontSize, color: Colors.black),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consulta Correios'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                margin:
                    EdgeInsets.only(top: defaultMargin, bottom: defaultMargin),
                child: Column(
                  children: [
                    _label('Codigo Serviço:'),
                    TextField(
                      controller: _controllerCdServico,
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: defaultMargin, bottom: defaultMargin),
                child: Column(
                  children: [
                    _label('Cep Origem:'),
                    TextField(
                      controller: _controllerCepOrigem,
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: defaultMargin, bottom: defaultMargin),
                child: Column(
                  children: [
                    _label('Cep Destino:'),
                    TextField(
                      controller: _controllerCepDestino,
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  consultar();
                },
                child: Container(
                    width: MediaQuery.of(context).size.width / 2.6,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.shade400,
                            offset: Offset(2, 4),
                            blurRadius: 5,
                            spreadRadius: 2),
                      ],
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: Text(
                        'Consultar',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    )),
              ),
              TextButton(
                onPressed: () {
                  _controllerCdServico.text = '';
                  _controllerCepOrigem.text = '';
                  _controllerCepDestino.text = '';
                },
                child: Container(
                    width: MediaQuery.of(context).size.width / 2.6,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.shade400,
                            offset: Offset(2, 4),
                            blurRadius: 5,
                            spreadRadius: 2),
                      ],
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: Text(
                        'Limpar campos',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  void consultar() async {
    String apiResponse = '';
    String servico = _controllerCdServico.text;
    String origem = _controllerCepOrigem.text;
    String destino = _controllerCepDestino.text;

    if (servico.isEmpty)
      alert('Alerta', 'Preencha o campo Codigo Serviço para continuar.',
          buttonless: true);
    else if (origem.isEmpty)
      alert('Alerta', 'Preencha o campo Cep Origem para continuar.',
          buttonless: true);
    else if (destino.isEmpty)
      alert('Alerta', 'Preencha o campo Cep Destino para continuar.',
          buttonless: true);
    else {
      alert('Aguarde', 'Consultando...');

      apiResponse = await api.getInfo(servico, origem, destino);

      Navigator.of(context).pop();

      alert('Resultado', apiResponse, buttonless: true);
    }
  }
}
