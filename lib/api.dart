import 'dart:core';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class API {
  final String _hostName;

  API(this._hostName);

  Future<String> getInfo(String cdServico, cepOrigem, cepDestino) async {
    var getResponse = await http.get(Uri.parse(
        'http://$_hostName/calculador/CalcPrecoPrazo.asmx/CalcPrazo?nCdServico=$cdServico&sCepOrigem=$cepOrigem&sCepDestino=$cepDestino'));

    if (getResponse.statusCode == 200) {
      var document = xml.XmlDocument.parse(getResponse.body);
      // var element = document.findAllElements('Servicos');
      var info = document.findAllElements('PrazoEntrega').first.text;

      if (info == '' || info == '0') {
        info = document.findAllElements('MsgErro').first.text;
      } else {
        info = 'O prazo para entrega é de ' + info + ' dias.';
      }
      return info;
    } else {
      return 'Erro. Status: ' + getResponse.statusCode.toString();
    }
  }
}
