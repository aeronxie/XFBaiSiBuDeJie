//
//  XFLoginViewController.m
//  
//
//  Created by 谢飞 on 16/2/20.
//
//

#import "XFLoginViewController.h"
#import <objc/runtime.h>

@interface XFLoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@property (weak, nonatomic) IBOutlet UIButton *QQBtn;
@property (weak, nonatomic) IBOutlet UIButton *sinaBtn;
@property (weak, nonatomic) IBOutlet UIButton *tencentBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;
@property (weak, nonatomic) IBOutlet UIView *textView;
@property (weak, nonatomic) IBOutlet UILabel *quickBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftlineWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightlineWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textLeft;

@end

@implementation XFLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topConstraint.constant = -250;
    self.leftlineWidth.constant = 0;
    self.rightlineWidth.constant = 0;

    self.forgetBtn.layer.mask = [[CALayer alloc]init];
    self.quickBtn.layer.mask = [[CALayer alloc]init];
    self.registerBtn.layer.mask = [[CALayer alloc]init];

    
}
//注册按钮
- (IBAction)registerBtn:(UIButton *)sender {
    if (self.textLeft.constant == 0) { // 显示注册界面
        self.textLeft.constant = - self.view.width;
        sender.selected = YES;
    } else { // 显示登录界面
        self.textLeft.constant = 0;
        sender.selected = NO;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];

}
//需要的动画
-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [UIView animateWithDuration:1.0 animations:^{
        self.closeBtn.transform = CGAffineTransformMakeRotation(M_PI);
        
    }];
    
    self.topConstraint.constant = 40;
    self.leftlineWidth.constant = 103;
    self.rightlineWidth.constant = 103;

    [UIView animateWithDuration:1.0 delay:0.5 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        //忘记密码动画
        [self setupAnimationWithStartRect:CGRectMake(0, 0, 0, CGRectGetHeight(self.forgetBtn.frame)) endRect:CGRectMake(0, 0, CGRectGetWidth(self.forgetBtn.frame), CGRectGetHeight(self.forgetBtn.frame)) object:self.forgetBtn duration:0.5];
        //注册按钮动画
        [self setupAnimationWithStartRect:CGRectMake(-(CGRectGetWidth(self.registerBtn.frame)), 0, 0, CGRectGetHeight(self.registerBtn.frame)) endRect:CGRectMake(0, 0, CGRectGetWidth(self.registerBtn.frame), CGRectGetHeight(self.registerBtn.frame)) object:self.registerBtn duration:0.5];
        
    }];
    
    //快速登录动画
    [self setupAnimationWithStartRect:CGRectMake(self.quickBtn.width/2, 0, 0, CGRectGetHeight(self.quickBtn.frame)) endRect:CGRectMake(0, 0, CGRectGetWidth(self.quickBtn.frame), CGRectGetHeight(self.quickBtn.frame)) object:self.quickBtn duration:0.5];
    
    
    [UIView animateWithDuration:0.1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        self.QQBtn.transform = CGAffineTransformMakeScale(0.01, 0.01);
        self.sinaBtn.transform = CGAffineTransformMakeScale(0.01, 0.01);
        self.tencentBtn.transform = CGAffineTransformMakeScale(0.01, 0.01);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1 delay:1.5 usingSpringWithDamping:0.4 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
                    self.QQBtn.transform = CGAffineTransformIdentity;
                    self.sinaBtn.transform = CGAffineTransformIdentity;
                    self.tencentBtn.transform = CGAffineTransformIdentity;

                } completion:nil];
        }];
    
}


//设置动画
-(void)setupAnimationWithStartRect:(CGRect)startRect endRect:(CGRect)endRect object:(UIView *)view duration:(NSTimeInterval)duration {
    
    UIBezierPath *beginPath = [UIBezierPath bezierPathWithRect:startRect];
    
    UIBezierPath *endPath = [UIBezierPath bezierPathWithRect:endRect];
    
    CAShapeLayer *quickMask = [[CAShapeLayer alloc]init];
    quickMask.path = endPath.CGPath;
    quickMask.fillColor = [UIColor whiteColor].CGColor;
    view.layer.mask = quickMask;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.duration = duration;
    animation.beginTime = CACurrentMediaTime();
    animation.fromValue = (__bridge id _Nullable)(beginPath.CGPath);
    animation.toValue = (__bridge id _Nullable)(endPath.CGPath);
    [quickMask addAnimation:animation forKey:@"path"];

}

//关闭控制器
- (IBAction)close:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return  UIStatusBarStyleLightContent;
}
@end
