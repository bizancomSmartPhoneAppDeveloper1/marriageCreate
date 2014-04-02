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

@interface MainViewController : UIViewController<ELCImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>
- (IBAction)toCamera:(UIButton *)sender;
- (IBAction)toSlideShow:(UIButton *)sender;
- (IBAction)toSend:(UIButton *)sender;

@end
