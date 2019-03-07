//
//  Currency_ViewController.m
//  GoalManager
//
//  Created by apple on 12/11/14.
//  Copyright (c) 2014 whitelotuscorporation. All rights reserved.
//

#import "Currency_ViewController.h"
#import "NSString+FontAwesome.h"
#import "Cell_Currency.h"
#import "GoalManagerAppDelegate.h"

@interface Currency_ViewController ()

@end

@implementation Currency_ViewController
@synthesize btn_Back;
@synthesize lbl_Back;
@synthesize muary_CheckBox,muary_CurrencyList;
@synthesize tbl_CurrencyList;
@synthesize str_FromWhere,str_SelectedCurrency;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    lbl_Back = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
//    lbl_Back.font = [UIFont fontWithName:kFontAwesomeFamilyName size:20];
//    lbl_Back.text = [NSString fontAwesomeIconStringForIconIdentifier:@"fa-chevron-right"];
//    lbl_Back.textColor = [UIColor whiteColor];
//    [lbl_Back setUserInteractionEnabled:YES];
//    UIGestureRecognizer *tapGestureBack = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action_Back:)];
//    [lbl_Back addGestureRecognizer: tapGestureBack];
//    [lbl_Back setHidden:YES];
    
    UIImage* image2 = [UIImage imageNamed:@"navbar_back.png"];
    CGRect frameimg2 = CGRectMake(0, 0,22,22);
    UIButton *someButton2 = [[UIButton alloc] initWithFrame:frameimg2];
    [someButton2 setBackgroundImage:image2 forState:UIControlStateNormal];
    [someButton2 addTarget:self action:@selector(action_Back:)
          forControlEvents:UIControlEventTouchUpInside];
    [someButton2 setSelected:YES];
    
    UIBarButtonItem *btn_Back= [[UIBarButtonItem alloc]initWithCustomView:someButton2];
    
    NSArray *arr_GoalOverviewLeft= [[NSArray alloc] initWithObjects:btn_Back,nil];
    self.navigationItem.leftBarButtonItems = arr_GoalOverviewLeft;
    
    
