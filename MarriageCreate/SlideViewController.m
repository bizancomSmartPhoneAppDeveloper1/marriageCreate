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
    BOOL autoScrollStopped;
}
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

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
    
    autoScrollStopped = NO;
    
//    [self stopAutoScroll];
    
	if ([self.timer isValid]) {
		[self.timer invalidate];
	}
	self.timer = [NSTimer scheduledTimerWithTimeInterval:0.03
												  target:self
												selector:@selector(timerDidFire:)
												userInfo:nil
												 repeats:YES];
//	[self restartAutoScrollAfterDelay];
    
    //写真Image格納用配列
    _contentList = [NSMutableArray array];
    
    // 横スクロールバー非表示
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    [self webAccess];
    
    for (UIView *v in [_scrollView subviews]) {
        [v removeFromSuperview];
    }
    
	CGRect workingFrame = _scrollView.frame;
	workingFrame.origin.x = 0;
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:[_contentList count]];
	
	for (int i = 0; i < _contentList.count; i++) {
        UIImage *image = [_contentList objectAtIndex:i];
        [images addObject:image];
        
		UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
		[imageview setContentMode:UIViewContentModeScaleAspectFit];
		imageview.frame = workingFrame;
		
		[_scrollView addSubview:imageview];
		
		workingFrame.origin.x = workingFrame.origin.x + workingFrame.size.width;
	}
	
	[_scrollView setPagingEnabled:YES];
	[_scrollView setContentSize:CGSizeMake(workingFrame.origin.x, workingFrame.size.height)];
    
    // ナビゲーションバーを生成
    UINavigationBar* navBarTop = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    navBarTop.alpha = 0.7f;
    
    // ナビゲーションアイテムを生成
    UINavigationItem *title = [[UINavigationItem alloc] initWithTitle:@""];
    
    // 戻るボタンを生成
    UIBarButtonItem* rightItemBack = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(clickBack:)];
    
    // ナビゲーションアイテムの右側に戻るボタンを設置
    title.rightBarButtonItem = rightItemBack;
    
    // ナビゲーションバーにナビゲーションアイテムを設置
    [navBarTop pushNavigationItem:title animated:YES];
    
    // ビューにナビゲーションアイテムを設置
    [self.view addSubview:navBarTop];
    
}

- (IBAction)clickBack:(id)sender{
    [self performSegueWithIdentifier:@"fromSlideView" sender:self];
}

//ステータスバーをOFF
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webAccess{
    for (int i = 0; i < 5; i++) {
        //ランダム 17~22
        NSInteger randInt = arc4random_uniform(5) + 17;
        NSString *urlString = [NSString stringWithFormat:@"http://ec2-54-249-105-134.ap-northeast-1.compute.amazonaws.com/wp-content/uploads/2014/04/photo%ld.jpg",(long)randInt];
        NSURL *imageUrl = [NSURL URLWithString:urlString];
        NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
        [_contentList addObject:[[UIImage alloc] initWithData:imageData]];
    }
}

//自動スクロール開始
- (void)timerDidFire:(NSTimer*)timer
{
	if (autoScrollStopped) {
		return;
	}
    
	CGPoint p = self.scrollView.contentOffset;
	p.x = p.x + 1;
    
    CGRect aFrame = _scrollView.frame;
    
    //Imageの数だけ来ると自動スクロール停止
	if (p.x < ((aFrame.size.width * _contentList.count)- aFrame.size.width)) {
		self.scrollView.contentOffset = p;
	}
}
@end
