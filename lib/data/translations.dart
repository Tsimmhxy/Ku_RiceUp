// ไฟล์: lib/data/translations.dart
class T {
  static const Map<String, Map<String, String>> texts = {
    'th': {
      'appTitle': 'KU RiceUp',
      'homeTitle': 'KU RiceUp',
      'homeSubtitle': 'ยกระดับการจำแนกสายพันธุ์ข้าวเหนียว',
      'camera': 'ถ่ายภาพเมล็ดข้าว',
      'gallery': 'เลือกรูปภาพจากแกลเลอรี',
      'homeTip':
          'คำแนะนำ: ควรถ่ายภาพเมล็ดข้าวให้ชัดเจน\nมีแสงเพียงพอ และพื้นหลังไม่รบกวน',
      'previewTitle': 'ตรวจสอบรูปภาพ',
      'selectedImage': 'รูปภาพเมล็ดข้าวที่เลือก',
      'previewTip':
          'ตรวจสอบให้แน่ใจว่าเมล็ดข้าวชัดเจน\nแสงเพียงพอ และไม่มีวัตถุรบกวนภาพ',
      'startClassify': 'เริ่มจำแนกสายพันธุ์',
      'chooseAgain': 'เลือกรูปภาพใหม่',
      'resultTitle': 'ผลการจำแนก',
      'analyzing': 'กำลังวิเคราะห์...',
      'analyzingRice': 'กำลังวิเคราะห์เมล็ดข้าว...',
      'resultHeader': 'ผลการจำแนกสายพันธุ์ข้าวเหนียว',
      'detectedVariety': '🌾 สายพันธุ์ที่ตรวจพบ',
      'confidence': 'ความเชื่อมั่น',
      'confidenceLevel': 'ระดับความเชื่อมั่น',
      'veryHigh': 'สูงมาก',
      'high': 'สูง',
      'medium': 'ปานกลาง',
      'retake': 'ควรถ่ายภาพใหม่',
      'varietyDetail': 'รายละเอียดสายพันธุ์',
      'classifyAgain': 'จำแนกภาพใหม่',
      'unknownDescription': 'ไม่พบข้อมูลรายละเอียดสายพันธุ์',
      'unableToReadImage': 'ไม่สามารถอ่านรูปภาพได้',

      // เมนู
      'navHome': 'หน้าแรก',
      'navHistory': 'ประวัติแปลง',
      'navKnowledge': 'ความรู้',

      // ประวัติ
      'historyTitle': 'ประวัติแปลง',
      'historyEmpty': 'ยังไม่มีประวัติการตรวจสอบ',

      // หน้าความรู้ (GAP)
      'detailsTitle': 'รายละเอียด',
      'knowledgeHeader': 'การคัดเลือกและผลิตเมล็ดพันธุ์ข้าวคุณภาพดี',
      'corePrinciples':
          'สรุป 3 หลักสำคัญ:\n1. เริ่มต้นให้ดี: พื้นที่เหมาะสม + เมล็ดพันธุ์คุณภาพ\n2. ป้องกันข้าวปน: หัวใจของคุณภาพเมล็ดพันธุ์\n3. จัดการหลังเก็บเกี่ยวให้ถูกวิธี',

      'gap1Title': 'การเลือกพื้นที่ปลูก',
      'gap1Desc': 'ดินอุดมสมบูรณ์ และเคยปลูกพันธุ์เดียวกันมาก่อน',
      'gap1Full':
          '• ดินอุดมสมบูรณ์สม่ำเสมอทั่วแปลง อุ้มน้ำดี ควบคุมน้ำเข้า-ออกได้\n• เป็นพื้นที่ที่ปลูกข้าวพันธุ์เดียวกันกับฤดูก่อน หากเปลี่ยนพันธุ์ ต้องปลูกด้วยวิธีปักดำ\n• จัดทำผังแปลง รหัสแปลง และบันทึกประวัติแปลงย้อนหลัง\n• การเว้นระยะห่าง: ปลูกวิธีหว่านเว้น 3 เมตร, ปักดำเว้น 1 เมตร (หรือใช้แถวคุม)',

      'gap2Title': 'การเตรียมดินและวิธีปลูก',
      'gap2Desc': 'ลดปริมาณวัชพืชและข้าวเรื้อ',
      'gap2Full':
          '• เตรียมดินเพื่อลดข้าวเรื้อและวัชพืช ล่อให้งอกแล้วไถกลบ 1-3 ครั้งก่อนปลูกจริง\n• แนะนำปลูกแบบนาดำ/ปักดำ เพราะควบคุมพันธุ์ปนง่ายกว่านาหว่าน\n• ห้ามปลูกซ่อมข้าวที่ตายโดยใช้ต้นกล้าจากแหล่งอื่น\n• ใช้อัตราเมล็ดพันธุ์ที่เหมาะสม (ปักดำ 7-10 กก./ไร่, นาหว่าน 18-24 กก./ไร่)',

      'gap3Title': 'การเลือกเมล็ดพันธุ์ก่อนปลูก',
      'gap3Desc': 'ใช้ชั้นพันธุ์หลัก/ขยาย ความงอกไม่ต่ำกว่า 80%',
      'gap3Full':
          '• ใช้เมล็ดพันธุ์ชั้นพันธุ์หลัก หรือชั้นพันธุ์ขยาย จากแหล่งที่เชื่อถือได้\n• ความงอกต้องไม่ต่ำกว่า 80% ไม่มีพันธุ์อื่นหรือเมล็ดวัชพืชปน\n• บันทึกแหล่งที่มา ชื่อพันธุ์ ปริมาณ และวันเดือนปีที่จัดซื้อทุกครั้ง\n• กรณีใช้เมล็ดพันธุ์ที่คลุกสารเคมี ต้องทำตามคำแนะนำอย่างเคร่งครัด',

      'gap4Title': 'การตัดพันธุ์ปน',
      'gap4Desc': 'เดินตรวจแปลงถอนต้นที่ผิดปกติให้ครบ 5 ระยะ',
      'gap4Full':
          'ต้องเดินตรวจและกำจัดพันธุ์ปนใน 5 ระยะ:\n1. ระยะกล้า (ดูสีใบ ความสูง)\n2. ระยะแตกกอ (ความสูง ทรงกอ ข้าวแดง)\n3. ระยะออกดอก (สีรวง เวลาออกดอก)\n4. ระยะโน้มรวง (สีเมล็ด หาง)\n5. ระยะก่อนเก็บเกี่ยว (สำคัญที่สุด)\n*เกณฑ์มาตรฐาน: ข้าวพันธุ์อื่นต้องไม่เกิน 1 ต้น ต่อ 10,000 ต้น',

      'gap5Title': 'การตรวจสอบคุณภาพเมล็ดพันธุ์',
      'gap5Desc': 'ตรวจสอบความบริสุทธิ์และสิ่งเจือปน',
      'gap5Full':
          '• ชั้นพันธุ์หลัก: เมล็ดพันธุ์สุทธิ ≥98%, สิ่งเจือปน ≤2%, ข้าวพันธุ์อื่น ≤1 เมล็ด/1,000ก.\n• ชั้นพันธุ์ขยาย: ข้าวพันธุ์อื่น ≤15 เมล็ด/500ก.\n• ชั้นพันธุ์จำหน่าย: ข้าวพันธุ์อื่น ≤20 เมล็ด/500ก.\n• ต้องสุ่มตัวอย่างตรวจสอบคุณภาพเมล็ดพันธุ์ทุกเดือนและก่อนจำหน่ายทุกครั้ง',

      'gap6Title': 'การเก็บเกี่ยว',
      'gap6Desc': 'เมล็ดในรวงสุกแก่ไม่น้อยกว่า 90%',
      'gap6Full':
          '• เก็บเกี่ยวเมื่อเมล็ดสุกแก่ไม่น้อยกว่า 90%\n• ทำความสะอาดเครื่องเก็บเกี่ยว เครื่องนวด และภาชนะขนย้าย ทุกครั้งทั้งก่อนและหลังใช้งาน\n• หากแปลงติดกับพันธุ์อื่น ห้ามเก็บเกี่ยวแถวคุม (แนวกันชน 1 เมตร) มาทำเมล็ดพันธุ์',

      'gap7Title': 'การตาก',
      'gap7Desc': 'ตากบนลานสะอาด หมั่นกลับกองเมล็ด',
      'gap7Full':
          '• ทำความสะอาดลานตากและวัสดุรองพื้นก่อนใช้งาน ไม่ให้มีข้าวพันธุ์อื่นปนเปื้อน\n• ตากเมล็ดพันธุ์บนลานหรือวัสดุรองพื้นที่แห้งและสะอาด\n• หมั่นกลับกองเมล็ดพันธุ์สม่ำเสมอ เพื่อให้แห้งทั่วถึง',

      'gap8Title': 'การลดความชื้น',
      'gap8Desc': 'ลดความชื้นให้เหลือ ≤12% ภายใน 24 ชม.',
      'gap8Full':
          '• ต้องลดความชื้นทันที หรือภายใน 24 ชั่วโมงหลังเก็บเกี่ยว ให้เหลือไม่เกิน 12%\n• กรณีใช้เครื่องอบ ควรใช้อุณหภูมิไม่เกิน 42 องศาเซลเซียส เพื่อไม่ให้กระทบความงอก\n• บันทึกวันที่ สภาพอากาศ และอุณหภูมิที่ใช้อบ',

      'gap9Title': 'การเก็บรักษา',
      'gap9Desc': 'เก็บในที่อากาศถ่ายเท ป้องกันความชื้น',
      'gap9Full':
          '• สถานที่เก็บต้องสะอาด ระบายอากาศดี ป้องกันความชื้นและสัตว์พาหะ\n• วางกองเมล็ดพันธุ์บนพาเลทและมีช่องว่างให้สุ่มตรวจได้\n• ติดเครื่องหมายกำกับรุ่นเพื่อให้ตรวจสอบย้อนกลับได้\n• แยกพื้นที่เก็บเมล็ดพันธุ์ออกจากที่เก็บปุ๋ยและวัตถุอันตรายเด็ดขาด',
    },
    'en': {
      'appTitle': 'KU RiceUp',
      'homeTitle': 'KU RiceUp',
      'homeSubtitle':
          'Elevating the classification of\nglutinous rice varieties.',
      'camera': 'Take Rice Image',
      'gallery': 'Choose Image from Gallery',
      'homeTip':
          'Tip: Capture a clear image of rice grains\nwith sufficient lighting and a clean background.',
      'previewTitle': 'Image Preview',
      'selectedImage': 'Selected Rice Grain Image',
      'previewTip':
          'Make sure the rice grains are clear,\nwell-lit, and free from distracting objects.',
      'startClassify': 'Start Classification',
      'chooseAgain': 'Choose New Image',
      'resultTitle': 'Classification Result',
      'analyzing': 'Analyzing...',
      'analyzingRice': 'Analyzing rice grains...',
      'resultHeader': 'Sticky Rice Variety Classification Result',
      'detectedVariety': '🌾 Detected Variety',
      'confidence': 'Confidence',
      'confidenceLevel': 'Confidence Level',
      'veryHigh': 'Very High',
      'high': 'High',
      'medium': 'Moderate',
      'retake': 'Please retake the image',
      'varietyDetail': 'Variety Information',
      'classifyAgain': 'Classify New Image',
      'unknownDescription': 'No variety information found.',
      'unableToReadImage': 'Unable to read image',

      // Menu
      'navHome': 'Home',
      'navHistory': 'History',
      'navKnowledge': 'Knowledge',

      // History (เดิมขาดไป ทำให้หน้าประวัติแสดงภาษาไทยเมื่อสลับเป็นอังกฤษ)
      'historyTitle': 'Inspection History',
      'historyEmpty': 'No inspection history yet',

      // Knowledge (GAP)
      'detailsTitle': 'Details',
      'knowledgeHeader': 'Quality Rice Seed Selection and Production',
      'corePrinciples':
          '3 Core Principles:\n1. Good Start: Proper area + Quality seeds\n2. Prevent Contamination: Heart of seed quality\n3. Proper Post-harvest Management',

      'gap1Title': 'Area Selection',
      'gap1Desc': 'Fertile soil with same variety history',
      'gap1Full':
          '• Fertile soil that is uniform across the field, holds water well, and allows water to be controlled in and out\n• Choose a field that grew the same variety last season. If the variety is changed, the crop must be transplanted\n• Prepare a field layout, assign plot codes, and keep a record of the plot history\n• Isolation distance: 3 m for broadcast sowing, 1 m for transplanting (or use border rows)',

      'gap2Title': 'Soil Preparation and Planting',
      'gap2Desc': 'Reduce weeds and volunteer rice',
      'gap2Full':
          '• Prepare the soil to reduce volunteer rice and weeds: let them germinate, then plow them under 1-3 times before the actual planting\n• Transplanting is recommended because off-type mixing is easier to control than with broadcast sowing\n• Do not replant dead hills using seedlings from other sources\n• Use a suitable seed rate (transplanting 7-10 kg/rai, broadcast sowing 18-24 kg/rai)',

      'gap3Title': 'Seed Selection Before Planting',
      'gap3Desc': 'Use foundation/registered seed with ≥80% germination',
      'gap3Full':
          '• Use foundation or registered class seed from a reliable source\n• Germination must be at least 80%, with no other varieties or weed seeds mixed in\n• Record the source, variety name, quantity, and purchase date every time\n• If using chemically treated seed, follow the instructions strictly',

      'gap4Title': 'Roguing',
      'gap4Desc': 'Walk the field and remove off-types across 5 stages',
      'gap4Full':
          'Walk the field and remove off-type plants at 5 stages:\n1. Seedling stage (leaf color, height)\n2. Tillering stage (height, plant shape, red rice)\n3. Flowering stage (panicle color, flowering time)\n4. Panicle bending stage (grain color, awns)\n5. Pre-harvest stage (most important)\n*Standard: no more than 1 plant of another variety per 10,000 plants',

      'gap5Title': 'Seed Quality Inspection',
      'gap5Desc': 'Check purity and impurities',
      'gap5Full':
          '• Foundation seed: pure seed ≥98%, impurities ≤2%, other varieties ≤1 grain/1,000 g\n• Registered seed: other varieties ≤15 grains/500 g\n• Certified (for sale) seed: other varieties ≤20 grains/500 g\n• Sample and test seed quality every month and before every sale',

      'gap6Title': 'Harvesting',
      'gap6Desc': 'Harvest when at least 90% of grains are mature',
      'gap6Full':
          '• Harvest when at least 90% of the grains are mature\n• Clean the harvester, thresher, and transport containers before and after every use\n• If the field borders another variety, do not use the border rows (1 m buffer strip) for seed',

      'gap7Title': 'Drying',
      'gap7Desc': 'Dry on a clean surface and turn the seed regularly',
      'gap7Full':
          '• Clean the drying yard and ground cover before use so that no other varieties contaminate the seed\n• Dry the seed on a dry, clean yard or surface\n• Turn the seed regularly so that it dries evenly',

      'gap8Title': 'Moisture Reduction',
      'gap8Desc': 'Reduce to ≤12% within 24 hours',
      'gap8Full':
          '• Reduce moisture immediately, or within 24 hours after harvest, to no more than 12%\n• If using a dryer, keep the temperature at or below 42°C so that germination is not affected\n• Record the date, weather conditions, and drying temperature',

      'gap9Title': 'Storage',
      'gap9Desc': 'Store in a well-ventilated, dry place',
      'gap9Full':
          '• The storage area must be clean, well ventilated, and protected from moisture and pests\n• Stack seed on pallets and leave gaps so it can be sampled\n• Label each lot so it can be traced back\n• Keep seed storage strictly separate from fertilizer and hazardous materials',
    },
  };

  static String get(String key, String lang) {
    return texts[lang]?[key] ?? texts['th']?[key] ?? key;
  }
}
