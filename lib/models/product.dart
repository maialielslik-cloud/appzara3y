class Product {
  final String id;
  final String name;
  final String image;
  final String description;
  final double price;
  final double rating;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.rating,
    required this.category,
  });
}

final List<Product> dummyProducts = [
  Product(
    id: '1',
    name: 'بذور طماطم هجين',
    image: 'https://loremflickr.com/400/400/tomato',
    description: 'بذور طماطم عالية الجودة، مقاومة للأمراض الفيروسية والذبول.',
    price: 150.0,
    rating: 4.8,
    category: 'بذور',
  ),

  Product(
    id: '2',
    name: 'سماد يوريا 46%',
    image: 'https://loremflickr.com/400/400/fertilizer',
    description: 'سماد نيتروجيني عالي التركيز يساعد على النمو الخضري السريع.',
    price: 450.0,
    rating: 4.5,
    category: 'أسمدة',
  ),

  Product(
    id: '3',
    name: 'مبيد فطري تيلت',
    image: 'https://loremflickr.com/400/400/pesticide',
    description: 'مبيد فطري جهازي واسع المدى لمكافحة أمراض الأصداء والبياض.',
    price: 280.0,
    rating: 4.7,
    category: 'مبيدات',
  ),

  Product(
    id: '4',
    name: 'رشاش مياه يدوي',
    image: 'https://loremflickr.com/400/400/sprinkler',
    description: 'رشاش مياه يدوي سعة 2 لتر، مصنع من مواد متينة سهلة الاستخدام.',
    price: 2000,
    rating: 4.2,
    category: 'أدوات ري',
  ),

  Product(
    id: '5',
    name: 'فاكهة العنب',
    image: 'https://loremflickr.com/400/400/grapes',
    description: 'عنب طازج عالي الجودة يتميز بمذاق حلو وفوائد صحية متعددة.',
    price: 85.0,
    rating: 4.3,
    category: 'فاكهه',
  ),

  Product(
    id: '6',
    name: 'قمح',
    image: 'https://loremflickr.com/400/400/wheat',
    description: 'بذور القمح.',
    price: 150.0,
    rating: 4.8,
    category: 'محصول',
  ),

  Product(
    id: '7',
    name: 'بطاطس',
    image: 'https://loremflickr.com/400/400/potato',
    description:
        'بطاطس منتقاة بعناية للزراعة (تقاوي) تتميز بنسبة إنبات عالية ومقاومة للأمراض الفطرية.',
    price: 200.0,
    rating: 4.8,
    category: 'محصول',
  ),

  Product(
    id: '8',
    name: 'قصب السكر',
    image: 'https://loremflickr.com/400/400/sugarcane',
    description:
        'عقل قصب سكر منتقاة بعناية للزراعة تتميز بنسبة سكر عالية ومقاومة الامراض تضمن انتاجية وفيرة وجودة ممتازة للمحصول',
    price: 400.0,
    rating: 4.7,
    category: 'بذور',
  ),

  Product(
    id: '9',
    name: 'فول',
    image: 'https://loremflickr.com/400/400/beans',
    description:
        'بذور فول بلدي منتقاة بعناية للزراعة تتميز بنسبة انبات عالية ومقاومة للامراض الورقيه ومنسابة لجميع انواع التربة',
    price: 40.0,
    rating: 4.8,
    category: 'محاصيل',
  ),

  Product(
    id: '10',
    name: 'ذرة',
    image: 'https://loremflickr.com/400/400/corn',
    description:
        'بذور ذرة هجين عاليه الانتاجية تتميز بمقاومة الامراض وسرعة النمو مناسبة للزراعة في مختلف انواع التربة',
    price: 50.0,
    rating: 4.7,
    category: 'محاصيل',
  ),

  Product(
    id: '11',
    name: 'خيار',
    image: 'https://loremflickr.com/400/400/cucumber',
    description:
        'بذور خيار هجين عاليةالجودة، تتميز بسرعة الانبات ومقاومة للامراض الفيروسية، منسابة للزراعة في الصعوبات او الارض المكشوفة',
    price: 30.0,
    rating: 4.6,
    category: 'خضروات',
  ),

  Product(
    id: '12',
    name: 'بصل',
    image: 'https://loremflickr.com/400/400/onion',
    description:
        'بصل طازج عالي الجودة، يتميز بقشرة جافة وحبات متمساكة وطعم قوي، غني بمضادات الاكسدة والفوائد الصحية، مثالي لجميع انواع الضهي',
    price: 60.0,
    rating: 4.8,
    category: 'خضروات',
  ),

  Product(
    id: '13',
    name: 'ثوم بلدي',
    image: 'https://loremflickr.com/400/400/garlic',
    description: 'ثوم بلدي طازج بجودة عالية ونكهة قوية.',
    price: 40.0,
    rating: 4.8,
    category: 'خضروات',
  ),

  Product(
    id: '14',
    name: 'فلفل رومي اخضر',
    image: 'https://loremflickr.com/400/400/greenpepper',
    description: 'فلفل أخضر طازج غني بالفيتامينات.',
    price: 18.0,
    rating: 4.7,
    category: 'خضراوت',
  ),

  Product(
    id: '15',
    name: 'باذنجان بلدي',
    image: 'https://loremflickr.com/400/400/eggplant',
    description: 'باذنجان طازج بقوام متماسك وطعم مميز.',
    price: 15.0,
    rating: 4.8,
    category: 'خضراوت',
  ),

  Product(
    id: '16',
    name: 'تفاح',
    image: 'https://loremflickr.com/400/400/apple',
    description: 'تفاح طازج حلو المذاق غني بالفيتامينات.',
    price: 70.0,
    rating: 4.9,
    category: 'فواكة',
  ),

  Product(
    id: '17',
    name: 'برتقال ابو صرة',
    image: 'https://loremflickr.com/400/400/orange',
    description: 'برتقال طازج غني بفيتامين C.',
    price: 15.0,
    rating: 4.8,
    category: 'فواكه',
  ),

  Product(
    id: '18',
    name: 'يوسفي',
    image: 'https://loremflickr.com/400/400/mandarin',
    description: 'يوسفي طازج بمذاق رائع ورائحة مميزة.',
    price: 12.0,
    rating: 4.7,
    category: 'فواكه',
  ),

  Product(
    id: '19',
    name: 'جوافة بلدي',
    image: 'https://loremflickr.com/400/400/guava',
    description: 'جوافة طازجة غنية بالفيتامينات ومضادات الأكسدة.',
    price: 20.0,
    rating: 4.8,
    category: 'فواكه',
  ),

  Product(
    id: '20',
    name: 'مانجو',
    image: 'https://loremflickr.com/400/400/mango',
    description: 'مانجو طازجة عالية الجودة، تتميز بمذاق حلو.',
    price: 60.0,
    rating: 4.9,
    category: 'فواكه',
  ),

  Product(
    id: '21',
    name: 'رمان',
    image: 'https://loremflickr.com/400/400/pomegranate',
    description: 'رمان طازج غني بمضادات الأكسدة.',
    price: 35.0,
    rating: 4.8,
    category: 'فواكه',
  ),

  Product(
    id: '22',
    name: 'كوسة',
    image: 'https://loremflickr.com/400/400/zucchini',
    description: 'كوسة طازجة خضراء عالية الجودة.',
    price: 12.0,
    rating: 4.6,
    category: 'خضروات',
  ),

  Product(
    id: '23',
    name: 'جزر',
    image: 'https://loremflickr.com/400/400/carrot',
    description: 'جزر طازج غني بالفيتامينات.',
    price: 10.0,
    rating: 4.7,
    category: 'خضروات',
  ),

  Product(
    id: '24',
    name: 'فراولة',
    image: 'https://loremflickr.com/400/400/strawberry',
    description: 'فراولة طازجة بمذاق حلو.',
    price: 25.0,
    rating: 4.9,
    category: 'فواكه',
  ),
  Product(
    id: '25',
    name: 'عدس',
    image: 'https://loremflickr.com/400/400/lentils',
    description: '.بذور عدس محلي مختار بعناية لانتاج جيد ومقامة للامراض',
    price: 90.0,
    rating: 4.9,
    category: 'محاصيل',
  ),
  Product(
    id: '26',
    name: 'فراولة',
    image: 'https://loremflickr.com/400/400/strawberry',
    description: 'فراولة طازجة بمذاق حلو.',
    price: 25.0,
    rating: 4.9,
    category: 'فواكه',
  ),
  Product(
    id: '27',
    name: 'فاصوليا خضراء',
    image: 'https://loremflickr.com/400/400/greenbeans',
    description: 'بذور فاصوليا خضراء منتقاة لانتاج محاصيل عالية الجودة.',
    price: 70.0,
    rating: 4.6,
    category: 'محاصيل',
  ),
  Product(
    id: '28',
    name: 'بطيخ',
    image: 'https://loremflickr.com/400/400/watermelon',
    description: 'بذور بطيخ عالية الانتاجية وطعم حلو ومميز.',
    price: 35.0,
    rating: 4.7,
    category: 'محاصيل',
  ),
  Product(
    id: '29',
    name: 'شمام',
    image: 'https://loremflickr.com/400/400/cantaloupe',
    description: 'بذور شمام طازجة للانتاج محاصيل وفيرة وجودة عالية.',
    price: 40.0,
    rating: 4.9,
    category: 'محاصيل',
  ),
  Product(
    id: '30',
    name: 'خوخ',
    image: 'https://loremflickr.com/400/400/peach',
    description: ' خوخ طازج بطعم لذيذ وقوام ناعم',
    price: 35.0,
    rating: 4.9,
    category: 'فواكه',
  ),
  Product(
    id: '31',
    name: 'كمثري',
    image: 'https://loremflickr.com/400/400/pear',
    description: '.كمثري طازج غنية بالالياف ومفيدة للهضم',
    price: 40.0,
    rating: 4.8,
    category: 'فواكه',
  ),
  Product(
    id: '32',
    name: 'تين',
    image: 'https://loremflickr.com/400/400/fig',
    description: 'تين طازج غني بالفيتاميات والمعادن.',
    price: 25.0,
    rating: 4.9,
    category: 'فواكه',
  ),
];
