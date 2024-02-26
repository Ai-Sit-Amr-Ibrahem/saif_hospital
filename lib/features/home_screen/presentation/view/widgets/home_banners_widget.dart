import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeBannersWidget extends StatelessWidget {
  const HomeBannersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: List.generate(carousalList.length, (index) {
        return SizedBox(
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              carousalList[index],
              fit: BoxFit.cover,
            ),
          ),
        );
      }),
      options: CarouselOptions(
        scrollPhysics: const BouncingScrollPhysics(),
        height: MediaQuery.of(context).size.height * 0.23,
        enlargeCenterPage: true,
        initialPage: 0,
        viewportFraction: 0.75,
        enableInfiniteScroll: true,
        autoPlay: true,
        reverse: false,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(seconds: 1),
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}


List<String> carousalList = [
  'https://img.freepik.com/free-photo/empty-modern-medical-office-having-disease-documents-table-equipped-with-contemporary-furniture-hospital-workplace-with-nobody-it-ready-sickness-consultation-medicine-support_482257-35871.jpg?w=900&t=st=1678701897~exp=1678702497~hmac=e61bb9729c015f90028e01b67b35544337c0cb14da4c3289ff9745b046676f4e',
  'https://img.freepik.com/free-photo/doctor-with-stethoscope-hands-hospital-background_1423-1.jpg?w=900&t=st=1678701946~exp=1678702546~hmac=c775f99b5d1ed8d19354be1c999e9e022c5914b9dac89bc80c38c23cba957af2',
  'https://img.freepik.com/free-photo/hands-unrecognizable-female-doctor-writing-form-typing-laptop-keyboard_1098-20374.jpg?w=900&t=st=1678701978~exp=1678702578~hmac=e581a66285fcbc601eeefe6b04ca3e1e8a6eba2d51e8bb0db5eb39cb7f0da697',
  'https://img.freepik.com/free-photo/young-handsome-physician-medical-robe-with-stethoscope_1303-17818.jpg?w=900&t=st=1678702050~exp=1678702650~hmac=faff6e471bc0bfbed11620680ab19ebdfe11572ccd412709cd691768b9197080',
  'https://img.freepik.com/free-photo/doctor-nurses-special-equipment_23-2148980721.jpg?w=740&t=st=1678702076~exp=1678702676~hmac=fd58c1bdbc6b7ce921816ba3b5ba789b4d8a140912200a3980ceafbeefc07787',
];