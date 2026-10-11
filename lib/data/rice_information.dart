class RiceInformation {
  static const Map<String, Map<String, Map<String, String>>> data = {
    'กข6': {
      'th': {
        'name': 'กข6',
        'description': 'กข6 เป็นข้าวเหนียวที่นิยมปลูกมาก เมล็ดยาวเรียว ข้าวเปลือกสีน้ำตาล เหมาะสำหรับการบริโภคและให้คุณภาพการหุงต้มดี',
      },
      'en': {
        'name': 'RD6',
        'description': 'RD6 is a popular glutinous rice variety. It has long slender grains and brown paddy rice, with good cooking quality for consumption.',
      },
    },
    'สันป่าตอง': {
      'th': {
        'name': 'สันป่าตอง',
        'description': 'สันป่าตองเป็นข้าวเหนียวที่มีเมล็ดเรียวยาว คุณภาพการหุงต้มดี และเป็นสายพันธุ์ที่พบในพื้นที่ปลูกข้าวเหนียวหลายแห่ง',
      },
      'en': {
        'name': 'San Pa Tong',
        'description': 'San Pa Tong is a glutinous rice variety with long slender grains and good cooking quality. It is found in several sticky rice growing areas.',
      },
    },
    'นางสวน': {
      'th': {
        'name': 'นางสวน',
        'description': 'นางสวนเป็นข้าวเหนียวพื้นเมือง เมล็ดมีขนาดปานกลางถึงเรียวยาว นิยมใช้บริโภคในท้องถิ่น',
      },
      'en': {
        'name': 'Nang Suan',
        'description': 'Nang Suan is a local glutinous rice variety. Its grains are medium to slender and it is commonly consumed in local communities.',
      },
    },
    'อีขาวใหญ่': {
      'th': {
        'name': 'อีขาวใหญ่',
        'description': 'อีขาวใหญ่เป็นข้าวเหนียวพื้นเมืองที่มีเมล็ดค่อนข้างใหญ่ สีขาว และมีลักษณะเด่นเฉพาะของสายพันธุ์',
      },
      'en': {
        'name': 'E Khao Yai',
        'description': 'E Khao Yai is a local glutinous rice variety with relatively large white grains and distinctive variety characteristics.',
      },
    },
    'ขี้ตมหางนาค': {
      'th': {
        'name': 'ขี้ตมหางนาค',
        'description': 'ขี้ตมหางนาคเป็นข้าวเหนียวพื้นเมือง เมล็ดมีลักษณะเฉพาะ และเป็นสายพันธุ์ที่เหมาะกับการศึกษาความหลากหลายของข้าวพื้นถิ่น',
      },
      'en': {
        'name': 'Khi Tom Hang Nak',
        'description': 'Khi Tom Hang Nak is a local glutinous rice variety with distinctive grain characteristics. It is useful for studying local rice diversity.',
      },
    },
    'อีขาวน้อย': {
      'th': {
        'name': 'อีขาวน้อย',
        'description': 'อีขาวน้อยเป็นข้าวเหนียวพื้นเมืองไวต่อช่วงแสง มีใบสีเขียวมีขน ทรงกอแบะ รวงยาวเฉลี่ย 25 เซนติเมตร และเปลือกเมล็ดสีฟาง',
      },
      'en': {
        'name': 'E Khao Noi',
        'description': 'E-Khao-Noi is a local glutinous rice variety sensitive to photoperiod. It has green, hairy leaves, a spreading growth habit, 25 cm panicles, and straw-colored husks.',
      },
    },
  };

  static String name(String label, String lang) {
    return data[label]?[lang]?['name'] ?? label;
  }

  static String description(String label, String lang) {
    return data[label]?[lang]?['description'] ??
        (lang == 'en' ? 'No variety information found.' : 'ไม่พบข้อมูลรายละเอียดสายพันธุ์');
  }
}
