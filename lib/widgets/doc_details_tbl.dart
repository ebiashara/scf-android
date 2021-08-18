import 'package:flutter/material.dart';

class DocumentDetailsTable extends StatefulWidget {
  DocumentDetailsTable({Key key}) : super(key: key);

  @override
  _DocumentDetailsTableState createState() => _DocumentDetailsTableState();
}

class _DocumentDetailsTableState extends State<DocumentDetailsTable> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'Type',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Reference',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Amount',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ],
              rows: const <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('INV')),
                    DataCell(Text('10002160')),
                    DataCell(Text('5000')),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
