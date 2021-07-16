import 'package:flutter/material.dart';

class Variables {
  static List<Entry> sideBarMenuList() {
    final List<Entry> data = <Entry>[
      Entry('DashBoard', Icons.dashboard, <Entry>[
        Entry('DashBoard'),
        Entry('Client Request'),
        Entry('User Request'),
      ]),
      Entry('All Category', Icons.category_outlined, <Entry>[
        Entry('Film Media'),
        Entry('Television Media'),
        Entry('Audio Media'),
        Entry('Print Media'),
        Entry('New Media'),
        Entry('Important & Emergency'),
      ]),
      Entry('Banner', Icons.branding_watermark, <Entry>[
        Entry('Index Banner'),
        Entry('Content Banner'),
        Entry('Pop Up Banner'),
      ]),
      Entry('Page NavBar', Icons.branding_watermark, <Entry>[
        Entry('Editors View'),
        Entry('Set Cover Photo'),
        Entry('Set Rate Chart Banner'),
      ]),
      Entry('Settings', Icons.settings_applications_outlined, <Entry>[
        Entry('Change Password'),
      ]),
      Entry('About Us', Icons.info_outlined, <Entry>[
        Entry('Contact Information'),
      ]),
    ];

    return data;
  }

  List filmMediaList = [
    'Film Institution',
    'Film Producer & Distributor',
    'Film Director',
    'Film Editor',
    'Film Artist',
    'Film Story Writer',
    'Cinematographer',
    'Film Art Director',
    'Film Fight Director',
    'Film Dance Director',
    'Film Assistant Director',
    'Management Information',
    'BACCPro Member',
    'Important Telephone Number',
    'Cinema Hall',
  ];

  List getFilmMediaList() {
    return filmMediaList;
  }

  List televisionList = [
    'Television Channel',
    'Audiovisual Technical Support',
    'AudioVisual Equipment Sales & Service',
    'Production House, Advertising Agency & Event Organizer',
    // 'Mass Media Education',
    'Mass Media Education (University)',
    'Mass Media Education (Training Institute)',
    'Photo Session Studio',
    'Archive & Media Monitoring Company',
    'Shooting Location',
    'Satellite Channel Distributor',
    'Group Theater',
    'Artist',
    'Magician',
    'Script Writer & Director',
    'Mass Media Teacher(University)',
    'Cameraman',
    'Art Director',
    'Engineer',
    'Video Editor & Animator',
    'Assistant Director',
    'Choreographer',
    'Professional Photographer',
    'DJ',
    'Make-up Artist',
    'Management Information',
    'Rate Chart'
  ];
  List getTelevisionList() {
    return televisionList;
  }

  List televidionChennelList = [
    'Bangladesh Television',
    'Channel I',
    'ATN Bangla',
    'RTV',
    'ATN NEWS',
    'MAASRANGA',
    'CHANNEL 9',
    'INDEPENDENT',
    'DESH TV',
    'DBC NEWS',
    'SA TV',
    'BIJOY TV',
    'DURUNTO TELEVISION',
    'BANGLA TV',
    'NTV',
    'BANGLA VISION',
    'ETV',
    'GTV',
    'BOISHAKHI',
    'NAGORIK TV',
    'ASIAN TV',
    'CHANNEL 24',
    'SOMOY TELEVISION',
    'JAMUNA TV',
    'EKATTOR TV',
    'NEWS 24',
    'NAGORIK TELEVISION',
    'MOHONA TELEVISION',
    'My TV',
    'ANANDA TV'
  ];

  List getTVChannelList() {
    return televidionChennelList;
  }

  List televidionManagmentList = [
    'All Television Channel',
    'Open University',
    'AVTOA',
    'Tele Producer Association',
    'Tele Diector Association',
    'Tele Artist  Association',
    'Tele Nattokar Songo',
    'Presenters Association',
    'Cameraman Association',
    'Shommiloto Sangskritik Zoot',
    'Banladesh group theater',
    'EMMA',
    'Makeup Artist & Shooting House Association',
    'Assistant Director Association'
  ];

  List getTVManagmentList() {
    return televidionManagmentList;
  }

