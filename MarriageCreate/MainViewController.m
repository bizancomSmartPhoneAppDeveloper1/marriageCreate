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
    emailMessage.subject =@"Title"; //件名に記載する内容
    emailMessage.wantsSecure = YES;
    emailMessage.delegate = self;
    NSString *messageBody = @"ここ本文です"; //メール本文に記載する内容
    NSDictionary *plainMsg = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey, messageBody,kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    
    //メールへの添付総まとめ配列（本文含む)
    NSMutableArray *mailParts = [NSMutableArray array];
    
    //本文格納
    [mailParts addObject:plainMsg];
    
    //イメージピッカーでの選択数に応じて処理を分岐
    switch (_images.count) {
        case 5:{
            NSData *image_data = UIImageJPEGRepresentation([_images objectAtIndex:4],1.0);
            NSString *strFormat = [NSString stringWithFormat:@"image/jpg;\r\n\tx-unix-mode=0644;\r\n\tname=\"photo.jng\""];
            NSString *strFormat2 = [NSString stringWithFormat:@"attachment;\r\n\tfilename=\"photo.jpg\""];
            image_parts5 = [NSDictionary dictionaryWithObjectsAndKeys:strFormat,kSKPSMTPPartContentTypeKey,
                            strFormat2,kSKPSMTPPartContentDispositionKey,[image_data encodeBase64ForData],kSKPSMTPPartMessageKey,@"base64",kSKPSMTPPartContentTransferEncodingKey,nil];
            [mailParts addObject:image_parts5];
        }
        case 4:{
            NSData *image_data = UIImageJPEGRepresentation([_images objectAtIndex:3],1.0);
            NSString *strFormat = [NSString stringWithFormat:@"image/jpg;\r\n\tx-unix-mode=0644;\r\n\tname=\"photo.jng\""];
            NSString *strFormat2 = [NSString stringWithFormat:@"attachment;\r\n\tfilename=\"photo.jpg\""];
            image_parts4 = [NSDictionary dictionaryWithObjectsAndKeys:strFormat,kSKPSMTPPartContentTypeKey,
                            strFormat2,kSKPSMTPPartContentDispositionKey,[image_data encodeBase64ForData],kSKPSMTPPartMessageKey,@"base64",kSKPSMTPPartContentTransferEncodingKey,nil];
            [mailParts addObject:image_parts4];
        }
        case 3:{
            NSData *image_data = UIImageJPEGRepresentation([_images objectAtIndex:2],1.0);
            NSString *strFormat = [NSString stringWithFormat:@"image/jpg;\r\n\tx-unix-mode=0644;\r\n\tname=\"photo.jng\""];
            NSString *strFormat2 = [NSString stringWithFormat:@"attachment;\r\n\tfilename=\"photo.jpg\""];
            image_parts3 = [NSDictionary dictionaryWithObjectsAndKeys:strFormat,kSKPSMTPPartContentTypeKey,
                            strFormat2,kSKPSMTPPartContentDispositionKey,[image_data encodeBase64ForData],kSKPSMTPPartMessageKey,@"base64",kSKPSMTPPartContentTransferEncodingKey,nil];
            [mailParts addObject:image_parts3];
        }
            
        case 2:{
            NSData *image_data = UIImageJPEGRepresentation([_images objectAtIndex:1],1.0);
            NSString *strFormat = [NSString stringWithFormat:@"image/jpg;\r\n\tx-unix-mode=0644;\r\n\tname=\"photo.jng\""];
            NSString *strFormat2 = [NSString stringWithFormat:@"attachment;\r\n\tfilename=\"photo.jpg\""];
            image_parts2 = [NSDictionary dictionaryWithObjectsAndKeys:strFormat,kSKPSMTPPartContentTypeKey,
                            strFormat2,kSKPSMTPPartContentDispositionKey,[image_data encodeBase64ForData],kSKPSMTPPartMessageKey,@"base64",kSKPSMTPPartContentTransferEncodingKey,nil];
            [mailParts addObject:image_parts2];
        }
        case 1:{
            
            NSData *image_data = UIImageJPEGRepresentation([_images objectAtIndex:0],1.0);
            NSString *strFormat = [NSString stringWithFormat:@"image/jpg;\r\n\tx-unix-mode=0644;\r\n\tname=\"photo.jng\""];
            NSString *strFormat2 = [NSString stringWithFormat:@"attachment;\r\n\tfilename=\"photo.jpg\""];
            image_parts1 = [NSDictionary dictionaryWithObjectsAndKeys:strFormat,kSKPSMTPPartContentTypeKey,
                            strFormat2,kSKPSMTPPartContentDispositionKey,[image_data encodeBase64ForData],kSKPSMTPPartMessageKey,@"base64",kSKPSMTPPartContentTransferEncodingKey,nil];
            [mailParts addObject:image_parts1];
        }
            break;
    }
    
    //メールの添付情報プロパティへ格納
    emailMessage.parts = mailParts;
    
    //メール送信
    [emailMessage send];
}

// E-Mail送信成功時にCallされる（成功時の処理をコーディングする）
-(void)messageSent:(SKPSMTPMessage *)message
{
    NSLog(@"送信完了");
    [SVProgressHUD dismiss];
    //アラート表示
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"送信完了" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}

// 送信エラー時にCallされる（エラー時の処理をコーディングする）
-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error
{
//    NSLog(@"Gmail送信失敗 - error(%d): %@",[error code],[error localizedDescription]);
    //アラート表示
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"送信失敗!" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}

//トップ画面への戻りメソッド
- (IBAction)mainViewReturnActionForSegue:(UIStoryboardSegue *)segue
{
    NSLog(@"top画面へ");
}
@end
