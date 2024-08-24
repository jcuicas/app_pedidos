import 'package:app_pedidos/components/my_appbar.dart';
import 'package:app_pedidos/components/my_button_drawer.dart';
import 'package:app_pedidos/components/my_drawer.dart';
import 'package:app_pedidos/inherited/my_inherited.dart';
import 'package:app_pedidos/models/cliente.dart';
import 'package:app_pedidos/providers/obtener_datos_clientes.dart';
import 'package:app_pedidos/providers_off/obtener_datos_clientes_off.dart';
import 'package:app_pedidos/screens/ver_pedidos.dart';
import 'package:app_pedidos/storage/client_storage.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class OrdenPedido extends StatefulWidget {
  const OrdenPedido({super.key});

  @override
  State<OrdenPedido> createState() => _OrdenPedidoState();
}

class _OrdenPedidoState extends State<OrdenPedido> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<List<Cliente>>? listaClientes;

  final clientStorage = ClientStorage();

  String? selectedValueClient;

  final textEditingControllerClient = TextEditingController();

  @override
  void dispose() {
    textEditingControllerClient.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (GetInfoUser.of(context).conexion!) {
      listaClientes = obtenerClientes();
    } else {
      listaClientes = obtenerClientesLocal();
    }

    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(),
      appBar: MyAppBar(
        myButtonDrawer: MyButtonDrawer(
          scaffoldKey: _scaffoldKey,
        ),
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              leading: Image.asset('assets/img/order.png'),
              title: Text(
                'Realizar pedido',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              subtitle: Text('Emisión del pedido'),
              trailing: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VerPedidos(),
                    ),
                  );
                },
                icon: Icon(Icons.shopping_cart_sharp),
              ),
            ),
          ),

          /* CLIENTES */
          FutureBuilder(
            future: listaClientes,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        'Seleccionar cliente',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: snapshot.data! //items
                          .map((item) => DropdownMenuItem(
                                value: '${item.cliente} - ${item.id}',
                                child: Text(
                                  item.cliente,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: selectedValueClient,
                      onChanged: (value) {
                        setState(() {
                          selectedValueClient = value;
                        });
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 40,
                        width: 200,
                      ),
                      dropdownStyleData: const DropdownStyleData(
                        maxHeight: 200,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                      dropdownSearchData: DropdownSearchData(
                        searchController: textEditingControllerClient,
                        searchInnerWidgetHeight: 50,
                        searchInnerWidget: Container(
                          height: 50,
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 4,
                            right: 8,
                            left: 8,
                          ),
                          child: TextFormField(
                            expands: true,
                            maxLines: null,
                            controller: textEditingControllerClient,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              hintText: 'Buscar un cliente...',
                              hintStyle: const TextStyle(fontSize: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        searchMatchFn: (item, searchValue) {
                          return item.value.toString().contains(searchValue);
                        },
                      ),
                      //This to clear the search value when you close the menu
                      onMenuStateChange: (isOpen) {
                        if (!isOpen) {
                          textEditingControllerClient.clear();
                        }
                      },
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('No hay datos de clientes...'),
                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }
}
