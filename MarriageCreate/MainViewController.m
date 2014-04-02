//
//  ViewController.m
//  MarriageCreate
//
//  Created by bizan.com.mac05 on 2014/04/03.
//  Copyright (c) 2014年 teamInnovation. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker {
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)toCamera:(UIButton *)sender {
}

- (IBAction)toSlideShow:(UIButton *)sender {
}

- (IBAction)toSend:(UIButton *)sender {
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] init];
    //最大選択数(上記init内でデフォルトは4)
    elcPicker.maximumImagesCount = 10;
	elcPicker.imagePickerDelegate = self;
    
    [self presentViewController:elcPicker animated:YES completion:nil];
}
@end
