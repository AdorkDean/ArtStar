//
//  CommuntityHttpsDefine.h
//  ArtStar
//
//  Created by 文艺星球 on 2018/7/31.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#ifndef CommuntityHttpsDefine_h
#define CommuntityHttpsDefine_h

//MARK:--社区头条接口从这里开始--
/**
 根据前台传过来的用户ID和类别名称查出对应的新闻的集合
 */
#define communityServer [serverIP stringByAppendingString:@"community/ntvBynews"]
/**
 新闻搜索
 */
#define newsSearch [serverIP stringByAppendingString:@"community/newsSearch"]
/**
 新闻热搜词展示5个
 */
#define hotSearch [serverIP stringByAppendingString:@"community/hotSearch"]
/**
 新聞历史搜索
 */
#define oldSearch [serverIP stringByAppendingString:@"community/oldSearch"]
/**
 新闻清空历史搜索
 */
#define deleteSearchNews [serverIP stringByAppendingString:@"community/deleteSearchNews"]
/**
 点击查看新闻详情
 */
#define selectNewsByUid [serverIP stringByAppendingString:@"community/selectNewsByUid"]
/**
 根据新闻ID查出评论
 */
#define commentNews [serverIP stringByAppendingString:@"community/commentNews"]
/**
 新闻下根据评论ID点赞
 */
#define dianComment [serverIP stringByAppendingString:@"community/dianComment"]
/**
 评论新闻
 */
#define commentNewsByUid [serverIP stringByAppendingString:@"community/commentNewsByUid"]
/**
 回复评论
 */
#define commentByUid [serverIP stringByAppendingString:@"community/commentByUid"]
/**
 关闭新闻
 */
#define closeNewsByNid [serverIP stringByAppendingString:@"community/closeNewsByNid"]
/**
 新闻举报反馈
 */
#define addBackPinglun [serverIP stringByAppendingString:@"community/addBackPinglun"]
/**
 热搜新闻5条
 */
#define hotnews [serverIP stringByAppendingString:@"community/hotnews"]
/**
 新闻点赞接口
 */
#define diannews [serverIP stringByAppendingString:@"community/diannews"]
// MARK: --社区头条接口到这里结束--
// MARK: --社区话题接口从这里开始--
/**
 根据前台传过来的类别名称查出对应的话题的集合
 */
#define ntvByTopic [serverIP stringByAppendingString:@"community/ntvByTopic"]
/**
 根据前台传过来的用户ID和用户对话题的关系值查询对应的话题集合
 */
#define utBytopic [serverIP stringByAppendingString:@"community/utBytopic"]
/**
 社区话题搜索
 */
#define topicSearch [serverIP stringByAppendingString:@"community/topicSearch"]
/**
 话题搜索历史
 */
#define oldSearchTopic [serverIP stringByAppendingString:@"community/oldSearchTopic"]
/**
 根据前台传过来的用户ID和用户对话题的关系值查询对应的话题集合
 */
#define utBytopic [serverIP stringByAppendingString:@"community/utBytopic"]
/**
 点击查看话题详情和话题用户的关系改变
 */
#define selectTopicByUid [serverIP stringByAppendingString:@"community/selectTopicByUid"]
/**
 话题清空历史搜索
 */
#define deleteSearchTopic [serverIP stringByAppendingString:@"community/deleteSearchTopic"]
/**
 话题热门词5个
 */
#define hotSearchTopic [serverIP stringByAppendingString:@"community/hotSearchTopic"]
/**
 评论话题修改话题和用户的关系
 */
#define commentTopicByUid [serverIP stringByAppendingString:@"community/commentTopicByUid"]
/**
 话题下的回复评论
 */
#define commentByUidTopic [serverIP stringByAppendingString:@"community/commentByUidTopic"]
/**
 根据话题ID查出评论
 */
#define selectCommentByPid [serverIP stringByAppendingString:@"community/selectCommentByPid"]
/**
 根据话题ID点赞和取消点赞
 */
#define dianTopicBypid [serverIP stringByAppendingString:@"community/dianTopicBypid"]
// MARK: --社区话题接口到这里结束--
// MARK: --社区展览接口从这里开始--
/**
 根据类别名称查出对应的展览
 */
#define selectSlistByTypename [serverIP stringByAppendingString:@"community/selectSlistByTypename"]
/**
 根据展览id查看展览详情
 */
#define selectShowBySid [serverIP stringByAppendingString:@"community/selectShowBySid"]
/**
 根据场所ID查出对应的评价信息集合
 */
#define selectShowPlistjById [serverIP stringByAppendingString:@"community/selectShowPlistjById"]
/**
 用户对展览的评价
 */
#define addCommentByUidSid [serverIP stringByAppendingString:@"community/addCommentByUidSid"]
/**
 展览搜索
 */
#define showSearch [serverIP stringByAppendingString:@"community/showSearch"]
/**
 展览搜索历史
 */
#define oldSearchShow [serverIP stringByAppendingString:@"community/oldSearchShow"]
/**
 展览热门词搜索
 */
#define hotSearchShow [serverIP stringByAppendingString:@"community/hotSearchShow"]
/**
 展览清空历史搜索
 */
#define deleteSearchShow [serverIP stringByAppendingString:@"community/deleteSearchShow"]
// MARK: --展览接口到这里结束--

// MARK: --机构几口从这里开始--
/**
 根据类别查出对应的场所信息集合
 */
#define selectPlistByTid [serverIP stringByAppendingString:@"community/selectPlistByTid"]

/**
 根据分类查出对应的集合 交友
 */
#define selectUserBytypename [serverIP stringByAppendingString:@"community/selectUserBytypename"]
/**
 设置匹配度 交友
 */
#define updatePipeiduByUid [serverIP stringByAppendingString:@"community/updatePipeiduByUid"]
/**
 根据类别名称查出对应的演出集合
 */
#define selectPerformListByTypename [serverIP stringByAppendingString:@"community/selectPerformListByTypename"]
/**
 根据分类查出对应的集合(交友)
 */
#define selectUserBytypename [serverIP stringByAppendingString:@"community/selectUserBytypename"]
/**
 根据类别名称查出对应的活动
 */
#define selectActivityListByTypename [serverIP stringByAppendingString:@"community/selectActivityListByTypename"]
/**
 根据条件查今日推荐图书集合，畅销图书集合，你可能感兴趣图书集合
 */
#define selectBookListByCondition [serverIP stringByAppendingString:@"community/selectBookListByCondition"]
///活动机构详情
#define selectPlaceById [serverIP stringByAppendingString:@"community/selectPlaceById"]
///普通机构详情
#define findOneMerchant [serverIP stringByAppendingString:@"merchants/findOneMerchant"]
//文化消费页面
#define findOneMerchantParticulars [serverIP stringByAppendingString:@"consumption/findOneMerchantParticulars"]















// MARK: --广告接口--
/**
 根据类别名称查询不同的广告集合
 */
#define seleteMerchantsListByAid [serverIP stringByAppendingString:@"communityAdvertising/seleteMerchantsListByAid"]
/**
 根据广告ID查看场所机构集合
 */
#define selectAdvertisingListByAdvertisingPosition [serverIP stringByAppendingString:@"communityAdvertising/selectAdvertisingListByAdvertisingPosition"]
//打卡
#define firstTimePunchings [serverIP stringByAppendingString:@"community/firstTimePunchings"]
//打卡记录
#define selectPunchRecordListByUidAndMid [serverIP stringByAppendingString:@"community/selectPunchRecordListByUidAndMid"]


#endif /* CommuntityHttpsDefine_h */
