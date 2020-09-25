

import 'package:essf/servicecategories/Education.dart';
import 'package:essf/servicecategories/Housingandhomeless.dart';
import 'package:essf/servicecategories/Mentalhealth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';



  typedef pressed = void Function(BuildContext);

class Services {
  final String services;
  final pressed onPressed;
  

  Services({@required this.services, this.onPressed});

  static List<Services> serviceItems() {
    return <Services>[
      Services(
        onPressed:(BuildContext context) =>print('hello'),
        services: 'Alcohol and Drugs',
      ),
      Services(
        services: 'Children and Families',
      ),
      Services(
        onPressed: (BuildContext context){print('hello');},
        services: 'Disability Support',
      ),
      Services(
        onPressed: (BuildContext context)=>Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (BuildContext context) =>Education(
            ))),
        services: 'Education, training & employment',
      ),
      Services(
        onPressed: null,
        services: 'Family & Domestic Violence',
      ),
      Services(
        onPressed:(BuildContext context)=>Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (BuildContext context) =>HousingandHomelessness(
            ))),
        services: 'Housing and Homelessness',
      ),
      Services(
        onPressed: (BuildContext context){Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (BuildContext context) =>MentalHealth(
            )));},
        services: 'Mental Health Recovery',
      ),
    ];
  }
}


