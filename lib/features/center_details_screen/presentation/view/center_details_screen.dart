import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hisksa/features/center_details_screen/presentation/view/widgets/center_header_widget.dart';
import 'package:hisksa/features/home_screen/presentation/view/widgets/dr_widget.dart';
import 'package:hisksa/utils/resources/app_colors.dart';
import 'package:hisksa/utils/resources/constants.dart';
import 'package:hisksa/widgets/item_line.dart';

class CenterDetailsScreen extends StatelessWidget {
  static const routeName = '/CenterDetailsScreen';

  const CenterDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(
            'https://cdn-dr-images.vezeeta.com/Assets/Images/Entities/ent11714da91fcb536b/Facilities/beverly-clinics-by-saudi-german-health--al-khalidiyyah-jeddah_20221002084919961.jpg',
          ),
        ),
      ),
      body: Column(
        children: [
          Accordion(
            paddingListBottom: 0,
            children: [
              AccordionSection(
                isOpen: true,
                leftIcon:
                    const Icon(FontAwesome.hospital_o, color: Colors.white),
                headerBackgroundColorOpened: AppColors.mainColor,
                header: Text(' المركز'),
                content: CenterHeaderWidget(),
                contentHorizontalPadding: 20,
                contentBorderWidth: 1,
                // onOpenSection: () => print('onOpenSection ...'),
                // onCloseSection: () => print('onCloseSection ...'),
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    TabBar(tabs: [
                      Tab(
                        text: 'الأطباء',
                      ),
                      Tab(
                        text: 'عن المركز',
                      ),
                      Tab(
                        text: 'التأمين الطبي',
                      ),
                    ]),
                    Expanded(
                      child: TabBarView(
                        children: [
                          ListView.builder(
                              itemBuilder: (context, index){
                            return Text('');
                          },
                          itemCount: 8,
                          ),
                          Center(child: Text('sad'),),
                          Center(child: Text('sad'),),
                        ],
                      ),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
