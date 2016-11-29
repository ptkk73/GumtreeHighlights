//
//  CollectionUtils.swift
//  TestApp_DataDownloader
//
//  Created by Piotr Kożuch on 28/11/2016.
//  Copyright © 2016 Piotr Kożuch. All rights reserved.
//

import Foundation

class CollectionUtils
{
    public static func transform<T, ResultType>(collection: [T], transformClosure: ((T) -> ResultType)) -> [ResultType]
    {
        return collection.map(transformClosure)
    }
}
