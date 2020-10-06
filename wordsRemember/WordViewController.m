//
//  WordViewController.m
//  wordsRemember
//
//  Created by liuhongnian on 2020/10/1.
//  Copyright © 2020 liuhongnian. All rights reserved.
//

#import "WordViewController.h"
#import "wordsRemember-Swift.h"

#import "NSObject+FBKVOController.h"
#import "Masonry.h"
#import "NSDate+AixCategory.h"
#import "NSArray+AixCategory.h"

#import "YYLabel.h"
#import "YYTextView.h"
#import "NSAttributedString+YYText.h"

@interface WordViewController ()

@property (nonatomic, strong) WordViewModel *viewModel;

@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, strong) UILabel *week;

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) YYTextView *wordView;
@property (nonatomic, strong) YYLabel *wordLabel;
@property (nonatomic, strong) YYLabel *fromLabel;

@property (nonatomic, strong) NSArray *weekDays;
@property (nonatomic, strong) UIButton *refreshButton;

@end

@implementation WordViewController

- (void)injected
{
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [self loadUIView];
    [self p_addMasonry];
    
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
 
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        _weekDays = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
        
        _viewModel = [[WordViewModel alloc] init];
        [self observeViewModel];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_viewModel goldenWords];
    
    [self loadUIView];
    
    [self p_addMasonry];
    
    NSInteger week = [NSDate date].x_weekDay;
    _week.text = [_weekDays x_safeObjectAtIndex:week - 1];
    
    NSInteger day = [NSDate date].x_day;
    _dayLabel.text = [NSString stringWithFormat:@"%02ld",(long)day];

}

- (void)loadUIView
{
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    
    [self.view addSubview:self.dayLabel];
    
    [self.view addSubview:self.week];
    
    [self.view addSubview:self.containerView];
    [self.containerView addSubview:self.refreshButton];
    [self.containerView addSubview:self.fromLabel];
    
}

#pragma mark UI actions

- (void)refreshAction
{
    
    [self.viewModel goldenWords];
}

#pragma mark - # Private Methods
- (void)p_addMasonry {
    
    [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(84);
        make.left.equalTo(self.view.mas_left).offset(44);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    [self.refreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.containerView.mas_centerX);
        make.centerY.equalTo(self.containerView.mas_centerY);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    
    [self.week mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dayLabel.mas_right).offset(0);
        make.bottom.equalTo(self.dayLabel.mas_bottom).offset(-13);
        make.height.mas_equalTo(20);
    }];
    
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.dayLabel.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left).offset(44);
        make.bottom.equalTo(self.view.mas_bottom).offset(-100);
        make.right.equalTo(self.view.mas_right).offset(-44);
        
    }];
    
    
    [_fromLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView.mas_left).offset(20);
        make.bottom.equalTo(self.containerView.mas_bottom).offset(-60);
        make.width.mas_equalTo(40);
        
    }];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)observeViewModel
{
    __weak typeof(self) weakSelf = self;

    [self.KVOController observe:self.viewModel
                        keyPath:FBKVOKeyPath(_viewModel.wordResult)
                        options:NSKeyValueObservingOptionNew
                          block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *resultDic = change[NSKeyValueChangeNewKey];
            [weakSelf refreshWordView:resultDic];
            
            weakSelf.refreshButton.hidden = YES;
            weakSelf.wordView.hidden = NO;
            weakSelf.fromLabel.hidden = NO;
        });

        
        double delayInSeconds = 10;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [weakSelf.viewModel goldenWords];
        });
        
    }];
    
    
    [self.KVOController observe:self.viewModel
                        keyPath:FBKVOKeyPath(_viewModel.error)
                        options:NSKeyValueObservingOptionNew
                          block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        
        NSError *error = change[NSKeyValueChangeNewKey];
        if (error.domain) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.refreshButton.hidden = NO;
                weakSelf.wordView.hidden = YES;
                weakSelf.fromLabel.hidden = YES;
            });
        }
    }];
}

- (void)refreshWordView:(NSDictionary *)word
{
    
    NSString *string = word[@"hitokoto"];
    
    NSMutableAttributedString *attText = [[NSMutableAttributedString alloc] initWithString:string];
    
    // 2. Set attributes to text, you can use almost all CoreText attributes.
    //font
//    [UIFont fontWithName:@"Times New Roman" size:12]
//    [UIFont fontWithName:@"AmericanTypewriter-Bold" size:30]
    attText.yy_font = [UIFont fontWithName:@"Times New Roman" size:25];
    attText.yy_lineSpacing = 1;
    
    //set text content
    self.wordView.attributedText = attText;
    self.wordView.verticalForm = YES;
    
    
    NSString *from = word[@"from"];
    self.fromLabel.text = from;
    
    //animate
    self.wordView.alpha = 0;
    self.fromLabel.alpha = 0;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.wordView.alpha = 1;
        weakSelf.fromLabel.alpha = 1;
    }];
    
}

#pragma mark - # Getter

- (UIView *)containerView {
    
    if (!_containerView) {
            _containerView = [[UIView alloc] init];
            _containerView.backgroundColor = UIColor.whiteColor;
            _containerView.layer.cornerRadius = 10;
            _containerView.layer.shadowColor = [UIColor blackColor].CGColor;
        //    阴影的透明度
            _containerView.layer.shadowOpacity = 0.1f;
        //    阴影的圆角
        //    _containerView.layer.shadowRadius = 5.f;
        //    阴影偏移量
            _containerView.layer.shadowOffset = CGSizeMake(0.1,0.1);
    }
    return _containerView;
}


- (UILabel *)dayLabel {
    if (!_dayLabel) {
        _dayLabel = [[UILabel alloc] init];
        _dayLabel.textColor = UIColor.blackColor;
        _dayLabel.font = [UIFont systemFontOfSize:46];
    }
    return _dayLabel;
}

- (UILabel *)week {
    if (!_week) {
        _week = [[UILabel alloc] init];
        _week.font = [UIFont systemFontOfSize:16];
        _week.textColor = [UIColor colorWithRed:0.81 green:0.81 blue:0.81 alpha:1.00];
        
    }
    return _week;
}

- (UIButton *)refreshButton
{
    if (!_refreshButton) {
        
        _refreshButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_refreshButton setImage:[[UIImage imageNamed:@"refresh_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [_refreshButton addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventTouchUpInside];
        _refreshButton.hidden = YES;
    }
    return _refreshButton;
}

- (YYTextView *)wordView
{
    if (!_wordView) {
        
        _wordView = [[YYTextView alloc] initWithFrame:CGRectZero];
        _wordView.editable = NO;
        _wordView.textVerticalAlignment = YYTextVerticalAlignmentTop;
        [self.containerView addSubview:_wordView];
        
        [_wordView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.containerView.mas_top).offset(60);
            make.left.equalTo(self.containerView.mas_left).offset(90);
            make.bottom.equalTo(self.containerView.mas_bottom).offset(-60);
            make.right.equalTo(self.containerView.mas_right).offset(-40);
        }];
    }
    
    return _wordView;
}

- (YYLabel *)fromLabel
{
    if (!_fromLabel) {
        _fromLabel = [[YYLabel alloc] initWithFrame:CGRectZero];
        _fromLabel.verticalForm = YES;
    }
    return _fromLabel;
}

@end
