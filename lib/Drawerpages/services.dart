import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';


class Services  {
  final String services;
  final Function onTap;

Services({@required this.services, this.onTap});

   static List<Services> serviceItems() {
    return <Services>[
      Services(
        onTap: null,
        services: 'Alcohol and Drugs', 
      ),

      Services(
        onTap: _launchURL,
        services: 'Children and Families',
      ),
      Services(
        onTap: null,
        services: 'Disability Support',
      ),
      Services(
        onTap: null,
        services: 'Education, training & employment',
      ),
      Services(
        onTap: null,
        services: 'Family & Domestic Violence',
      ),
      Services(
        onTap: null,
        services: 'Housing and Homelessness',
      ),
      Services(
        onTap: null,
        services: 'Mental Health Recovery',
      ),
    ];
  }
}
_launchURL() async {
  const url = 'https://www.missionaustralia.com.au/services?categoryIDs%5B%5D=185&postcode=&keywords=';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}