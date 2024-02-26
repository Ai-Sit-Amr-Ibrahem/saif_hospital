import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hisksa/features/history_details_screen/data/model/history_details_model.dart';
import 'package:hisksa/features/history_details_screen/presentation/view/widgets/item_line_check_null.dart';

class RiskFactorsWidget extends StatelessWidget {
  final RISKFACTORS riskfactors;
  const RiskFactorsWidget({Key? key, required this.riskfactors,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemLineNullCheck(keyText: 'CHRONIC', value: riskfactors.cHRONIC??'', icon: IconlyBroken.arrowLeft2),
        ItemLineNullCheck(keyText: 'CONGENITAL', value: riskfactors.cONGENITAL??'', icon: IconlyBroken.arrowLeft2),
        ItemLineNullCheck(keyText: 'Rta', value: riskfactors.rTA??'', icon: IconlyBroken.arrowLeft2),
        ItemLineNullCheck(keyText: 'wORKRELATED', value: riskfactors.wORKRELATED??'', icon: IconlyBroken.arrowLeft2),
        ItemLineNullCheck(keyText: 'vACCINATION', value: riskfactors.vACCINATION??'', icon: IconlyBroken.arrowLeft2),
        ItemLineNullCheck(keyText: 'cHECKUP', value: riskfactors.cHECKUP??'', icon: IconlyBroken.arrowLeft2),
        ItemLineNullCheck(keyText: 'pSYCHIATRIC', value: riskfactors.pSYCHIATRIC??'', icon: IconlyBroken.arrowLeft2),
        ItemLineNullCheck(keyText: 'iNFERTILITY', value: riskfactors.iNFERTILITY??'', icon: IconlyBroken.arrowLeft2),
        ItemLineNullCheck(keyText: 'pREGNANCY', value: riskfactors.pREGNANCY??'', icon: IconlyBroken.arrowLeft2),
        ItemLineNullCheck(keyText: 'iNDICATELMP', value: riskfactors.iNDICATELMP??'', icon: IconlyBroken.arrowLeft2),
        ItemLineNullCheck(keyText: 'eMERGENCYCASE', value: riskfactors.eMERGENCYCASE??'', icon: IconlyBroken.arrowLeft2),
        ItemLineNullCheck(keyText: 'dURATIONOFILLNESS', value: riskfactors.dURATIONOFILLNESS??'', icon: IconlyBroken.arrowLeft2),
        ItemLineNullCheck(keyText: 'DMY', value: riskfactors.dMY??'', icon: IconlyBroken.arrowLeft2),
      ],
    );
  }
}
