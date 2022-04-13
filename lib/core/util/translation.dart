class TranslationModel {
  late String loginHead;
  late String emailAddress;
  late String password;
  late String emailAddressError;
  late String passwordError;
  late String donNotHaveAccount;
  late String registerNow;

  late String registerHead;

  late String registerUserHead;
  late String registerDoctorHead;
  late String fullName;
  late String nationalId;
  late String government;
  late String mobileNumber;
  late String address;
  late String confirmPassword;

  late String fullNameError;
  late String nationalIdError;
  late String mobileNumberError;
  late String addressError;
  late String confirmPasswordError;

  late String myRequests;
  late String orderNumber;
  late String requestType;
  late String submissionDate;
  late String orderStatus;
  late String departmentName;
  late String responseDate;
  late String attendanceDate;
  late String comments;
  late String print;
  late String noDataFound;
  late String logout;
  late String browse;
  late String noRequests;

  late String home;

  late String logoutConfirmation;
  late String cancel;
  late String yes;

  late String loginError;

  late String areYouDoctor;
  late String specialization;
  late String specializationError;


  late String changeLanguage;
  late String changeTheme;
  late String darkMode;
  late String lightMode;
  late String arabic;
  late String english;

  late String profile;
  late String search;
  late String setting;
  late String aboutUs;
  late String contactUs;
  late String faq;
  late String searchPage;

  late String fakeName;
  late String fakeDoctor;
  late String fakeAddress;
  late String fakeHospital;
  late String fakeHeadPrice;
  late String pound;
  late String fakeReservation;
  late String review;
  late String fakeAdvisor;
  late String experience;
  late String availableToday;
  late String fakeAvailableToday;
  late String fakeReservationDetails;
  late String march;

  late String cart;
  late String categories;

  late String sale;
  late String egp;

  late String removeFromCart;
  late String addToCart;
  late String pleaseLoginToAddOrRemoveCart;
  late String remove;
  late String areYouSureToRemove;
  late String outStock;
  late String inStock;
  late String relatedCategories;
  late String addSomeProductsToCart;

  late String subtotal;
  late String checkout;
  late String total;
  late String thereNoProducts;


  TranslationModel.fromJson(Map<String, dynamic> json) {
    thereNoProducts = json['thereNoProducts'];
    subtotal = json['subtotal'];
    checkout = json['checkout'];
    total = json['total'];

    addSomeProductsToCart = json['addSomeProductsToCart'];
    relatedCategories = json['relatedCategories'];
    removeFromCart = json['removeFromCart'];
    addToCart = json['addToCart'];
    pleaseLoginToAddOrRemoveCart = json['pleaseLoginToAddOrRemoveCart'];
    remove = json['remove'];
    areYouSureToRemove = json['areYouSureToRemove'];
    outStock = json['outStock'];
    inStock = json['inStock'];

    cart = json['sale'];
    egp = json['egp'];

    cart = json['cart'];
    categories = json['categories'];

    fakeName = json['fakeName'];
    fakeDoctor = json['fakeDoctor'];
    fakeAddress = json['fakeAddress'];
    fakeHospital = json['fakeHospital'];
    fakeHeadPrice = json['fakeHeadPrice'];
    pound = json['pound'];
    fakeReservation = json['fakeReservation'];
    review = json['review'];
    fakeAdvisor = json['fakeAdvisor'];
    experience = json['experience'];
    availableToday = json['availableToday'];
    fakeAvailableToday = json['fakeAvailableToday'];
    fakeReservationDetails = json['fakeReservationDetails'];
    march = json['march'];

    profile = json['profile'];
    search = json['categories'];
    setting = json['setting'];
    aboutUs = json['aboutUs'];
    contactUs = json['contactUs'];
    faq = json['faq'];
    searchPage = json['searchPage'];


    changeLanguage = json['changeLanguage'];
    changeTheme = json['changeTheme'];
    darkMode = json['darkMode'];
    lightMode = json['lightMode'];
    arabic = json['arabic'];
    english = json['english'];


    specialization = json['specialization'];
    specializationError = json['specializationError'];

    loginError = json['loginError'];

    logoutConfirmation = json['logoutConfirmation'];
    cancel = json['cancel'];
    yes = json['yes'];

    home = json['home'];

    noRequests = json['noRequests'];
    noDataFound = json['noDataFound'];
    print = json['print'];
    myRequests = json['myRequests'];
    orderNumber = json['orderNumber'];
    requestType = json['requestType'];
    submissionDate = json['submissionDate'];
    orderStatus = json['orderStatus'];
    departmentName = json['departmentName'];
    responseDate = json['responseDate'];
    attendanceDate = json['attendanceDate'];
    comments = json['comments'];


    fullNameError = json['fullNameError'];
    nationalIdError = json['nationalIdError'];
    mobileNumberError = json['mobileNumberError'];
    addressError = json['addressError'];
    confirmPasswordError = json['confirmPasswordError'];

    registerHead = json['registerHead'];
    registerUserHead = json['registerUserHead'];
    registerDoctorHead = json['registerDoctorHead'];
    fullName = json['fullName'];
    nationalId = json['nationalId'];
    government = json['government'];
    mobileNumber = json['mobileNumber'];
    address = json['address'];
    confirmPassword = json['confirmPassword'];

    loginHead = json['loginHead'];
    emailAddress = json['emailAddress'];
    password = json['password'];
    emailAddressError = json['emailAddressError'];
    passwordError = json['passwordError'];
    donNotHaveAccount = json['donNotHaveAccount'];
    registerNow = json['registerNow'];
    logout = json['logout'];
    browse = json['browse'];
    areYouDoctor = json['areYouDoctor'];
  }

  Map toJson() => {
        'thereNoProducts': thereNoProducts,
        'subtotal': subtotal,
        'checkout': checkout,
        'total': total,

        'addSomeProductsToCart': addSomeProductsToCart,
        'relatedCategories': relatedCategories,
        'removeFromCart': removeFromCart,
        'addToCart': addToCart,
        'pleaseLoginToAddOrRemoveCart': pleaseLoginToAddOrRemoveCart,
        'remove': remove,
        'areYouSureToRemove': areYouSureToRemove,
        'outStock': outStock,
        'inStock': inStock,

        'sale': sale,
        'egp': egp,

        'cart': cart,
        'categories': categories,

        'profile': profile,
        'categories': search,
        'setting': setting,
        'aboutUs': aboutUs,
        'contactUs': contactUs,
        'faq': faq,
        'searchPage': searchPage,


        'changeLanguage': changeLanguage,
        'changeTheme': changeTheme,
        'darkMode': darkMode,
        'lightMode': lightMode,
        'arabic': arabic,
        'english': english,

        'specialization': specialization,
        'specializationError': specializationError,

        'loginError': loginError,

        'logoutConfirmation': logoutConfirmation,
        'cancel': cancel,
        'yes': yes,

        'home': home,

        'fullNameError': fullNameError,
        'nationalIdError': nationalIdError,
        'mobileNumberError': mobileNumberError,
        'addressError': addressError,
        'confirmPasswordError': confirmPasswordError,

        'registerHead': registerHead,
        'registerUserHead': registerUserHead,
        'registerDoctorHead': registerDoctorHead,
        'fullName': fullName,
        'nationalId': nationalId,
        'government': government,
        'mobileNumber': mobileNumber,
        'address': address,
        'confirmPassword': confirmPassword,

        'loginHead': loginHead,
        'emailAddress': emailAddress,
        'password': password,
        'emailAddressError': emailAddressError,
        'passwordError': passwordError,
        'donNotHaveAccount': donNotHaveAccount,
        'registerNow': registerNow,
        'logout': logout,
        'browse': browse,
        'areYouDoctor': areYouDoctor,
      };
}
