//
//  SlideViewController.m
//  MarriageCreate
//
//  Created by bizan.com.mac05 on 2014/04/03.
//  Copyright (c) 2014年 teamInnovation. All rights reserved.
//

#import "SlideViewController.h"

@interface SlideViewController ()
{
    //RSSからの情報を格納
    NSDictionary *rssDictionary;
    
    //RSS情報を格納したDictionary内からこの変数へ格納
    NSMutableArray *rssTitle;
    
}
@end

@implementation SlideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self xmlParser];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//xml読み込み
- (void)xmlParser{
    //XMLPaser処理、取り出した各String要素を対応した配列へ代入
    NSString *rssUrl = [NSString stringWithFormat:@"http://ec2-54-249-105-134.ap-northeast-1.compute.amazonaws.com/?feed=rss2&page=2"];
    NSURL *httpDataUrl = [NSURL URLWithString:rssUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:httpDataUrl];
    NSData *xml_data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError *error;
    //RSSの要素は複数あり、要素数分NSMutableArray配列へ格納
    rssTitle = [NSMutableArray array];
    rssDictionary = [XMLReader dictionaryForXMLData:xml_data error:&error];
    rssTitle = [rssDictionary valueForKeyPath:@"rss.channel.item.content:encoded.text"];
//    NSLog(@"%@ ------------------------------------ %@",rssDictionary,rssTitle[3]);
}

@end
