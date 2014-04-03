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

//ピッカー選択時の処理
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//ピッカーキャンセル時の処理
- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker {
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)toCamera:(UIButton *)sender {
}

- (IBAction)toSlideShow:(UIButton *)sender {
}

//ピッカー処理
- (IBAction)toSend:(UIButton *)sender {
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] init];
    //最大選択数(上記init内でデフォルトは4)
    elcPicker.maximumImagesCount = 10;
	elcPicker.imagePickerDelegate = self;
    
    [self presentViewController:elcPicker animated:YES completion:nil];
}

//E-Mailを送信する際にCallする
-(void) sendEmailInBackground
{
    NSLog(@"Start Sending");
    SKPSMTPMessage *emailMessage = [[SKPSMTPMessage alloc] init];
    emailMessage.fromEmail = @"sender@gmail.com"; //送信者メールアドレス（Gmailのアカウント）
    emailMessage.toEmail = @"to@address";                //宛先メールアドレス
    //emailMessage.ccEmail =@"cc@address";             //ccメールアドレス
    //emailMessage.bccEmail =@"bcc@address";         //bccメールアドレス
    emailMessage.requiresAuth = YES;
    emailMessage.relayHost = @"smtp.gmail.com";
    emailMessage.login = @"sender@gmail.com";         //ユーザ名（Gmailのアカウント）
    emailMessage.pass = @"password";                       //パスワード（Gmailのアカウント）
    //2段階認証プロセスを利用する場合、アプリパスワードを使用する
    emailMessage.subject =@"件名に記載する内容";
    emailMessage.wantsSecure = YES;
    emailMessage.delegate = self;
    NSString *messageBody = @"メール本文に記載する内容";
    NSDictionary *plainMsg = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey, messageBody,kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    emailMessage.parts = [NSArray arrayWithObjects:plainMsg,nil];
    [emailMessage send];
}

// E-Mail送信成功時にCallされる（成功時の処理をコーディングする）
-(void)messageSent:(SKPSMTPMessage *)message
{
    NSLog(@"Gmail送信完了");
    //アラート表示
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Gmail送信完了" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}

// 送信エラー時にCallされる（エラー時の処理をコーディングする）
-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error
{
//    NSLog(@"Gmail送信失敗 - error(%d): %@",[error code],[error localizedDescription]);
    //アラート表示
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Gmail送信失敗!" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}

@end
