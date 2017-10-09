//
//  HYPlistTools.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/28.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYPlistTools.h"

@implementation HYPlistTools

+ (void)saveDataWithPlistName:(NSString *)plistName dataArray:(NSArray *)dataArray{
    
    NSString *namePath = [NSString stringWithFormat:@"%@.plist",plistName];
    NSString *filePath = [KCACHE_PATH stringByAppendingPathComponent:namePath];
    
    BOOL isWrite = [dataArray writeToFile:filePath atomically:YES];
    if (isWrite) {
        NSLog(@"%@写入成功",plistName);
    }
    else{
        NSLog(@"%@写入失败",plistName);
    }
}


+ (NSArray *)getArrayDataWithPlistName:(NSString *)plistName{
    
    NSString *namePath = [NSString stringWithFormat:@"%@.plist",plistName];
    NSString *filePath = [KCACHE_PATH stringByAppendingPathComponent:namePath];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    return array;
}

+ (NSDictionary *)getDictionaryDataInBundleWithPlistName:(NSString *)plistName{
    
    NSString *namePath = [NSString stringWithFormat:@"%@",plistName];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:namePath ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return dict;
}

+ (NSDictionary *)getDictionaryDataWithPlistName:(NSString *)plistName{
    
    NSString *namePath = [NSString stringWithFormat:@"%@.plist",plistName];
    NSString *filePath = [KCACHE_PATH stringByAppendingPathComponent:namePath];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return dict;
}

+ (void)removeDataWithPlistName:(NSString *)plistName{
    
    NSString *filePath = [KCACHE_PATH stringByAppendingPathComponent:plistName];
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:filePath error:nil];
}

+ (CGFloat )folderSizeAtPath:(NSString *)folderPath{
    
    NSFileManager *manager = [NSFileManager defaultManager];
    long long folderSize = 0;
    if ([manager fileExistsAtPath:folderPath]) {
        
        NSArray *filePath = [manager subpathsAtPath:folderPath];
        for (NSString *fileName in filePath) {
            NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
            long long size = [self fileSizeAtPath:fileAbsolutePath];
            folderSize += size;
        }
        //        folderSize += [[SDImageCache sharedImageCache] getSize];
        return folderSize / 1024.0 / 1024.0;
    }
    
    return 0;
}

+ (long long)fileSizeAtPath:(NSString *)path{
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size = [fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size;
    }
    return 0;
}

+ (void)clearCachesAtPath:(NSString *)path{
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        
        NSArray *childFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childFiles) {
            //如有需要，可加入条件，过滤掉不想删除的文件
            NSString *fileAbsolute = [path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:fileAbsolute error:nil];
        }
    }
    
}

@end
