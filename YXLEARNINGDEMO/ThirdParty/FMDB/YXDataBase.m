//
//  YXDataBase.m
//  YXLEARNINGDEMO
//
//  Created by ~YXzr~ on 2017/1/20.
//  Copyright © 2017年 ~YXzr~. All rights reserved.
//

#import "YXDataBase.h"
#import "FMDB.h"

@interface YXDataBase()
@property(nonatomic, strong)FMDatabase *db;
@end

@implementation YXDataBase

+ (YXDataBase *)instance {
    static YXDataBase *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[YXDataBase alloc] init];
    });
    return _instance;
}

// 创建数据库
- (FMDatabase *)creatDataBaseWithDBName:(NSString *)name {
    
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [doc stringByAppendingPathComponent:name];
    //创建数据库
    self.db = [FMDatabase databaseWithPath:filePath];
    if (![self.db open]) {
        NSLog(@"获取数据库失败");
        return nil;
    }
    return self.db;
}

// 创建table
- (void)creatTable {
    if ([self.db open]) {
        BOOL result = [self.db executeUpdate:@"CREATE TABLE IF NOT EXISTS shopCar (dbid integer PRIMARY KEY AUTOINCREMENT, specId integer NOT NULL, shopNum integer NOT NULL default 1, shopInfo TEXT NOT NULL);"];
        if (result) {
            NSLog(@"创建成功");
        } else {
            NSLog(@"创建失败");
        }
        [self.db class];
    } else {
        NSLog(@"数据库打开失败");
    }
}

#pragma mark --给指定数据库建表
- (void)creatTableWithDB:(FMDatabase *)db andTableName:(NSString *)name keyTypes:(NSDictionary *)keyPaths {
    if ([self isOpenDatabase:db]) {
        NSMutableString *sql = [NSMutableString stringWithFormat:@"%@", [NSString stringWithFormat:@"CTEATE TABLE IF NOT EXISTS %@ (", name]];
        int count = 0;
        for (NSString *key in keyPaths.allKeys) {
            count++;
            [sql appendString:key];
            [sql appendString:@" "];
            [sql appendString:[keyPaths valueForKey:key]];
            if (count != keyPaths.count) {
                [sql appendString:@","];
            }
        }
        [sql appendString:@")"];
        [db executeUpdate:sql];
    }
}

#pragma mark --给指定数据库的表添加值
- (void)insertDataBase:(FMDatabase *)db withKeyValues:(NSDictionary *)keyValues intoTable:(NSString *)tableName {
    if ([self isOpenDatabase:db]) {
        NSMutableString *sql = [NSMutableString stringWithFormat:@"%@", [NSString stringWithFormat:@"INSERT INTO %@ (", tableName]];
        int count = 0;
        for (NSString *key in keyValues.allKeys) {
            [sql appendString:key];
            count++;
            if (count < keyValues.allKeys.count) {
                [sql appendString:@","];
            }
        }
        [sql appendString:@") VALUES ("];
        for (int i = 0; i < keyValues.allValues.count; i++) {
            [sql appendString:@"?"];
            if (i < keyValues.allValues.count- 1) {
                [sql appendString:@","];
            }
        }
        [sql appendString:@")"];
        [db executeUpdate:sql withArgumentsInArray:keyValues.allValues];
    }
}

#pragma mark --给指定数据库的表更新值
- (void)updateDataBase:(FMDatabase *)db withTable:(NSString *)tableName setKeyValues:(NSDictionary *)keyValues {
    if ([self isOpenDatabase:db]) {
        for (NSString *key in keyValues) {
            NSMutableString *sql = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"UPDATE %@ SET %@ = ?", tableName, key]];
             [db executeUpdate:sql,[keyValues valueForKey:key]];
        }
    }
}

#pragma mark --条件更新
- (void)updateDataBase:(FMDatabase *)db withTable:(NSString *)tableName setKeyValues:(NSDictionary *)keyValues whereCondition:(NSDictionary *)condition {
    if ([self isOpenDatabase:db]) {
        for (NSString *key in keyValues) {
            NSMutableString *sql = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"UPDATE %@ SET %@ = ? WHERE %@ = ?", tableName, key, [condition allKeys][0]]];
            [db executeUpdate:sql,[keyValues valueForKey:key],[keyValues valueForKey:[condition allKeys][0]]];
        }
    }
}

