//
//  ViewController.m
//  MarriageCreate
//
//  Created by bizan.com.mac05 on 2014/04/03.
//  Copyright (c) 2014年 teamInnovation. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
{
    NSDictionary *image_parts1,*image_parts2,*image_parts3,*image_parts4,*image_parts5;
}
@property NSMutableArray *images;

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
    
    _images = [NSMutableArray arrayWithCapacity:[info count]];
    
    for (NSDictionary *dict in info) {
        UIImage *image = [dict objectForKey:UIImagePickerControllerOriginalImage];
        [_images addObject:image];
	}
    
    //メール送信メソッド
    [self sendEmailInBackground];
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
    elcPicker.maximumImagesCount = 5;
	elcPicker.imagePickerDelegate = self;
    
    [self presentViewController:elcPicker animated:YES completion:nil];
}

//E-Mailを送信する際にCallする
-(void) sendEmailInBackground
{
    NSLog(@"Start Sending");
    SKPSMTPMessage *emailMessage = [[SKPSMTPMessage alloc] init];
    emailMessage.fromEmail = @"marriagecreate@gmail.com"; //送信者メールアドレス（Gmailのアカウント）
    emailMessage.toEmail = @"marriagecreate@yahoo.co.jp";                //宛先メールアドレス
    //emailMessage.ccEmail =@"cc@address";             //ccメールアドレス
    //emailMessage.bccEmail =@"bcc@address";         //bccメールアドレス
    emailMessage.requiresAuth = YES;
    emailMessage.relayHost = @"smtp.gmail.com";
    emailMessage.login = @"marriagecreate@gmail.com";         //ユーザ名（Gmailのアカウント）
    emailMessage.pass = @"QAZWSXedc";                       //パスワード（Gmailのアカウント）
    //2段階認証プロセスを利用する場合、アプリパスワードを使用する
    emailMessage.subject =@"ここ件名です"; //件名に記載する内容
    emailMessage.wantsSecure = YES;
    emailMessage.delegate = self;
    NSString *messageBody = @"ここ本文です"; //メール本文に記載する内容
    NSDictionary *plainMsg = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey, messageBody,kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    
    switch (_images.count) {
        case 5:{
            NSData *image_data = [NSKeyedArchiver archivedDataWithRootObject:[_images objectAtIndex:4]];
            image_parts5 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                            @"inline;\r\n\tfilename=\"photo.jpg\"",kSKPSMTPPartContentDispositionKey,
                            @"base64",kSKPSMTPPartContentTransferEncodingKey,
                            @"image/jpg;\r\n\tname=photo.jpg;\r\n\t-unix-mode=0644;",kSKPSMTPPartContentTypeKey,
                            [image_data encodeWrappedBase64ForData],kSKPSMTPPartMessageKey,
                            nil];
        }
        case 4:{
            NSData *image_data = [NSKeyedArchiver archivedDataWithRootObject:[_images objectAtIndex:3]];
            image_parts4 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                            @"inline;\r\n\tfilename=\"photo.jpg\"",kSKPSMTPPartContentDispositionKey,
                            @"base64",kSKPSMTPPartContentTransferEncodingKey,
                            @"image/jpg;\r\n\tname=photo.jpg;\r\n\t-unix-mode=0644;",kSKPSMTPPartContentTypeKey,
                            [image_data encodeWrappedBase64ForData],kSKPSMTPPartMessageKey,
                            nil];
        }
        case 3:{
            NSData *image_data = [NSKeyedArchiver archivedDataWithRootObject:[_images objectAtIndex:2]];
            image_parts3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                            @"inline;\r\n\tfilename=\"photo.jpg\"",kSKPSMTPPartContentDispositionKey,
                            @"base64",kSKPSMTPPartContentTransferEncodingKey,
                            @"image/jpg;\r\n\tname=photo.jpg;\r\n\t-unix-mode=0644;",kSKPSMTPPartContentTypeKey,
                            [image_data encodeWrappedBase64ForData],kSKPSMTPPartMessageKey,
                            nil];
        }
            
        case 2:{
            NSData *image_data = [NSKeyedArchiver archivedDataWithRootObject:[_images objectAtIndex:1]];
            image_parts2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                        @"inline;\r\n\tfilename=\"photo.jpg\"",kSKPSMTPPartContentDispositionKey,
                                        @"base64",kSKPSMTPPartContentTransferEncodingKey,
                                        @"image/jpg;\r\n\tname=photo.jpg;\r\n\t-unix-mode=0644;",kSKPSMTPPartContentTypeKey,
                                        [image_data encodeWrappedBase64ForData],kSKPSMTPPartMessageKey,
                                        nil];
        }
        case 1:{
            NSData *image_data = [NSKeyedArchiver archivedDataWithRootObject:[_images objectAtIndex:0]];
            image_parts1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                        @"inline;\r\n\tfilename=\"photo.jpg\"",kSKPSMTPPartContentDispositionKey,
                                        @"base64",kSKPSMTPPartContentTransferEncodingKey,
                                        @"image/jpg;\r\n\tname=photo.jpg;\r\n\t-unix-mode=0644;",kSKPSMTPPartContentTypeKey,
                                        [image_data encodeWrappedBase64ForData],kSKPSMTPPartMessageKey,
                                        nil];
        }
            break;
    }
    
    switch (_images.count) {
        case 5:
            emailMessage.parts = [NSArray arrayWithObjects:plainMsg,image_parts1,image_parts2,image_parts3,image_parts4,image_parts5,nil];
            break;
        case 4:
            emailMessage.parts = [NSArray arrayWithObjects:plainMsg,image_parts1,image_parts2,image_parts3,image_parts4,nil];
            break;
        case 3:
            emailMessage.parts = [NSArray arrayWithObjects:plainMsg,image_parts1,image_parts2,image_parts3,nil];
            break;
        case 2:
            emailMessage.parts = [NSArray arrayWithObjects:plainMsg,image_parts1,image_parts2,nil];
            break;
        
        case 1:
            emailMessage.parts = [NSArray arrayWithObjects:plainMsg,image_parts1,nil];
            break;
    }
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