//    btn_Back= [[UIBarButtonItem alloc]initWithCustomView:lbl_Back];
//    self.navigationItem.leftBarButtonItem = btn_Back;

    
    
    self.muary_CurrencyList =[NSMutableArray arrayWithObjects:
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Afghanistan (Arabic)",@"countrycurrency",@"؋",@"currencysymbol",
                               @"AFN",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Aghem (Cameroon)",@"countrycurrency",
                               @"FCFA",@"currencysymbol",
                               @"XAF",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Akan (Ghana)",@"countrycurrency",
                               @"GH₵",@"currencysymbol",
                               @"GHS",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Albania",@"countrycurrency",
                               @"ALL",@"currencysymbol",
                               @"ALL",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"American Samoa",@"countrycurrency",
                               @"$",@"currencysymbol",
                               @"USD",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Andorra",@"countrycurrency",
                               @"€",@"currencysymbol",
                               @"EUR",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Angola",@"countrycurrency",
                               @"Kz",@"currencysymbol",
                               @"AOA",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Antigua and Barbuda",@"countrycurrency",
                               @"EC$",@"currencysymbol",
                               @"XCD",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Algeria",@"countrycurrency",
                               @"د.ج.‏",@"currencysymbol",
                               @"DZD",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Argentina",@"countrycurrency",
                               @"$",@"currencysymbol",
                               @"ARS",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Armenian (Armenia)",@"countrycurrency",
                               @"դր.",@"currencysymbol",
                               @"AMD",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Aruba",@"countrycurrency",
                               @"Afl.",@"currencysymbol",
                               @"AWG",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Assamese (India)",@"countrycurrency",
                               @"₹",@"currencysymbol",
                               @"INR",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Asu (Tanzania)",@"countrycurrency",
                               @"TSh",@"currencysymbol",
                               @"TZS",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Australia",@"countrycurrency",
                               @"$",@"currencysymbol",
                               @"AUD",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Azerbaijan",@"countrycurrency",
                               @"man.",@"currencysymbol",
                               @"AZN",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Bahamas",@"countrycurrency",
                               @"$",@"currencysymbol",
                               @"BSD",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Bahrain",@"countrycurrency",
                               @"د.ب.‏",@"currencysymbol",
                               @"BHD",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Bambara (Mali)",@"countrycurrency",
                               @"CFA",@"currencysymbol",
                               @"XOF",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Bangladesh",@"countrycurrency",
                               @"৳",@"currencysymbol",
                               @"BDT",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Barbados",@"countrycurrency",
                               @"$",@"currencysymbol",
                               @"BBD",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Belarus",@"countrycurrency",
                               @"р.",@"currencysymbol",
                               @"BYR",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Belize",@"countrycurrency",
                               @"$",@"currencysymbol",
                               @"BZD",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Bemba (Zambia)",@"countrycurrency",
                               @"KR",@"currencysymbol",
                               @"ZMW",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Barmuda",@"countrycurrency",
                               @"$",@"currencysymbol",
                               @"BMD",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Bolivia",@"countrycurrency",
                               @"Bs",@"currencysymbol",
                               @"BOB",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Bosnia and Herzegovina",@"countrycurrency",
                               @"KM",@"currencysymbol",
                               @"BAM",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Botswana",@"countrycurrency",
                               @"P",@"currencysymbol",
                               @"BWP",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Brazil",@"countrycurrency",
                               @"R$",@"currencysymbol",
                               @"BRL",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Brunei",@"countrycurrency",
                               @"$",@"currencysymbol",
                               @"BND",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Bulgarian (Bulgaria)",@"countrycurrency",
                               @"лв.",@"currencysymbol",
                               @"BGN",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Burundi",@"countrycurrency",
                               @"FBu",@"currencysymbol",
                               @"BIF",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Canada",@"countrycurrency",
                               @"$",@"currencysymbol",
                               @"CAD",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Cape Verde",@"countrycurrency",
                               @"CVE",@"currencysymbol",
                               @"CVE",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Cayman Islands",@"countrycurrency",
                               @"$",@"currencysymbol",
                               @"KYD",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Central Atlas Tamazight (Morocco)",@"countrycurrency",
                               @"MAD",@"currencysymbol",
                               @"MAD",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Chiga (Uganda)",@"countrycurrency",
                               @"USh",@"currencysymbol",
                               @"UGX",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Chile",@"countrycurrency",
                               @"$",@"currencysymbol",
                               @"CLP",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"China",@"countrycurrency",
                               @"￥",@"currencysymbol",
                               @"CNY",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Colombia",@"countrycurrency",
                               @"$",@"currencysymbol",
                               @"COP",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Comoros",@"countrycurrency",
                               @"ف.ج.ق.‏",@"currencysymbol",
                               @"KMF",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Congo - Kinshasa",@"countrycurrency",
                               @"FC",@"currencysymbol",
                               @"CDF",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Cornish (United Kingdom)",@"countrycurrency",
                               @"£",@"currencysymbol",
                               @"GBP",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Costa Rica",@"countrycurrency",
                               @"₡",@"currencysymbol",
                               @"CRC",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Croatia",@"countrycurrency",
                               @"kn",@"currencysymbol",
                               @"HRK",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Curacao",@"countrycurrency",
                               @"NAf.",@"currencysymbol",
                               @"ANG",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Czech (Czech Republic)",@"countrycurrency",
                               @"Kč",@"currencysymbol",
                               @"CZK",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Danish (Denmark)",@"countrycurrency",
                               @"kr",@"currencysymbol",
                               @"DKK",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Djibouti",@"countrycurrency",
                               @"Fdj",@"currencysymbol",
                               @"DJF",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Dominican Republic",@"countrycurrency",
                               @"$",@"currencysymbol",
                               @"DOP",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Dzongkha (Bhutan)",@"countrycurrency",
                               @"Nu.",@"currencysymbol",
                               @"BTN",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Egypt",@"countrycurrency",
                               @"ج.م.‏",@"currencysymbol",
                               @"EGP",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Embu (Kenya)",@"countrycurrency",
                               @"Ksh",@"currencysymbol",
                               @"KES",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Eritrea",@"countrycurrency",
                               @"Nfk",@"currencysymbol",
                               @"ERN",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Ethiopia",@"countrycurrency",
                               @"Br",@"currencysymbol",
                               @"ETB",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Fiji",@"countrycurrency",
                               @"$",@"currencysymbol",
                               @"FJD",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Filipino (Philippines)",@"countrycurrency",
                               @"₱",@"currencysymbol",
                               @"PHP",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"French Polinesia",@"countrycurrency",
                               @"FCFP",@"currencysymbol",
                               @"XPF",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Gambia",@"countrycurrency",
                               @"D",@"currencysymbol",
                               @"GMD",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Georgian (Georgia)",@"countrycurrency",
                               @"GEL",@"currencysymbol",
                               @"GEL",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Gibraltar",@"countrycurrency",
                               @"£",@"currencysymbol",
                               @"GIP",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Guatemala",@"countrycurrency",
                               @"Q",@"currencysymbol",
                               @"GTQ",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Guinea",@"countrycurrency",
                               @"FG",@"currencysymbol",
                               @"GNF",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Guyana",@"countrycurrency",
                               @"$",@"currencysymbol",
                               @"GYD",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Haiti",@"countrycurrency",
                               @"G",@"currencysymbol",
                               @"HTG",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Hebrew (Isreal)",@"countrycurrency",
                               @"₪",@"currencysymbol",
                               @"ILS",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Hong Kong SAR China",@"countrycurrency",
                               @"$",@"currencysymbol",
                               @"HKD",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Honduras",@"countrycurrency",
                               @"L",@"currencysymbol",
                               @"HNL",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Hungarian (Hungary)",@"countrycurrency",
                               @"Ft",@"currencysymbol",
                               @"HUF",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Iceland",@"countrycurrency",
                               @"ISK",@"currencysymbol",
                               @"ISK",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Igbo (Nigeria)",@"countrycurrency",
                               @"₦",@"currencysymbol",
                               @"NGN",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Indonesian (Indonesia)",@"countrycurrency",
                               @"Rp",@"currencysymbol",
                               @"IDR",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Iraq",@"countrycurrency",
                               @"د.ع.‏",@"currencysymbol",
                               @"IQD",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Jamaica",@"countrycurrency",
                               @"$",@"currencysymbol",
                               @"JMD",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Japanese (Japan)",@"countrycurrency",
                               @"￥",@"currencysymbol",
                               @"JPY",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Jordan",@"countrycurrency",
                               
                               @"د.أ.‏",@"currencysymbol",
                               @"JOD",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Kyrgyzstan",@"countrycurrency",
                               @"сом",@"currencysymbol",
                               @"KGS",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Kazakh (Kazakhstan)",@"countrycurrency",
                               @"₸",@"currencysymbol",
                               @"KZT",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Kinyarwanda (Rwanda)",@"countrycurrency",
                               @"RF",@"currencysymbol",
                               @"RWF",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Korean (South Korea)",@"countrycurrency",
                               @"₩",@"currencysymbol",
                               @"KRW",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Kuwait",@"countrycurrency",
                               @"د.ك.‏",@"currencysymbol",
                               @"KWD",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Lao (Laos)",@"countrycurrency",
                               @"₭",@"currencysymbol",
                               @"LAK",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Latvia",@"countrycurrency",
                               @"LVL",@"currencysymbol",
                               @"LVL",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Lebanon",@"countrycurrency",
                               @"ل.ل.‏",@"currencysymbol",
                               @"LBP",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Lesotho",@"countrycurrency",
                               @"R",@"currencysymbol",
                               @"ZAR",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Liberia",@"countrycurrency",
                               @"$",@"currencysymbol",
                               @"LRD",@"currencycode",
                               nil],
                              
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Liechtenstein",@"countrycurrency",
                               @"CHF",@"currencysymbol",
                               @"CHF",@"currencycode",
                               
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Lithuania",@"countrycurrency",
                               @"LTL",@"currencysymbol",
                               @"LTL",@"currencycode",
                               nil],
                              
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Libya",@"countrycurrency",
                               @"د.ل.‏",@"currencysymbol",
                               @"LYD",@"currencycode",
                               nil],
                              
                              
                              
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Macau SAR China",@"countrycurrency",
                               @"MOP$",@"currencysymbol",
                               @"MOP",@"currencycode",
                               nil],
                              
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Macedonia",@"countrycurrency",
                               @"ден",@"currencysymbol",
                               @"MKD",@"currencycode",
                               nil],
                              
                              
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Madagascar",@"countrycurrency",
                               @"Ar",@"currencysymbol",
                               @"MGA",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Makhuwa-Meetto (Mozambique)",@"countrycurrency",
                               @"MTn",@"currencysymbol",
                               @"MZN",@"currencycode",
                               nil],
                              
                              
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Malaysiya",@"countrycurrency",
                               @"RM",@"currencysymbol",
                               @"MYR",@"currencycode",
                               nil],
                              
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Malawi",@"countrycurrency",
                               @"MK",@"currencysymbol",
                               @"MWK",@"currencycode",
                               nil],
                             
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Moldova",@"countrycurrency",
                               @"MDL",@"currencysymbol",
                               @"MDL",@"currencycode",
                               
                               nil],
                              
                              
                              
                              
                              
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Mauritius",@"countrycurrency",
                               @"Rs",@"currencysymbol",
                               @"MUR",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Mauritania",@"countrycurrency",
                               @"أ.م.‏",@"currencysymbol",
                               @"MRO",@"currencycode",
                               nil],
                              
                              
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Mexico",@"countrycurrency",
                               @"$",@"currencysymbol",
                               @"MXN",@"currencycode",
                               nil],
                             
                              
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Mongolian (Mongolia)",@"countrycurrency",
                               @"₮",@"currencysymbol",
                               @"MNT",@"currencycode",
                               nil],
                              
                              
                             
                              
                              
                                                           [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Nama (Namibia)",@"countrycurrency",
                               @"$",@"currencysymbol",
                               @"NAD",@"currencycode",
                               nil],
                              
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Nepal",@"countrycurrency",
                               @"नेरू",@"currencysymbol",
                               @"NPR",@"currencycode",
                               nil],
                              
                              
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"New Zealand",@"countrycurrency",
                               @"$",@"currencysymbol",
                               @"NZD",@"currencycode",
                               nil],
                              
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Nicaragua",@"countrycurrency",
                               @"C$",@"currencysymbol",
                               @"NIO",@"currencycode",
                               nil],
                              
                              
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Norway",@"countrycurrency",
                               @"NOK",@"currencysymbol",
                               @"NOK",@"currencycode",
                               
                               nil],
                              
                              
                              
                              
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Oman",@"countrycurrency",
                               @"ر.ع.‏",@"currencysymbol",
                               @"OMR",@"currencycode",
                               nil],
                              
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Pakistan",@"countrycurrency",
                               @"Rs",@"currencysymbol",
                               @"PKR",@"currencycode",
                               nil],
                              
                              
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Pananma",@"countrycurrency",
                               @"B/.",@"currencysymbol",
                               @"PAB",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Papua New Guinea",@"countrycurrency",
                               @"K",@"currencysymbol",
                               @"PGK",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Paraguay",@"countrycurrency",
                               @"₲",@"currencysymbol",
                               @"PYG",@"currencycode",
                               nil],
                                                            [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Peru",@"countrycurrency",
                               @"S/.",@"currencysymbol",
                               @"PEN",@"currencycode",
                               nil],
                              
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Poland",@"countrycurrency",
                               @"PLN",@"currencysymbol",
                               @"PLN",@"currencycode",
                               nil],
                              
                              
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Qatar",@"countrycurrency",
                               @"ر.ق.‏",@"currencysymbol",
                               @"QAR",@"currencycode",
                               nil],
                              
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Romania",@"countrycurrency",
                               @"RON",@"currencysymbol",
                               @"RON",@"currencycode",
                               nil],
                              
                              
                              
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Russia",@"countrycurrency",
                               @"руб.",@"currencysymbol",
                               @"RUB",@"currencycode",
                               nil],
                              
                              
                              
                              
                              
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Samoa",@"countrycurrency",
                               @"WS$",@"currencysymbol",
                               @"WST",@"currencycode",
                               nil],
                              
                              
                              
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Sao Tome and Principe",@"countrycurrency",
                               @"Db",@"currencysymbol",
                               @"STD",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Saudi Arabia",@"countrycurrency",
                               @"ر.س.‏",@"currencysymbol",
                               @"SAR",@"currencycode",
                               nil],
                              
                              
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Serbia",@"countrycurrency",
                               @"дин.",@"currencysymbol",
                               @"RSD",@"currencycode",
                               nil],
                              
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Seychelles",@"countrycurrency",
                               @"SR",@"currencysymbol",
                               @"SCR",@"currencycode",
                               nil],
                              
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Somalia",@"countrycurrency",
                               @"S",@"currencysymbol",
                               @"SOS",@"currencycode",
                               nil],
                            
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Sierra Leone",@"countrycurrency",
                               @"Le",@"currencysymbol",
                               @"SLL",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Singapore",@"countrycurrency",
                               @"$",@"currencysymbol",
                               @"SGD",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Sinhala (Sri Lanka)",@"countrycurrency",
                               @"රු.",@"currencysymbol",
                               @"LKR",@"currencycode",
                               nil],
    
    
                                                            [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Soloman Islands",@"countrycurrency",
                               @"$",@"currencysymbol",
                               @"SBD",@"currencycode",
                               nil],
    
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"South Sudan",@"countrycurrency",
                               @"£",@"currencysymbol",
                               @"SSP",@"currencycode",
                               nil],
    
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Suriname",@"countrycurrency",
                               @"$",@"currencysymbol",
                               @"SRD",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Swaziland",@"countrycurrency",
                               @"E",@"currencysymbol",
                               @"SZL",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Sweden",@"countrycurrency",
                               @"SEK",@"currencysymbol",
                               @"SEK",@"currencycode",
                               nil],
    
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Taiwan",@"countrycurrency",
                               @"NT$",@"currencysymbol",
                               @"TWD",@"currencycode",
                               nil],
    
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Tajik (Tazikistan)",@"countrycurrency",
                               @"сом",@"currencysymbol",
                               @"TJS",@"currencycode",
                               nil],
    
    
    
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Thai (Thailand)",@"countrycurrency",
                               @"฿",@"currencysymbol",
                               @"THB",@"currencycode",
                               nil],
    
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Tonga",@"countrycurrency",
                               @"T$",@"currencysymbol",
                               @"TOP",@"currencycode",
                               nil],
    
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Trinidad and Tobago",@"countrycurrency",
                               @"$",@"currencysymbol",
                               @"TTD",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Tunisia",@"countrycurrency",
                               @"د.ت.",@"currencysymbol",
                               @"TND",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Turkey",@"countrycurrency",
                               @"TRY",@"currencysymbol",
                               @"TRY",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Turkmen (Turkmenistan)",@"countrycurrency",
                               @"m.",@"currencysymbol",
                               @"TMT",@"currencycode",
                               nil],
    
                            [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Ukraine",@"countrycurrency",
                               @"₴",@"currencysymbol",
                               @"UAH",@"currencycode",
                               nil],
                                                            [NSDictionary dictionaryWithObjectsAndKeys:
                               @"United Arab Emirates",@"countrycurrency",
                               @"د.إ.‏",@"currencysymbol",
                               @"AED",@"currencycode",
                               nil],
    
    
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Uruguay",@"countrycurrency",
                               @"$",@"currencysymbol",
                               @"UYU",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Uzbekistan",@"countrycurrency",
                               @"сўм",@"currencysymbol",
                               @"UZS",@"currencycode",
                               nil],
    
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Vanuatu",@"countrycurrency",
                               @"VT",@"currencysymbol",
                               @"VUV",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Venezuela",@"countrycurrency",
                               @"Bs.",@"currencysymbol",
                               @"VEF",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Vietnamese (vietnam)",@"countrycurrency",
                               @"₫",@"currencysymbol",
                               @"VND",@"currencycode",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"Yemen",@"countrycurrency",@"ر.ي.‏",@"currencysymbol", @"YER",@"currencycode", nil],
    
                                                            nil];
    NSLog(@"%lu",(unsigned long)self.muary_CurrencyList.count);
    NSSortDescriptor *sort =  [[NSSortDescriptor alloc] initWithKey:@"currencycode" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    self.muary_CurrencyList=[[NSMutableArray alloc] initWithArray:[muary_CurrencyList sortedArrayUsingDescriptors:@[sort]]];

    //////////////////////// UISwipeGestureRecognizer ////////////////////////
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    // Setting the swipe direction.
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    [self.view addGestureRecognizer:swipeRight];
    
//    for (int i = 0; i<muary_CurrencyList.count; i++)
//    {
//        NSString *str_URL = [NSString stringWithFormat:@"http://rate-exchange.herokuapp.com/fetchRate?from=INR&to=%@", [NSString stringWithFormat:@"%@",[[muary_CurrencyList objectAtIndex:i]valueForKey:@"currencycode"]]];
//        
//        NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString:str_URL]];
//        
//        NSError* error;
//        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//        
//        NSLog(@"JSON OBJECT %d : %@",i, json);
//    }
    
    
}

