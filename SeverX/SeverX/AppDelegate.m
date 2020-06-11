//
//  AppDelegate.m
//  SeverX
//
//  Created by Leo on 2020/6/11.
//  Copyright © 2020 Leo. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self httpPost];
    return YES;
}
- (void)httpPost {
    NSString *host = @"http://localhost:8080/check";
    NSURL *url = [NSURL URLWithString:host];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{@"name":@"Andy", @"age":@3} options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        if (200 == httpResponse.statusCode) {
            if (data) {
                NSError *err = nil;
                id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
                if (!err) {
                    NSLog(@"response:%@", obj);
                } else {
                    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    NSLog(@"response:%@", str);
                }
            } else {
                NSLog(@"response:%@", data);
            }
        } else {
            NSLog(@"http error :%ld", (long)httpResponse.statusCode);
        }
        
    }];
    [task resume];
}

- (void)httpGet {
    NSString *host = @"http://localhost:8080/hello";
    NSURL *url = [NSURL URLWithString:host];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        if (200 == httpResponse.statusCode) {
            if (data) {
                NSError *err = nil;
                id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
                if (!err) {
                    NSLog(@"response:%@", obj);
                } else {
                    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    NSLog(@"response:%@", str);
                }
            } else {
                NSLog(@"response:%@", data);
            }
        } else {
            NSLog(@"http error :%ld", (long)httpResponse.statusCode);
        }
        
    }];
    [task resume];
}
#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
