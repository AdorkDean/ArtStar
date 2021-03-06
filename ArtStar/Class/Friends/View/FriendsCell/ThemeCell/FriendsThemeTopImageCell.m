//
//  FriendsThemeTopImageCell.m
//  ArtStar
//
//  Created by abc on 5/21/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "FriendsThemeTopImageCell.h"
#import <AVFoundation/AVFoundation.h>

@interface FriendsThemeTopImageCell ()

@property (nonatomic,copy) NSNumber *rfuid;

@end

@implementation FriendsThemeTopImageCell

- (void)fillCellWithModel:(NSDictionary *)model{
    if (![model[@"content"] isKindOfClass:[NSNull class]]) {
        NSData *strData = [model[@"content"] dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:strData options:NSJSONReadingMutableContainers error:&error];
        if (!error) {
            NSString *str = dataArr[0];
            for (int i = 1; i < dataArr.count; i++) {str = [NSString stringWithFormat:@"%@\n%@",str,dataArr[i]];}
            if ([model[@"composing"] integerValue] == 6) {
                [ChangeTextViewTextStyle changeTextView:_textView text:str alignment:NSTextAlignmentLeft];
            }else if ([model[@"composing"] integerValue] == 7){
                [ChangeTextViewTextStyle changeTextView:_textView text:str alignment:NSTextAlignmentCenter];
            }else if ([model[@"composing"] integerValue] == 8){
                [ChangeTextViewTextStyle changeTextView:_textView text:str alignment:NSTextAlignmentRight];
            }
        }
    }
    if ([model[@"type"] integerValue] == 2) {
        [self showVideo];
        _themeLab.hidden = YES;
    }else if ([model[@"type"] integerValue] == 1){
        [self hideVideo];
        _themeLab.hidden = NO;
        _themeLab.text = [NSString stringWithFormat:@"# %@ #",model[@"title"]];
    }else{
        [self hideVideo];
        _themeLab.hidden = YES;
    }
    NSArray *imageArr = model[@"images"];
    _countLab.text = [NSString stringWithFormat:@"1/%lu",(unsigned long)imageArr.count];
    NSDictionary *imageDic = [imageArr firstObject];
    if ([model[@"type"] integerValue] == 2) {
        dispatch_queue_t requestImage = dispatch_queue_create("获取视频第一帧", DISPATCH_QUEUE_CONCURRENT);
        dispatch_sync(requestImage, ^{
            self->_topImage.image = [[KGRequestNetWorking shareIntance] thumbnailImageForVideo:[NSURL URLWithString:imageDic[@"imageURL"]]];
        });
    }else{
        [_topImage sd_setImageWithURL:[NSURL URLWithString:imageDic[@"imageURL"]]];
    }
    
    NSDictionary *dic = model[@"user"];
    if ([[NSString stringWithFormat:@"%@",dic[@"id"]] isEqualToString:[KGUserInfo shareInterace].userID]){
        _deleteBtu.hidden = NO;
    }else{
        _deleteBtu.hidden = YES;
    }
    [_headerIamge sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
    _nikNameLab.text = dic[@"username"];
    if (![model[@"location"] isKindOfClass:[NSNull class]]) {
        _locationLab.text = model[@"location"];
    }else{
        _locationLab.text = @"";
    }
    if (model[@"timeDiff "]) {
        _timeLab.text = model[@"timeDiff "];
    }else{
        _timeLab.text = model[@"createTimeStr"];
    }
    
    [_commentBtu setTitle:[NSString stringWithFormat:@"%li",[model[@"rccommentNum"] integerValue]] forState:UIControlStateNormal];
    [_zansBtu setTitle:[NSString stringWithFormat:@"%li",[model[@"likeCount"] integerValue]] forState:UIControlStateNormal];
    if ([model[@"islikeCount"] integerValue] == 0) {
        [_zansBtu setImage:Image(@"点赞") forState:UIControlStateNormal];
    }else{
        [_zansBtu setImage:Image(@"点赞选中") forState:UIControlStateNormal];
    }
    _rfuid = model[@"id"];
}

- (void)showVideo{
    _playView.hidden = NO;
    _playImage.hidden = NO;
}
- (void)hideVideo{
    _playView.hidden = YES;
    _playImage.hidden = YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)headerClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(headerPushInfo:)]) {
        [self.delegate headerPushInfo:_rfuid.integerValue];
    }
}

- (IBAction)deleteClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(deleteCell:)]) {
        [self.delegate deleteCell:_rfuid.integerValue];
    }
}
- (IBAction)shareClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(shareCell:)]) {
        [self.delegate shareCell:_rfuid.integerValue];
    }
}
- (IBAction)commentClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(commentCell:)]) {
        [self.delegate commentCell:_rfuid.integerValue];
    }
}
- (IBAction)zansClick:(UIButton *)sender {
    if ([sender.currentImage isEqual:Image(@"点赞")]) {
        [sender setImage:Image(@"点赞选中") forState:UIControlStateNormal];
        [sender setTitle:[NSString stringWithFormat:@"%li",[sender.currentTitle integerValue] + 1] forState:UIControlStateNormal];
    }else{
        [sender setImage:Image(@"点赞") forState:UIControlStateNormal];
        [sender setTitle:[NSString stringWithFormat:@"%li",[sender.currentTitle integerValue] - 1] forState:UIControlStateNormal];
    }
    if ([self.delegate respondsToSelector:@selector(zansCell:)]) {
        [self.delegate zansCell:self.rfuid.integerValue];
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
