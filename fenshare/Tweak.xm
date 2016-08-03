#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "AMapPOI.h"
#import <CoreLocation/CoreLocation.h>

%hook AttendanceWorkViewController
- (void)creatUI
{
    %orig;
    UIButton *btnAdd=[[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-110, [UIScreen mainScreen].bounds.size.height-50, 100, 44)];
    [btnAdd setTitle:@"添加打卡地点" forState:UIControlStateNormal];
    btnAdd.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    [btnAdd addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [btnAdd setBackgroundColor:[UIColor blueColor]];
    [((UIViewController *)self).view addSubview:btnAdd];
    [((UIViewController *)self).view bringSubviewToFront:btnAdd];
}

%new
- (void)clickBtn
{
    UIView *showview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    showview.backgroundColor=[UIColor whiteColor];
    showview.tag=100;
    showview.alpha=0.7;
    [((UIViewController *)self).view addSubview:showview];

    UIView *showInputView=[[UIView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-300)/2, 100, 300, 400)];
    showInputView.tag=1001;
    showInputView.backgroundColor=[UIColor grayColor];

    [((UIViewController *)self).view addSubview:showInputView];

    UITapGestureRecognizer *tapClose=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickclose:)];
    [showview addGestureRecognizer:tapClose];
    
    UITextField *textla=[[UITextField alloc]initWithFrame:CGRectMake(20, 20, 260, 30)];
    textla.tag=101;
    textla.placeholder=@"114.1234";
    textla.keyboardType=UIKeyboardTypeEmailAddress;
    textla.borderStyle=UITextBorderStyleRoundedRect;
    [showInputView addSubview:textla];
    
    UITextField *textlo=[[UITextField alloc]initWithFrame:CGRectMake(20, 70, 260, 30)];
    textlo.tag=102;

    textlo.placeholder=@"22.1234";
    textlo.keyboardType=UIKeyboardTypeEmailAddress;
    textlo.borderStyle=UITextBorderStyleRoundedRect;
    [showInputView addSubview:textlo];
    
    UITextField *textaddress=[[UITextField alloc]initWithFrame:CGRectMake(20, 120, 260, 30)];
    textaddress.tag=103;
    textaddress.borderStyle=UITextBorderStyleRoundedRect;
    textaddress.placeholder=@"餐厅(粗略地址)";
    [showInputView addSubview:textaddress];

    
    UITextField *textdeaiyaddress=[[UITextField alloc]initWithFrame:CGRectMake(20, 170, 260, 30)];
    textdeaiyaddress.tag=104;
    textdeaiyaddress.borderStyle=UITextBorderStyleRoundedRect;
    textdeaiyaddress.placeholder=@"xx街道(详细地址)";
    [showInputView addSubview:textdeaiyaddress];
    
    UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 220, 70, 30)];
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    leftBtn.backgroundColor=[UIColor blackColor];
    leftBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [leftBtn addTarget:self action:@selector(closeBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [showInputView addSubview:leftBtn];

    UIButton *rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(210, 220,70, 30)];
    [rightBtn setTitle:@"添加" forState:UIControlStateNormal];
    rightBtn.backgroundColor=[UIColor blackColor];
    rightBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [rightBtn addTarget:self action:@selector(addBtn) forControlEvents:UIControlEventTouchUpInside];

    [showInputView addSubview:rightBtn];



}

%new
-(void)clickclose:(UITapGestureRecognizer *)recognizer
{
    UIView *grayView=recognizer.view;

    UIView *fuView=[grayView  superview];
    UIView *showInputView=[fuView viewWithTag:1001];

    [showInputView removeFromSuperview];
    [showInputView release];
    showInputView=nil;

    [grayView removeFromSuperview];
    [grayView release];
    grayView=nil;
    //还一个也要消失
}

%new
-(void)closeBtn
{
    UIView *grayView=[((UIViewController *)self).view viewWithTag:100];
    UIView *showInputView=[((UIViewController *)self).view viewWithTag:1001];
    [showInputView removeFromSuperview];
    [showInputView release];
    showInputView=nil;

    [grayView removeFromSuperview];
    [grayView release];
    grayView=nil;
}
%new 
-(void)addBtn
{
   // UIView *showInputView1= [((UIViewController *)self).view viewWithTag:1001];
    //UITextField *textla=[showInputView1 viewWithTag:101];
    //UITextField *textlo=[showInputView1 viewWithTag:102];
   // UITextField *textaddress=[showInputView1 viewWithTag:103];
    //UITextField *textdeaiyaddress=[showInputView1 viewWithTag:104];
     

    UIView *grayView=[((UIViewController *)self).view viewWithTag:100];
    UIView *showInputView=[((UIViewController *)self).view viewWithTag:1001];
    [showInputView removeFromSuperview];
    [showInputView release];
    showInputView=nil;

    [grayView removeFromSuperview];
    [grayView release];
    grayView=nil;
}

- (void)mapView:(id)arg1 didUpdateUserLocation:(id)arg2
{
	%log; 
	%orig;
}
- (void)reLocate
{
	%log; 
	%orig;
}
- (void)reStartLocate
{
	%log; 
	%orig;
}
%end

%hook LocationManager
- (void)locationManager:(id)arg1 didUpdateToLocation:(id)arg2 fromLocation:(id)arg3
{
	%log;
	//%orig;
	//	    locations = "120.670414,31.277885"; 120.668717,31.277329        locations = "120.670408,31.277884";
	//	"locations": "120.67036,31.277773"     120.666084,31.279867
	CLLocation *loc = [[CLLocation alloc] initWithLatitude:31.279867 longitude:120.666084];
    %orig(arg1,loc,arg3);
}
%end