//
//  CameraViewController.m
//  MarriageCreate
//
//  Created by 吉田ひろみち　　　　　　　　　　　　　　　　　　 on 2014/04/02.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "CameraViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface CameraViewController ()
@property(strong,nonatomic)AVCaptureSession *session;
@property(strong,nonatomic)AVCaptureStillImageOutput *stillImageOutput;
@end

@implementation CameraViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self configureCamera];
    
}

//カメラの設定
-(BOOL)configureCamera
{
    NSError *error;
    
    //セッションを作成
    if (self.session){
        [self.session stopRunning];
        self.session = nil;
    }
    self.session = [[AVCaptureSession alloc]init];
    
    //入力デバイス
    AVCaptureDevice *captureDevice = nil;
    NSArray *devices = [AVCaptureDevice devices];
    
    //背面カメラを見つける
    for (AVCaptureDevice *device in devices) {
        if (device.position==AVCaptureDevicePositionBack)
        {
            captureDevice = device;
        }
    }
    //カメラが見つからなかった場合
    if (captureDevice == nil) {
        return NO;
    }
    AVCaptureDeviceInput *deviceinput = [[AVCaptureDeviceInput alloc]initWithDevice:captureDevice error:&error];
    if (error) {return NO;}
    //静止画出力を作成
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc]init];
    
    //プレビュー用レイヤ
    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
    previewLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:previewLayer];
    
    //セッションの設定
    self.session.sessionPreset = AVCaptureSessionPresetPhoto;
    [self.session addInput:deviceinput];
    [self.session addOutput:self.stillImageOutput];
    
    
    [self.session startRunning];
    
    
    
    return YES;
}


//カメラボタン押時
-(IBAction)performCameraButtonAction:(id)sender
{
    AVCaptureConnection *connection = [self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    
    //静止画を撮影
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:connection
                                                       completionHandler:^(CMSampleBufferRef
                                                                           imageDataSampleBuffer,NSError *error)
     {
         //エラーの場合
         if (error) {return;}
         
         NSData *imagedata = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
         //画像のデータからUIImageを作成
         UIImage *image = [UIImage imageWithData:imagedata];
         //カメラロールに保存
         UIImageWriteToSavedPhotosAlbum(image,self, @selector(image:didFinishSavingImageWithError:contextInfo:), nil);
     }];
}
//カメラロール保存時に呼ばれるメソッド
-(void)image:(UIImage *)image didFinishSavingImageWithError:(NSError *)error contextInfo:(void *)contextinfo
{
    //エラーがあればメッセージ表示
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"エラー" message:@"写真の保存に失敗した" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    }
    
}


@end
