//
//  IHTMLDownloader.swift
//  TestApp_DataDownloader
//
//  Created by Piotr Kożuch on 23/11/2016.
//  Copyright © 2016 Piotr Kożuch. All rights reserved.
//

import Foundation

protocol IHTMLDownloader
{
    func onDownloadStarted()
    func onDownloadFailed()
    func onDownloadSuccessful(result: String?)
}
