//
//  XFDetailPictureController.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/27.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFDetailPictureController.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "DALabeledCircularProgressView.h"

@interface XFDetailPictureController ()
@property (nonatomic,strong) UIButton *saveBtn;
@property (nonatomic,strong) UIButton *shareBtn;
@property (nonatomic,strong) UIButton *commentBtn;
@property (nonatomic,strong) UIButton *backBtn;
@property (nonatomic,strong) UIView *backgroundView;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) DALabeledCircularProgressView *progressView;
@end

@implementation XFDetailPictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialViews];
    [self loadImgae];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//加载图片
-(void)loadImgae {
    
    [self.imageView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.1f%%",progress*100];
        [self.progressView setProgress:progress animated:YES];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    
}

//初始化控件
-(void)initialViews {
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
    [self.scrollView addSubview:self.backBtn];
    [self.scrollView addSubview:self.saveBtn];
    [self.scrollView addSubview:self.shareBtn];
    [self.scrollView addSubview:self.commentBtn];
    [self.scrollView addSubview:self.progressView];
}

-(void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//保存图片
-(void)saveImageBtn {
    
    if(self.imageView.image != nil) {
        UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }else{
        [SVProgressHUD showErrorWithStatus:@"加载失败..."];
    }
 
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
    
}

#pragma mark - getter and setter

- (UIButton *)backBtn{
    if (_backBtn == nil) {
        _backBtn = [[UIButton alloc]init];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"show_image_back_icon"] forState:UIControlStateNormal];
        _backBtn.x = 20;
        _backBtn.y = 30;
        [[_backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [_backBtn sizeToFit];
        
    }
    return _backBtn;
}

- (UIButton *)shareBtn{
    if (_shareBtn == nil) {
        _shareBtn = [[UIButton alloc]init];
        [_shareBtn setImage:[UIImage imageNamed:@"mainCellShare"] forState:UIControlStateNormal];
        NSString *sharnCount = [NSString stringWithFormat:@"%ld",(long)self.topic.repost];
        [_shareBtn setTitle:sharnCount forState:UIControlStateNormal];
        _shareBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _shareBtn.x = SCREEN_WIDTH - 120;
        _shareBtn.y = SCREEN_HEIGHT - 35;
        [_shareBtn sizeToFit];
        
    }
    return _shareBtn;
}

- (UIButton *)commentBtn{
    if (_commentBtn == nil) {
        _commentBtn = [[UIButton alloc]init];
        [_commentBtn setImage:[UIImage imageNamed:@"mainCellComment"] forState:UIControlStateNormal];
        NSString *commentCount = [NSString stringWithFormat:@"%ld",(long)self.topic.comment];
        [_commentBtn setTitle:commentCount forState:UIControlStateNormal];
        _commentBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _commentBtn.x = SCREEN_WIDTH - 60;
        _commentBtn.y = SCREEN_HEIGHT - 35;
        [_commentBtn sizeToFit];
        
    }
    return _commentBtn;
}

- (UIButton *)saveBtn{
    if (_saveBtn == nil) {
        _saveBtn = [[UIButton alloc]init];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        _saveBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _saveBtn.x = 25;
        _saveBtn.y = SCREEN_HEIGHT - 35;
        [_saveBtn sizeToFit];

        [[_saveBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self saveImageBtn];
        }];
    }
    return _saveBtn;
}

- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.frame = SCREEN_FRAME;
        _scrollView.backgroundColor = [UIColor blackColor];
        
    }
    return _scrollView;
}

- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]init];
        _imageView.userInteractionEnabled = YES;
        [_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
        
        CGFloat picW = SCREEN_WIDTH;
        CGFloat picH = picW * self.topic.height / self.topic.width;
        if (picH > SCREEN_HEIGHT) { // 图片显示高度超过一个屏幕, 需要滚动查看
            _imageView.frame = CGRectMake(0, 0, picW, picH);
            self.scrollView.contentSize = CGSizeMake(0, picH);
        } else {
            _imageView.size = CGSizeMake(picW, picH);
            _imageView.centerY = SCREEN_HEIGHT * 0.5;
        }

    }
    return _imageView;
}

- (DALabeledCircularProgressView *)progressView{
    if (_progressView == nil) {
        _progressView = [[DALabeledCircularProgressView alloc]init];
        _progressView.size = CGSizeMake(100, 100);
        _progressView.centerY = SCREEN_HEIGHT / 2;
        _progressView.centerX = SCREEN_WIDTH / 2;
        _progressView.progressLabel.textColor = [UIColor whiteColor];
        _progressView.roundedCorners = 3;
        
    }
    return _progressView;
}


@end
