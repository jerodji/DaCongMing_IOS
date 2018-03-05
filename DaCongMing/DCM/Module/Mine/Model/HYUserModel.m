
//
//  HYUserModel.m
//  DaCongMing
//
//

#import "HYUserModel.h"

@implementation HYUserInfo

//- (NSString *)id { if (_id) {return _id; } return @"";}
//- (NSString *)name {if (_name) {return _name;} return @"";}
//- (NSString *)age { if (_age) {return _age;} return @"";}
//- (NSString *)sex {if (_sex) {return _sex;} return @"";}
//- (NSString *)adress {if (_adress) {return _adress;} return @"";}
//- (NSString *)phone {if (_phone) {return _phone;} return @"";}
//- (NSString *)note {if (_note) {return _note;} return @"";}
//- (NSString *)head_image_url {if (_head_image_url) {return _head_image_url;} return @"";}
//- (NSString *)qrpath {if (_qrpath) {return _qrpath;} return @"";}


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            NSString *nameStr = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
            id value = [aDecoder decodeObjectForKey:nameStr];
            [self setValue:value forKey:nameStr];
        }
        free(ivars);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *nameStr = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        id  value = [self valueForKey:nameStr];
        [aCoder encodeObject:value forKey:nameStr];
    }
    
    free(ivars);
}


@end

@implementation HYParterRecommend

//- (NSString *)id { if(_id){return _id;} return @"";}
//- (NSString *)type { if(_type){return _type;} return @"";}
//- (NSString *)title {if(_title){return _title;} return @"";}
//- (NSString *)price {if(_price){return _price;} return @"";}
//- (NSString *)msg {if(_msg){return _msg;} return @"";}
//- (NSString *)recomMsg {if(_recomMsg){return _recomMsg;} return @"";}
//- (NSString *)recomlevel {if(_recomlevel){return _recomlevel;} return @"";}
//- (NSString *)recomer_name {if(_recomer_name){return _recomer_name;} return @"";}
//- (NSString *)recomer_phone {if(_recomer_phone){return _recomer_phone;} return @"";}
//- (NSString *)close_time {if(_close_time){return _close_time;} return @"";}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            NSString *nameStr = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
            id value = [aDecoder decodeObjectForKey:nameStr];
            [self setValue:value forKey:nameStr];
        }
        free(ivars);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *nameStr = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        id  value = [self valueForKey:nameStr];
        [aCoder encodeObject:value forKey:nameStr];
    }
    
    free(ivars);
}


@end

@implementation HYUserModel

//- (NSString *)token { if (_token) { return _token;} return @"";}
//- (HYUserInfo *)userInfo {if (_userInfo) {return _userInfo;} return [HYUserInfo new];}

+ (instancetype)sharedInstance{
    
    static HYUserModel *model;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        model = [[HYUserModel alloc] init];
        
    });
    
    return model;
}


- (void)clearData{
    
    //利用runtime清空model中所有的数据
    unsigned count = 0;
    // 获取注册类的属性列表，第一个参数是类，第二个参数是接收类属性数目的变量
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        
        objc_property_t propertyValue = properties[i];
        NSString *propertyName = [NSString stringWithCString:property_getName(propertyValue) encoding:NSUTF8StringEncoding];
        [self setValue:nil forKey:propertyName];
    }
    free(properties);
    //清除本地缓存
    [HYPlistTools removeDataWithName:KUserModelData];
    [KUSERDEFAULTS removeObjectForKey:KUserPhone];
    [KUSERDEFAULTS removeObjectForKey:KUserPassword];
    [KUSERDEFAULTS removeObjectForKey:KUserLoginType];
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            NSString *nameStr = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
            id value = [aDecoder decodeObjectForKey:nameStr];
            [self setValue:value forKey:nameStr];
        }
        free(ivars);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *nameStr = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        id  value = [self valueForKey:nameStr];
        [aCoder encodeObject:value forKey:nameStr];
    }
    
    free(ivars);
}



@end
