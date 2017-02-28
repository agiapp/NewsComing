//
//  WordDetailController.m
//  MyBaseProject
//
//  Created by 任波 on 15/12/6.
//  Copyright © 2015年 renbo. All rights reserved.
//

#import "WordDetailController.h"

@interface WordDetailController () <AVSpeechSynthesizerDelegate>
@property (strong, nonatomic) UITextView *contentTV;

@property (strong, nonatomic) AVSpeechSynthesizer *speech;
@property (strong, nonatomic) UIBarButtonItem *readItem;
#pragma mark - 
@property (strong, nonatomic) UIButton *shareBtn;

@end

@implementation WordDetailController

- (instancetype)initWithContent:(NSString *)content {
    if (self = [super init]) {
        self.content = content;
        [BarItem addBackItemToVC:self];
        self.title = @"详情";
        self.view.backgroundColor = [UIColor whiteColor];
        self.contentTV.text = self.content;
        self.navigationItem.rightBarButtonItem = self.readItem;
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
        [self shareBtn];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.speech stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}

#pragma mark - <AVSpeechSynthesizerDelegate>
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance {
    self.readItem.title = @"暂停";
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {
    self.readItem.title = @"读笑话";
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance {
    self.readItem.title = @"读笑话";
}

#pragma mark - 懒加载
- (UITextView *)contentTV {
	if(_contentTV == nil) {
		_contentTV = [[UITextView alloc] init];
        _contentTV.editable = NO;
        _contentTV.font = kSubtitleFont;
        [self.view addSubview:_contentTV];
        [_contentTV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(kWindowH/4);
            make.bottom.mas_equalTo(-kWindowH/2);
        }];
	}
	return _contentTV;
}

- (AVSpeechSynthesizer *)speech {
    if(_speech == nil) {
        _speech = [[AVSpeechSynthesizer alloc] init];
        _speech.delegate = self;
    }
    return _speech;
}

- (UIBarButtonItem *)readItem {
    if(_readItem == nil) {
        _readItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"读笑话" style:UIBarButtonItemStyleDone handler:^(id sender) {
            if (self.speech.speaking) {
                [self.speech stopSpeakingAtBoundary:AVSpeechBoundaryWord];
                return;
            }
            AVSpeechUtterance *utt = [AVSpeechUtterance speechUtteranceWithString:self.content];
            utt.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
            [self.speech speakUtterance:utt];
        }];
    }
    
    return _readItem;
}

- (UIButton *)shareBtn {
    if(_shareBtn == nil) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.backgroundColor = [UIColor redColor];
        [_shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
        [_shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateHighlighted];
        [self.view addSubview:_shareBtn];
        [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentTV.mas_bottom).mas_equalTo(0);
            make.right.mas_equalTo(-20);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        [_shareBtn bk_addEventHandler:^(id sender) {
            //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
            [UMSocialSnsService presentSnsIconSheetView:self
                                        appKey:@"5632e65ae0f55a556a0013d9"
                                              shareText:@"欢迎使用新闻来了"
                                             shareImage:[UIImage imageNamed:@"icon.png"]
                                        shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatTimeline,UMShareToWechatSession,
                                                         UMShareToSina,UMShareToTencent,UMShareToSms,UMShareToEmail,UMShareToRenren,UMShareToDouban,nil]
                                               delegate:nil];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

@end