#pragma mark --查询数据库表中的所有值
- (NSArray *)selectselectDataBase:(FMDatabase *)db withKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName {
    FMResultSet *result = [db executeQuery: [NSString stringWithFormat:@"SELECT * FROM %@ LIMT 10", tableName]];
    return [self getArrWithFMResultSet:result keyTypes:keyTypes];
}

#pragma mark --条件查询数据库中的数据
- (NSArray *)selectDataBase:(FMDatabase *)db  withKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName whereCondition:(NSDictionary *)condition {
    if ([self isOpenDatabase:db]) {
        FMResultSet *result = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = ? LIMIT 10",tableName, [condition allKeys][0]], [condition valueForKey:[condition allKeys][0]]];
        return [self getArrWithFMResultSet:result keyTypes:keyTypes];
    } else {
        return nil;
    }
}

#pragma mark --模糊查询 某字段以指定字符串开头的数据
-(NSArray *)selectDataBase:(FMDatabase *)db withKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName whereKey:(NSString *)key beginWithStr:(NSString *)str {
    if ([self isOpenDatabase:db]) {
        FMResultSet *result =  [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ LIKE %@%% LIMIT 10",tableName, key, str]];
        return [self getArrWithFMResultSet:result keyTypes:keyTypes];
    } else
        return nil;
}

#pragma mark --模糊查询 某字段包含指定字符串的数据
-(NSArray *)selectDataBase:(FMDatabase *)db withKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName whereKey:(NSString *)key containStr:(NSString *)str {
    if ([self isOpenDatabase:db]) {
        FMResultSet *result =  [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ LIKE %%%@%% LIMIT 10",tableName, key, str]];
        return [self getArrWithFMResultSet:result keyTypes:keyTypes];
    }else
        return nil;
}

#pragma mark --模糊查询 某字段以指定字符串结尾的数据
-(NSArray *)selectDataBase:(FMDatabase *)db withKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName whereKey:(NSString *)key endWithStr:(NSString *)str {
    if ([self isOpenDatabase:db]) {
        FMResultSet *result =  [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ LIKE %%%@ LIMIT 10",tableName, key, str]];
        return [self getArrWithFMResultSet:result keyTypes:keyTypes];
    }else
        return nil;
}

#pragma mark --清理指定数据库中的数据
-(void)clearDatabase:(FMDatabase *)db from:(NSString *)tableName {
    if ([self isOpenDatabase:db]) {
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@",tableName]];
    }
}

#pragma mark --CommonMethod
- (NSArray *)getArrWithFMResultSet:(FMResultSet *)result keyTypes:(NSDictionary *)keyTypes {
    NSMutableArray *tempArr = [NSMutableArray array];
    while ([result next]) {
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
        for (int i = 0; i < keyTypes.count; i++) {
            NSString *key = [keyTypes allKeys][i];
            NSString *value = [keyTypes valueForKey:key];
            if ([value isEqualToString:@"text"]) {
                // 字符串
                [tempDic setValue:[result stringForColumn:key] forKey:key];
            } else if ([value isEqualToString:@"blob"]) {
                // 二进制对象
                [tempDic setValue:[result dataForColumn:key] forKey:key];
            } else if ([value isEqualToString:@"integer"]) {
                //  带符号整数类型
                [tempDic setValue:[NSNumber numberWithInt:[result intForColumn:key]]forKey:key];
            } else if ([value isEqualToString:@"boolean"]) {
                // BOOL型
                [tempDic setValue:[NSNumber numberWithBool:[result boolForColumn:key]] forKey:key];
            } else if ([value isEqualToString:@"date"]) {
                // date
                [tempDic setValue:[result dateForColumn:key] forKey:key];
            }
        }
        [tempArr addObject:tempDic];
    }
    return tempArr;
}

- (BOOL)isOpenDatabase:(FMDatabase *)db {
    if (![db open]) {
        [db open];
    }
    return YES;
}


@end
