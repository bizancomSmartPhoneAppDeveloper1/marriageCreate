//
//  ViewController.h
//  MarriageCreate
//
//  Created by bizan.com.mac05 on 2014/04/03.
//  Copyright (c) 2014年 teamInnovation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELCImagePickerController.h"
#import "ELCAlbumPickerController.h"
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h" // for Base64 encoding

@interface MainViewController : UIViewController<ELCImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,SKPSMTPMessageDelegate>
- (IBAction)toCamera:(UIButton *)sender;
- (IBAction)toSlideShow:(UIButton *)sender;
- (IBAction)toSend:(UIButton *)sender;

@end
