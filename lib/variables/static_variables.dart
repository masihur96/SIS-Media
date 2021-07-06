import 'package:flutter/material.dart';

class Variables {
  static List<Entry> sideBarMenuList() {
    final List<Entry> data = <Entry>[
      Entry('DashBoard', Icons.dashboard, <Entry>[
        Entry('DashBoard'),
        Entry('Celebrity Request'),
        Entry('User Request'),
      ]),
      Entry('All Category', Icons.category_outlined, <Entry>[
        Entry('Film Media'),
        Entry('Television Media'),
        Entry('Audio Media'),
        Entry('Print Media'),
        Entry('New Media'),
        Entry('Importent & Emergency'),
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
    'Production House',
    'Advertising Agency',
    'Event Organizer',
    'Mass Media Education',
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
    'Recitor (Abritteekar)',
    'Musician',
    'Rate Chart',
    'Managment Information',
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
    'Graphic Design Activities etc',
    'Freelancer Graphic Designer',
    'Managment Information',
    'BASISAS & MEJAB',
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
    'Managment Information (Education Service Company)',
    'Fashion House',
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
