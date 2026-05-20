class Crop {
  final String id;
  final String name;
  final String image;
  final String description;
  final String plantingTime;
  final String irrigation;
  final String fertilization;
  final String diseases;
  final String category;

  Crop({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.plantingTime,
    required this.irrigation,
    required this.fertilization,
    required this.diseases,
    required this.category,
  });
}

final List<Crop> dummyCrops = [
  Crop(
    id: '1',
    name: 'البطاطس',
    image: 'assets/images/potato.jpeg',
    description: 'تعتبر البطاطس من أهم المحاصيل الزراعية في مصر والعالم.',
    plantingTime:
        'تزرع في العروة الشتوية (سبتمبر-أكتوبر) والعروة الصيفية (يناير-فبراير).',
    irrigation: 'تحتاج إلى ري منتظم، يفضل الري بالتنقيط لتوفير المياه.',
    fertilization: 'تحتاج إلى تسميد نيتروجيني وفوسفاتي وبوتاسي بنسب متوازنة.',
    diseases: 'اللفحة المتأخرة، البياض الدقيقي، السوسة.',
    category: 'خضروات',
  ),
  Crop(
    id: '2',
    name: 'القمح',
    image: 'assets/images/wheat.jpeg',
    description:
        'المحصول الاستراتيجي الأول في مصر، يزرع في معظم الأراضي المصرية.',
    plantingTime: 'خلال شهر نوفمبر (من 15 إلى 30 نوفمبر).',
    irrigation: 'يحتاج إلى 4 إلى 5 ريات مشبعة خلال الموسم.',
    fertilization: 'اليوريا تحتل المركز الأول في احتياجات القمح المسادية.',
    diseases: 'الصدأ الأصفر، الصدأ البرتقالي، التفحم.',
    category: 'حبوب',
  ),
  Crop(
    id: '3',
    name: 'الطماطم',
    image: 'assets/images/tomato.jpeg',
    description: 'محصول صيفي وشتوي أساسي لا غنى عنه في كل البيوت.',
    plantingTime: 'تزرع على مدار العام في عروات مختلفة.',
    irrigation: 'حساسة جداً لزيادة الرطوبة، يفضل الري المحكم.',
    fertilization: 'تحتاج كميات كبيرة من البوتاسيوم في مرحلة عقد الثمار.',
    diseases: 'الذبول، الندوة المبكرة، فيروس تجعد الأوراق.',
    category: 'خضروات',
  ),
  Crop(
    id: '4',
    name: 'بسلة',
    image: 'assets/images/peas.jpeg',
    description:
        'من الخضروات الغنية بالبروتين والفيتامينات، وتُستخدم في العديد من الأطباق.',
    plantingTime: 'تزرع في فصل الشتاء من أكتوبر إلى نوفمبر.',
    irrigation: 'تحتاج إلى ري معتدل ومنتظم مع تجنب زيادة المياه.',
    fertilization:
        'يفضل التسميد بالسماد العضوي قبل الزراعة، وإضافة سماد نيتروجيني أثناء النمو.',
    diseases: 'البياض الدقيقي، الذبول، وتعفن الجذور.',
    category: 'خضروات',
  ),
  Crop(
    id: '5',
    name: 'خشب',
    image: 'assets/images/wooden tree.jpeg',
    description:
        'الأشجار الخشبية تُستخدم في صناعة الأثاث والبناء، وتتميز بعمرها الطويل.',
    plantingTime:
        'تزرع في مواسم مختلفة حسب النوع، وغالباً في الربيع أو الخريف.',
    irrigation: 'تحتاج إلى ري منتظم في السنوات الأولى، ثم تتحمل الجفاف نسبياً.',
    fertilization: 'يتم التسميد بالمواد العضوية لتحسين نمو الأشجار.',
    diseases: 'التسوس، الحشرات القشرية، وآفات الحفار.',
    category: 'أشجار',
  ),
  Crop(
    id: '6',
    name: 'بقوليات (الفول البلدي)',
    image: 'assets/images/fava beans.jpeg',
    description:
        'البقوليات مصادر غنية بالبروتين النباتي، وتلعب دوراً هاماً في تحسين خصوبة التربة بفضل تثبيت النيتروجين.',
    plantingTime:
        'تزرع عادة في فصل الخريف (أكتوبر ونوفمبر) في المناطق المعتدلة.',
    irrigation:
        'تحتاج إلى ري متوسط ومنتظم، مع تجنب تغريق التربة بالماء خاصة فترة التزهير.',
    fertilization:
        'تعتمد بشكل أساسي على الفسفور والبوتاسيوم، وتحتاج كميات قليلة من التسميد النيتروجيني.',
    diseases: 'الصدأ، التبقع البني، وحشرة المن.',
    category: 'بقوليات',
  ),
  Crop(
    id: '7',
    name: 'تفاح',
    image: 'assets/images/apple.jpeg',
    description: 'فاكهة غنية بالألياف وتنمو في المناطق المعتدلة.',
    plantingTime: 'الشتاء أو بداية الربيع',
    irrigation: 'ري عميق ومنتظم خاصة في مواسم الجفاف',
    fertilization: 'تسميد عضوي في فصل الشتاء',
    diseases: 'جرب التفاح، البياض الدقيقي',
    category: 'فواكه',
  ),
  Crop(
    id: '8',
    name: 'مانجو',
    image: 'assets/images/mango.jpeg',
    description: 'ملك الفواكه، تتميز بطعمها السكري ورائحتها القوية.',
    plantingTime: 'من مارس إلى أبريل',
    irrigation: 'ري منتظم خلال فترة الإزهار والإثمار',
    fertilization: 'تسميد عضوي وبوتاسيوم لتحسين جودة الثمار',
    diseases: 'العفن الأسود، لفحة الأزهار',
    category: 'فواكه',
  ),
  Crop(
    id: '9',
    name: 'فراولة',
    image: 'assets/images/strawberry.jpeg',
    description: 'فاكهة غنية بالفيتامينات، تزرع في الأراضي الرملية.',
    plantingTime: 'من سبتمبر إلى أكتوبر',
    irrigation: 'ري بالتنقيط للحفاظ على الثمار من التعفن',
    fertilization: 'تسميد نتروجيني وفوسفوري متوازن',
    diseases: 'العفن الرمادي، البياض الدقيقي',
    category: 'فواكه',
  ),
  Crop(
    id: '10',
    name: 'العدس',
    image: 'assets/images/lentils.jpeg',
    description:
        'محصول بقولي شتوي هام، غني بالبروتينات والألياف، ويساعد في تحسين خصوبة التربة.',
    plantingTime: 'يزرع عادة في فصل الخريف، وتحديداً في شهري أكتوبر ونوفمبر.',
    irrigation:
        'يحتاج إلى ري معتدل، ويتميز بقدرته العالية على تحمل الجفاف مقارنة ببقية البقوليات.',
    fertilization:
        'يتطلب التسميد الفسفوري بشكل أساسي لزيادة الإنتاجية وتنشيط العقد الجذرية.',
    diseases: 'الذبول، أعفان الجذور، وحشرة المن.',
    category: 'بقوليات',
  ),

  Crop(
    id: '11',
    name: 'خيار',
    image: 'assets/images/cucumber.jpeg',
    description: 'محصول صيفي منعش، ينمو بسرعة ويحتاج لتسلق.',
    plantingTime: 'من مارس إلى أبريل (عروة صيفية)',
    irrigation: 'ري منتظم ومكثف لضمان طعم غير مر',
    fertilization: 'تسميد عضوي ونيتروجيني في بداية النمو',
    diseases: 'البياض الزغبي، الذبول البكتيري',
    category: 'خضروات',
  ),
  Crop(
    id: '12',
    name: 'فلفل',
    image: 'assets/images/pepper.jpeg',
    description: 'يتنوع بين الحار والحلو، غني جداً بفيتامين سي.',
    plantingTime: 'من فبراير إلى مارس (تحت الصوب)',
    irrigation: 'ري معتدل لتجنب تساقط الأزهار',
    fertilization: 'تسميد بالبوتاسيوم عند تكوين الثمار',
    diseases: 'عفن الجذور، فيروس تبرقش الفلفل',
    category: 'خضروات',
  ),
  Crop(
    id: '13',
    name: 'البامية',
    image: 'assets/images/okra.jpeg',
    description:
        'محصول صيفي بامتياز، يتحمل درجات الحرارة العالية، وتعتبر ثمارها مصدراً جيداً للمعادن.',
    plantingTime:
        'تزرع في الأجواء الحارة (من فبراير إلى مايو)، ولا تتحمل الصقيع نهائياً.',
    irrigation:
        'تتحمل الجفاف نسبياً مقارنة بالخضروات الأخرى، ولكن الري المنتظم يحسن جودة القرون.',
    fertilization:
        'تحتاج إلى تسميد متوازن، ويفضل إضافة السماد الفسفوري قبل الزراعة.',
    diseases: 'المن، والديدان اللوزية، والبياض الدقيقي.',
    category: 'خضروات',
  ),
  Crop(
    id: '14',
    name: 'باذنجان',
    image: 'assets/images/eggplant.jpeg',
    description: 'يتحمل الحرارة العالية ويحتاج لتربة غنية بالعناصر.',
    plantingTime: 'من مارس إلى مايو',
    irrigation: 'ري غزير ومنتظم خاصة في الصيف',
    fertilization: 'تسميد فوسفوري لتقوية الجذور والأزهار',
    diseases: 'الذبول الفيرتسيليومي، حشرة المن',
    category: 'خضروات',
  ),

  Crop(
    id: '15',
    name: 'السبانخ',
    image: 'assets/images/spinach.jpeg',
    description:
        'من أهم الخضروات الورقية الشتوية، غنية جداً بالحديد والمعادن والفيتامينات.',
    plantingTime: 'تزرع في الأجواء الباردة، من شهر سبتمبر وحتى منتصف فبراير.',
    irrigation:
        'تحتاج إلى ري منتظم وقريب للحفاظ على رطوبة التربة ونضارة الأوراق.',
    fertilization:
        'تعتمد بشكل أساسي على التسميد النيتروجيني لزيادة النمو الخضري للأوراق.',
    diseases: 'تلطخ الأوراق، والبياض الزغبي، وحشرة المن.',
    category: 'خضروات',
  ),

  Crop(
    id: '16',
    name: 'الخس',
    image: 'assets/images/lettuce.jpeg',
    description:
        'من الخضروات الورقية سريعة النمو، تتميز بطعمها اللاذع قليلاً، وتستخدم في السلطات.',
    plantingTime: 'يزرع في الأجواء المعتدلة والباردة، من سبتمبر وحتى مارس.',
    irrigation: 'يحتاج إلى ري مستمر وقريب من السطح للحفاظ على طراوة الأوراق.',
    fertilization:
        'يعتمد على التسميد النيتروجيني لزيادة النمو الخضري، مع تجنب الإفراط لتجنب زيادة النترات.',
    diseases: 'البياض الزغبي، وحشرة المن.',
    category: 'خضروات',
  ),
  Crop(
    id: '17',
    name: 'الجزر',
    image: 'assets/images/carrot.jpeg',
    description:
        'محصول جذري هام، يتميز بمحتواه العالي من الكاروتين وفيتامين أ، ويحتاج تربة خفيفة.',
    plantingTime: 'يفضل زراعته من منتصف أغسطس إلى نهاية شهر أكتوبر.',
    irrigation:
        'يحتاج إلى ري منتظم؛ لأن تذبذب الري يؤدي إلى تشقق الجذور أو قسوتها.',
    fertilization:
        'يحتاج إلى تسميد بوتاسي عالي لزيادة حجم الجذور وجودة اللون والطعم.',
    diseases: 'لفحة الأوراق، ونيماتودا تعقد الجذور.',
    category: 'خضروات',
  ),
  Crop(
    id: '18',
    name: 'الكوسة',
    image: 'assets/images/zucchini.jpeg',
    description:
        'محصول خضري سريع النمو جداً، تمتاز ثمارها بسهولة الهضم وقيمتها الغذائية العالية.',
    plantingTime: 'تزرع في الربيع (مارس) وفي عروة خريفية (أغسطس وسبتمبر).',
    irrigation:
        'تحتاج إلى ري وفير ومنتظم نظراً لكبر حجم أوراقها التي تفقد المياه بسرعة.',
    fertilization:
        'تحتاج لتسميد عضوي جيد قبل الزراعة، وتسميد متوازن خلال فترة الإثمار.',
    diseases: 'البياض الدقيقي (الأكثر شيوعاً)، وفيروسات تبرقش الأوراق.',
    category: 'خضروات',
  ),
  Crop(
    id: '19',
    name: 'الذرة',
    image: 'assets/images/corn.jpeg',
    description:
        'محصول صيفي استراتيجي، يستخدم في الغذاء وصناعة الزيوت والأعلاف.',
    plantingTime: 'يزرع من منتصف شهر أبريل وحتى نهاية شهر مايو.',
    irrigation: 'تحتاج إلى ري منتظم خاصة في مرحلة التزهير وتكوين الكيزان.',
    fertilization: 'تحتاج إلى تسميد نيتروجيني (آزوتي) عالي لضمان نمو قوي.',
    diseases: 'الثاقبات (دودة الذرة)، والمن، والتفحم.',
    category: 'محاصيل',
  ),
];