#pragma mark UISwipeGestureRecognizer METHOD

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe
{
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight)
    {
        //NSLog(@"Right Swipe");
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = false;
    [super viewWillAppear:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - All User Defined Functions

-(IBAction)action_Back:(id)sender
{
    if (![[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InAppPurchase"] isEqualToString:@"1"])
    {
        if ([[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"AdView"] == nil)
        {
            [[GoalManagerAppDelegate getdefaultvalue]setObject:@"1" forKey:@"AdView"];
        }
        else if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"AdView"] isEqualToString:@"1"])
        {
            [[GoalManagerAppDelegate getdefaultvalue]setObject:@"2" forKey:@"AdView"];
        }
        else if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"AdView"] isEqualToString:@"2"])
        {
            [[GoalManagerAppDelegate getdefaultvalue]setObject:@"3" forKey:@"AdView"];
        }
        else
        {
            [[GoalManagerAppDelegate getdefaultvalue]setObject:@"1" forKey:@"AdView"];
        }
        
        if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"AdView"]isEqualToString:@"3"])
        {
            [self createAndLoadInterstitial];
        }
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createAndLoadInterstitial
{
    _interstitial =
    [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-5298130731078005/2952392171"];
    _interstitial.delegate=self;
    
    GADRequest *request = [GADRequest request];
    //request.testDevices = @[ @"e33953a7d4e4e4fbac2a3e08d60e4f9db7abcdfa"];
    [_interstitial loadRequest:request];
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad
{
    [_interstitial presentFromRootViewController:self];
    [[UIApplication sharedApplication]setStatusBarHidden:FALSE];
}

#pragma mark All Delegate Methods

#pragma mark - Table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return muary_CurrencyList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell_Currency";
    
    Cell_Currency *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    cell.lbl_CureencySymbol.text = [[muary_CurrencyList objectAtIndex:indexPath.row]valueForKey:@"currencysymbol"];
    
    cell.lbl_CurrencyCode.text = [[muary_CurrencyList objectAtIndex:indexPath.row]valueForKey:@"currencycode"];
    
    
//    if ([[muary_CheckBox objectAtIndex:indexPath.row] isEqualToString:@"1"])
//    {
//        //[cell.imgView_Select setImage:[UIImage imageNamed:@"img_CheckMark.png"]];
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    }
//    else
//    {
//        // [cell.imgView_Select setImage:nil];
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
    
    //cell.btn_SelectCurrency.tag = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [Localytics tagEvent:@"Select Currency"];
    [Flurry logEvent:@"Select Currency"];
    [FIRAnalytics logEventWithName:@"Select_Currency"
                        parameters:nil];
    
    NSString *str_CurrencySymbol = [NSString stringWithFormat:@"%@",[[muary_CurrencyList objectAtIndex:indexPath.row]valueForKey:@"currencysymbol"]];
    NSString *str_CurrencyCode = [NSString stringWithFormat:@"%@",[[muary_CurrencyList objectAtIndex:indexPath.row]valueForKey:@"currencycode"]];
    
    if ([str_FromWhere isEqualToString:@"FromSetting"])
    {
        [[GoalManagerAppDelegate getdefaultvalue]setObject:str_CurrencySymbol forKey:@"MasterCurrencySymbol"];
        [[GoalManagerAppDelegate getdefaultvalue]setObject:str_CurrencyCode forKey:@"MasterCurrencyCode"];
    }
    else
    {
        [[GoalManagerAppDelegate getdefaultvalue]setObject:str_CurrencySymbol forKey:@"Currency"];
        [[GoalManagerAppDelegate getdefaultvalue]setObject:str_CurrencyCode forKey:@"CurrencyCode"];
        [[GoalManagerAppDelegate getdefaultvalue]setObject:@"1" forKey:@"CurrencySelected"];
    }
    
    
    
    
//    if ([[muary_CheckBox objectAtIndex:indexPath.row] isEqualToString:@"1"])
//    {
//        //[cell.imgView_Select setImage:nil];
//        [muary_CheckBox replaceObjectAtIndex:indexPath.row withObject:@"0"];
//        
//        if ([str_FromWhere isEqualToString:@"Setting"])
//        {
//            
//        }
//        else
//        {
//            [[Money_PROAppDelegate getdefaultvalue]setObject:@"" forKey:@"Currency"];
//            [[Money_PROAppDelegate getdefaultvalue]setObject:@"" forKey:@"CurrencyCode"];
//        }
//    }
//    else
//    {
//        //[cell.imgView_Select setImage:[UIImage imageNamed:@"img_CheckMark.png"]];
//        
//        NSString *str_CurrencySymbol = [NSString stringWithFormat:@"%@",[[muary_CurrencyList objectAtIndex:indexPath.row]valueForKey:@"currencysymbol"]];
//        
//        NSString *str_Country = [NSString stringWithFormat:@"%@",[[muary_CurrencyList objectAtIndex:indexPath.row]valueForKey:@"countrycurrency"]];
//        
//        NSString *str_CurrencyCode = [NSString stringWithFormat:@"%@",[[muary_CurrencyList objectAtIndex:indexPath.row]valueForKey:@"currencycode"]];
//        
//        if ([str_FromWhere isEqualToString:@"Setting"])
//        {
//            [[Money_PROAppDelegate getdefaultvalue]setObject:str_CurrencySymbol forKey:@"DefaultCurrency"];
//            [[Money_PROAppDelegate getdefaultvalue]setObject:str_Country forKey:@"DefaultCountry"];
//            [[Money_PROAppDelegate getdefaultvalue]setObject:str_CurrencyCode forKey:@"DefaultCurrencyCode"];
//        }
//        else
//        {
//            [[Money_PROAppDelegate getdefaultvalue]setObject:str_CurrencySymbol forKey:@"Currency"];
//            //[[Money_PROAppDelegate getdefaultvalue]setObject:str_Country forKey:@"Country"];
//            [[Money_PROAppDelegate getdefaultvalue]setObject:str_CurrencyCode forKey:@"CurrencyCode"];
//            
//        }
//        muary_CheckBox = [[NSMutableArray alloc]init];
//        
//        for (int i = 0; i<self.muary_CurrencyList.count; i++)
//        {
//            [self.muary_CheckBox insertObject:@"0" atIndex:i];
//        }
//        
//        [muary_CheckBox replaceObjectAtIndex:indexPath.row withObject:@"1"];
//        
//    }
//    [tbl_CurrencyList reloadData];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

@end
