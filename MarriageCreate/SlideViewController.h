//
//  SlideViewController.h
//  MarriageCreate
//
//  Created by bizan.com.mac05 on 2014/04/03.
//  Copyright (c) 2014年 teamInnovation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *contentList;
@property (nonatomic, retain) NSTimer* timer;

@end
