import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';
import 'package:rac/main.dart';

import 'package:rac/screens/device_screen.dart';

class ScanDevicesScreen extends StatefulWidget {
  ScanDevicesScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ScanDevicesScreenState createState() => _ScanDevicesScreenState();
}

class _ScanDevicesScreenState extends State<ScanDevicesScreen> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<ScanResult> scanResultList = [];
  bool _isScanning = false;

  @override
  initState() {
    super.initState();
    // Redefinição do Bluetooth
    initBle();
  }

  void initBle() {
    // Obter status para verificação do Bluetooth
    flutterBlue.isScanning.listen((isScanning) {
      _isScanning = isScanning;
      setState(() {});
    });
  }

  /*
  Função de início/parada de digitalização
  */
  scan() async {
    if (!_isScanning) {
      // se não estiver escaneando
      // Excluir a lista digitalizada anteriormente
      scanResultList.clear();
      // inicia a varredura, tempo limite de 4 segundos
      flutterBlue.startScan(timeout: Duration(seconds: 20));
      // ouvinte do resultado da varredura
      flutterBlue.scanResults.listen((results) {
        // Copia os resultados no formato List<ScanResult> para scanResultList
        scanResultList = results;
        // Atualizar IU
        setState(() {});
      });
    } else {
      // Se estiver escaneando, pare de escanear
      flutterBlue.stopScan();
    }
  }

  /*
    A partir daqui, funções para saída por dispositivo
   */
   /* Widget de valor de sinal do dispositivo */
  Widget deviceSignal(ScanResult r) {
    return Text(r.rssi.toString());
  }

  /* Widget de endereço MAC do dispositivo */
  Widget deviceMacAddress(ScanResult r) {
    return Text(r.device.id.id);
  }

  /* Widget de nome do dispositivo */
  Widget deviceName(ScanResult r) {
    String name = '';

    if (r.device.name.isNotEmpty) {
      // Se device.name tiver um valor
      name = r.device.name;
    } else if (r.advertisementData.localName.isNotEmpty) {
      // se o advertisementData.localName tiver um valor
      name = r.advertisementData.localName;
    } else {
      // Nome desconhecido
      name = 'N/A';
    }
    return Text(name);
  }

 /* Widget de ícone BLE */
  Widget leading(ScanResult r) {
    return CircleAvatar(
      child: Icon(
        Icons.bluetooth,
        color: Colors.white,
      ),
      backgroundColor: Colors.cyan,
    );
  }

  /* Função chamada quando um item do dispositivo é tocado */
  void onTap(ScanResult r) {
    // imprime o nome
    print('${r.device.name}');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DeviceScreen(device: r.device)),
    );
  }

 /* widget de item do dispositivo */
  Widget listItem(ScanResult r) {
    return ListTile(
      onTap: () => onTap(r),
      leading: leading(r),
      title: deviceName(r),
      subtitle: deviceMacAddress(r),
      trailing: deviceSignal(r),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        /* imprimir lista de dispositivos */
        child: ListView.separated(
          itemCount: scanResultList.length,
          itemBuilder: (context, index) {
            return listItem(scanResultList[index]);
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        ),
      ),
      /* Procura ou para de procurar por dispositivos */
      floatingActionButton: FloatingActionButton(
        onPressed: scan,
        // Exibe um ícone de parada se a varredura estiver em andamento e um ícone de pesquisa se estiver em um estado parado
        child: Icon(_isScanning ? Icons.stop : Icons.search),
      ),
    );
  }
}



