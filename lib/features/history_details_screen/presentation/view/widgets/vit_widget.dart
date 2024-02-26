import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hisksa/widgets/item_line.dart';

import '../../../data/model/history_details_model.dart';
import 'item_line_check_null.dart';

class VitWidget extends StatelessWidget {
  final VITALSIGNS vitalsigns;

  const VitWidget({Key? key, required this.vitalsigns}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemLineNullCheck(icon: Fontisto.thermometer_alt, keyText: 'درجة الحرارة' , value: vitalsigns.tEMPERATURE ?? '',),
        ItemLineNullCheck(icon: Fontisto.heartbeat_alt, keyText: 'نبض القلب' , value: vitalsigns.pULSE ?? '',),
        ItemLineNullCheck(icon: Fontisto.stethoscope, keyText: 'ضغط الدم -- ارتفاع' , value: vitalsigns.bLOODPRESSUREHI ?? '',),
        ItemLineNullCheck(icon: Fontisto.stethoscope, keyText: 'ضغط الدم -- انخفاض' , value: vitalsigns.bLOODPRESSURELO ?? '',),
        ItemLineNullCheck(icon: Fontisto.wind, keyText: 'التنفس' , value: vitalsigns.rESPIRATORYRATE ?? '',),
        ItemLineNullCheck(icon: MaterialCommunityIcons.human_male_height, keyText: 'الطول' , value: vitalsigns.height ?? '',),
        ItemLineNullCheck(icon: MaterialCommunityIcons.human_male_height, keyText: 'الطول بالنسبة' , value: '${vitalsigns.hEIGHTPERCENT} %' ?? '',),
        ItemLineNullCheck(icon: MaterialCommunityIcons.weight_kilogram, keyText: 'الوزن' , value: vitalsigns.weight ?? '',),
        ItemLineNullCheck(icon: MaterialCommunityIcons.weight, keyText: 'الوزن بالنسبة' , value: '${vitalsigns.wEIGHTPERCENT} %'?? '',),
        ItemLineNullCheck(icon: Entypo.bar_graph, keyText: 'BMI' , value: vitalsigns.bMI ?? '',),
        ItemLineNullCheck(icon: MaterialCommunityIcons.head_outline, keyText: 'محيط الرأس' , value: vitalsigns.hEADCIRCUM ?? '',),
        ItemLineNullCheck(icon: MaterialCommunityIcons.head_outline, keyText: 'محيط الرأس بالنسبة' , value: '${vitalsigns.hEADCIRCUMPERCENT} %'?? '',),
        ItemLineNullCheck(icon: Fontisto.bandage, keyText: 'الألم' , value: vitalsigns.pAIN?? '',),
        ItemLineNullCheck(icon: Fontisto.test_tube_alt, keyText: 'تحليل FBS' , value: vitalsigns.fBS?? '',),
        ItemLineNullCheck(icon: Fontisto.test_tube_alt, keyText: 'تحليل RBS' , value: vitalsigns.rBS?? '',),
      ],
    );
  }
}