  List audioManagmentList = [
    'MUSIC INDUSTRIES OWNERS ASSOCIATION OF BANGLADESH',
    'RADIO TODAY 89.6 FM',
    'RADIO AAMAR 88.4 FM',
    'SPICE FM 96.4',
    'PEOPLES RADIO 91.6 FM',
    'DHAKA FM 90.4',
    'RADIO SHADHIN92.4 FM',
    'ABC RADIO 89.2 FM',
    'RADIO BHUMI 92.8 FM',
    'RADIO DHONI 91.2 FM',
    'JAGO FM 94.4',
    'ASIAN RADIO90.8 FM',
    'RADIO CAPITAL FM 94.8',
    'RADIO DHOL 94.0 FM',
    'COLOURSFM101.6'
  ];

  List getAudioManagmentList() {
    return audioManagmentList;
  }

  List printManagmentList = [
    'MANAGING BOARD OF BANGLADESH PRESS INSTITUTE',
    'DAILY PROTHOM ALO',
    'DAILY JUGANTOR',
    'DAILY JAI JAI DIN',
    'DAILY KALER KANTHO',
    'DAILY SAMAKAL',
    'DAILY JANAKANTHA',
    'DAILY AMADER SOMOY',
    'DAILY MANABZAMIN',
    'DAILY SHOKALER KHABOR',
    'DAILY SANGRAM',
    'DAILY AMAR BARTA',
    'BACHSAS (BANGLADESH CHOLOCHITRA SANGBADIK SAMITY)',
    'BANGLADESH CULTURAL REPORTERS ASSOCIATION (BCRA)',
    'BANGLADESH BINODON SANGBADIK SOMITY (BABISAS)',
    'MEDIA JOURNALIST ASSOCIATION OF BANGLADESH (MEJAB)',
  ];

  List getPrintManagmentList() {
    return printManagmentList;
  }

  List importantManagmentList = [
    'BSB-CAMBRIAN EDUCATION GROUP',
    'PLEDGE HARBOR INTERNATIONAL SCHOOL',
  ];

  List getImportantManagmentList() {
    return importantManagmentList;
  }

  List audioChannelList = [
    'Bangladesh Betar',
    'Radio Today',
    'Radio Aamar',
    'Radio Dhoni',
    'Radio Bhumi',
    'Dhaka FM',
    'Radio Foorti',
    'Peoples Radio',
    'ABC Radio',
    'Spice FM',
    'Radio Shadhin',
    'Radio Capital',
    'Radio Dhol',
  ];
  List getaudioChannelList() {
    return audioChannelList;
  }

  List audioMediaList = [
    'FM Radio Channel',
    'Community FM Radio Channel',
    'Music Industries Producer',
    'Audio Recording Studio',
    'Music Equipment Sales Center',
    'Sound System & Color Light Rent House',
    'Singer',
    'Music Director',
    'Lyricist',
    'Voice Artist',
    'Reciter (Abritteekar)',
    'Musician',
    'Rate Chart',
    'Management Information',
  ];
  List getAudioMediaList() {
    return audioMediaList;
  }

  List printingMediaList = [
    'Daily News Paper',
    'Magazine',
    'Cultural Journalist',
    'Rate Chart',
    'Offset Print',
    'Flexible Print',
    'Digital Print',
    'Pre Press',
    'Printing Machine Equipment & Accessories',
    'Packaging Industries',
    'Paper House',
    'All Printing Works Service Provider',
    'Freelance Graphic Designer',
    'Management Information',
  ];
  List getPrintingMediaList() {
    return printingMediaList;
  }

  List newMediaList = [
    'Digital Audio - Video Content Provider',
    'Online News Portal',
    'Online Television Channel',
    'Online Radio Channel',
    'Online Bazar',
    'Website Developer',
    'Honorable Media Personality Death List',
  ];
  List getNewMediaList() {
    return newMediaList;
  }

  List importentEmergencyList = [
    'Bangladesh : At A Glance',
    'Corporate Information',
    'Education Service-National & International',
    'Management Information (Education Service Company)',
    'Parlor',
    'Interior ,Exterior & Architect',
    'Importent & Emergency',
  ];
  List getImportentEmergencyList() {
    return importentEmergencyList;
  }
}

class Entry {
  final String title;
  final IconData? iconData;
  final List<Entry>
      children; //Since this is an expansion list...children can be another list of entries.
  Entry(this.title, [this.iconData, this.children = const <Entry>[]]);
}
