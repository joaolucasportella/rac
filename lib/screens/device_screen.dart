/*import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DeviceScreen extends StatefulWidget {
  const DeviceScreen({Key? key, required this.device}) : super(key: key);
  // Receber informações do dispositivo
  final BluetoothDevice device;

  @override
  _DeviceScreenState createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  // flutterBlue
  FlutterBlue flutterBlue = FlutterBlue.instance;

  // String de exibição do status de conexão
  String stateText = 'Conectando...';

  // Botão de desconexão
  String connectButtonText = 'Disconectar';

  // Salvar o estado de conexão atual
  BluetoothDeviceState deviceState = BluetoothDeviceState.disconnected;

  // Para liberar o ouvinte quando a tela estiver fechada
  StreamSubscription<BluetoothDeviceState>? _stateListener;

  @override
  initState() {
    super.initState();
    _stateListener = widget.device.state.listen((event) {
      debugPrint('event :  $event');
      if (deviceState == event) {
        // Ignorar se o status for o mesmo
        return;
      }
      // Alterar informações do estado da conexão
      setBleConnectionState(event);
    });
    connect();
  }

  @override
  void dispose() {
    // limpar a lista de status
    _stateListener?.cancel();
    disconnect();
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      // Atualize apenas quando a tela estiver montada
      super.setState(fn);
    }
  }

  /* Atualização do status da conexão*/
  setBleConnectionState(BluetoothDeviceState event) {
    switch (event) {
      case BluetoothDeviceState.disconnected:
        stateText = 'Disconectado';
        // alterar o estado do botão
        connectButtonText = 'Conectar';
        break;
      case BluetoothDeviceState.disconnecting:
        stateText = 'Disconectando...';
        break;
      case BluetoothDeviceState.connected:
        stateText = 'Conectado';
        // alterar o estado do botão
        connectButtonText = 'Disconectar';
        break;
      case BluetoothDeviceState.connecting:
        stateText = 'Conectando...';
        break;
    }
    //Salvar eventos de estado anteriores
    deviceState = event;
    setState(() {});
  }

  /* iniciar conexão */
  Future<bool> connect() async {
    Future<bool>? returnValue;
    setState(() {
      /* Altera a exibição de status para Conectando*/
      stateText = 'Conectando...';
    });

    /* 
      Defina o tempo limite para 10 segundos (10.000 ms) e desative a conexão automática
      Para referência, se a conexão automática estiver definida como verdadeira, a conexão poderá ser atrasada..
     */
    await widget.device
        .connect(autoConnect: false)
        .timeout(const Duration(milliseconds: 10000), onTimeout: () {
      //ocorreu o tempo limite
      //define returnValue como false
      returnValue = Future.value(false);
      debugPrint('timeout');

      //Altere o estado de conexão para desconectado
      setBleConnectionState(BluetoothDeviceState.disconnected);
    }).then((data) {
      if (returnValue == null) {
        //Se returnValue for nulo, a conexão será bem-sucedida porque não ocorreu nenhum tempo limite.
        debugPrint('conexão feita com sucesso');
        returnValue = Future.value(true);
      }
    });

    return returnValue ?? Future.value(false);
  }

  /* desconectar */
  void disconnect() {
    try {
      setState(() {
        stateText = 'Disconectando...';
      });
      widget.device.disconnect();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.device.name),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // estado da conexão
          Text(stateText),
          OutlinedButton(
              onPressed: () {
                if (deviceState == BluetoothDeviceState.connected) {
                  //Desconectar se conectado
                  disconnect();
                } else if (deviceState == BluetoothDeviceState.disconnected) {
                  // Conectar se desconectado
                  connect();
                } else {}
              },
              child: Text(connectButtonText)),
        ],
      )),
    );
  }
}*/
