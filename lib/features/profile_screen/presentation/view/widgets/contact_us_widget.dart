import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsWidget extends StatelessWidget {
  final String? phoneNumber;
  final String? whatsappNumber;
  final String? mapLink;
  final String? instagramLink;
  final String? fbLink;
  final String? twLink;
  final String? linkedLink;
  final String? youtubeLink;
  final String? webLink;

  const ContactUsWidget({
    Key? key,
     this.webLink,
     this.phoneNumber,
     this.whatsappNumber,
     this.mapLink,
     this.instagramLink,
     this.fbLink,
     this.twLink,
     this.linkedLink,
     this.youtubeLink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        webLink == null? const SizedBox() :IconItem(
          imagePath: 'assets/images/weblink.png',
          fct: () async {
            String url = webLink!;
            if (await canLaunch(url)) {
              await launch(url);
            }
          },
        ),
        fbLink == null? const SizedBox() :IconItem(
          imagePath: 'assets/images/facebook.png',
          fct: () async {
            String url = fbLink!;
            if (await canLaunch(url)) {
              await launch(url);
            }
          },
        ),
        instagramLink == null? const SizedBox() :IconItem(
          imagePath: 'assets/images/instagram.png',
          fct: () async {
            String url = instagramLink!;
            if (await canLaunch(url)) {
              await launch(url);
            }
          },
        ),
        twLink == null? const SizedBox() :IconItem(
          imagePath: 'assets/images/twitter.png',
          fct: () async {
            String url = twLink!;
            if (await canLaunch(url)) {
              await launch(url);
            }
          },
        ),
        linkedLink == null? const SizedBox() :IconItem(
          imagePath: 'assets/images/linkedin.png',
          fct: () async {
            String url = linkedLink!;
            if (await canLaunch(url)) {
              await launch(url);
            }
          },
        ),
        youtubeLink == null? const SizedBox() :IconItem(
          imagePath: 'assets/images/youtube.png',
          fct: () async {
            String url = youtubeLink!;
            if (await canLaunch(url)) {
              await launch(url);
            }
          },
        ),
        whatsappNumber == null? const SizedBox() :IconItem(
          imagePath: 'assets/images/whatsapp.png',
          fct: () async {
            String url = 'https://wa.me/$whatsappNumber';
            if (await canLaunch(url)) {
              await launch(url);
            }
          },
        ),
        mapLink == null? const SizedBox() :IconItem(
          imagePath: 'assets/images/maps.png',
          fct: () async {
            String url = mapLink!;
            if (await canLaunch(url)) {
              await launch(url);
            }
          },
        ),
        phoneNumber == null? const SizedBox() :IconItem(
          imagePath: 'assets/images/apple.png',
          fct: () async {
            String url = 'tel: $phoneNumber';
            if (await canLaunch(url)) {
              await launch(url);
            }
          },
        ),
      ],
    );
  }
}

class IconItem extends StatelessWidget {
  final String imagePath;
  final Function() fct;

  const IconItem({Key? key, required this.imagePath, required this.fct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: InkWell(
        onTap: fct,
        child: Image.asset(
          imagePath,
          height: 33,
        ),
      ),
    );
  }
}