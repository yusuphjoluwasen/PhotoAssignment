//
//  PhotoModel.swift
//  PhotosAssignment
//
//  Created by Guru on 04/06/2022.
//

import Foundation

struct PhotoModel:Codable{
    let id:Int?
    let albumId:Int?
    let title:String?
    let url:String?
    let thumbnailUrl:String?
}
