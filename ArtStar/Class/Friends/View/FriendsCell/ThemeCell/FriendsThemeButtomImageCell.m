//
//  FriendsThemeButtomImageCell.m
//  ArtStar
//
//  Created by abc on 5/21/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "FriendsThemeButtomImageCell.h"
#import <AVFoundation/AVFoundation.h>

@interface FriendsThemeButtomImageCell ()

@property (nonatomic,copy) NSNumber *rfuid;

@end

@implementation FriendsThemeButtomImageCell

- (void)fillCellWithModel:(FriendsModel *)model{
    NSData *strData = [model.content dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:strData options:NSJSONReadingMutableContainers error:&error];
    NSString *str = dataArr[0];
    for (int i = 1; i < dataArr.count; i++) {
        str = [NSString stringWithFormat:@"%@\n%@",str,dataArr[i]];
    }
    if ([model.composing integerValue] == 5) {
        [ChangeTextViewTextStyle changeTextView:_textView text:str alignment:NSTextAlignmentLeft];
    }else if ([model.composing integerValue] == 6){
        [ChangeTextViewTextStyle changeTextView:_textView text:str alignment:NSTextAlignmentCenter];
    }else if ([model.composing integerValue] == 7){
        [ChangeTextViewTextStyle changeTextView:_textView text:str alignment:NSTextAlignmentRight];
    }
    if ([model.type integerValue] == 2) {
        [self showVideo];
        _themeLab.hidden = YES;
    }else if ([model.type integerValue] == 1){
        [self hideVideo];
        _themeLab.text = model.title;
    }else{
        [self hideVideo];
        _themeLab.hidden = YES;
    }
    NSDictionary *imageDic = [model.images firstObject];
    if ([model.type integerValue] == 2) {
        _topImage.image = [self thumbnailImageForVideo:[NSURL URLWithString:imageDic[@"imageURL"]]];
    }else{
        [_topImage sd_setImageWithURL:[NSURL URLWithString:imageDic[@"imageURL"]]];
    }
    
    NSDictionary *dic = model.user;
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
    _nikNameLab.text = dic[@"username"];
    _locationLab.text = model.location;
    _timeLab.text = model.createTimeStr;
    
    [_commentBtu setTitle:[NSString stringWithFormat:@"%ld",(long)model.rccommentNum.integerValue] forState:UIControlStateNormal];
    [_zansBtu setTitle:[NSString stringWithFormat:@"%ld",(long)model.likeCount.integerValue] forState:UIControlStateNormal];
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
        [self.delegate headerPushInfo:self.rfuid.integerValue];
    }
}

- (IBAction)deleteClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(deleteCell:)]) {
        [self.delegate deleteCell:self.rfuid.integerValue];
    }
}
- (IBAction)shareClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(shareCell:)]) {
        [self.delegate shareCell:self.rfuid.integerValue];
    }
}
- (IBAction)commentClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(commentCell:)]) {
        [self.delegate commentCell:self.rfuid.integerValue];
    }
}
- (IBAction)zansClick:(UIButton *)sender {
    if ([sender.currentImage isEqual:Image(@"点赞")]) {
        [sender setImage:Image(@"点赞选中") forState:UIControlStateNormal];
    }else{
        [sender setImage:Image(@"点赞") forState:UIControlStateNormal];
    }
    if ([self.delegate respondsToSelector:@selector(zansCell:)]) {
        [self.delegate zansCell:self.rfuid.integerValue];
    }
}

- (UIImage *)thumbnailImageForVideo:(NSURL *)video{
    AVURLAsset *asset = [[AVURLAsset alloc]initWithURL:video options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = 1;
    NSError *error = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60) actualTime:NULL error:&error];
    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage:thumbnailImageRef] : nil;
    return thumbnailImage;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
