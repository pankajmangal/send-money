import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money/bloc/transaction_history_bloc/transaction_history_bloc.dart';
import 'package:send_money/bloc/transaction_history_bloc/transaction_history_event.dart';
import 'package:send_money/bloc/transaction_history_bloc/transaction_history_state.dart';
import 'package:send_money/data/repository/transaction_history_repo.dart';
import 'package:send_money/utils/ColorUtils.dart';
import 'package:send_money/utils/StringUtils.dart';
import 'package:send_money/utils/StyleUtils.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  late TransactionHistoryBloc transactionHistoryBloc;

  @override
  void initState() {
    super.initState();
    if(!mounted) return;

    transactionHistoryBloc = BlocProvider.of<TransactionHistoryBloc>(context);
    transactionHistoryBloc.add(FetchTransactionDataFromServerEvent());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtils.transactionHistoryText,
        style: StyleUtils.appBarTextStyle)
      ),
      body: BlocBuilder<TransactionHistoryBloc, TransactionHistoryState>(builder: (context, state){
        return Container(
          width: size.width,
          height: size.height,
          color: ColorUtils.whiteColor,
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (_, index) {
                return ListTile(title: Text("List 1"));
              }),
        );
      })
    );
  }
}
