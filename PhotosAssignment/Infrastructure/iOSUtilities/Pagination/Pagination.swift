//
//  Pagination.swift
//  PhotosAssignment
//
//  Created by Guru on 05/06/2022.
//

import Foundation

class PaginationApiClass<Element>{
    private var pageNumber = 1
    private var fetchMoreData = true
    
    func incrementPageNumber() {
        pageNumber += 1
    }
    
    func resetPageNumber(){
        pageNumber = 1
    }
    
    
    func fetch(_ action:@escaping () -> Void){
        if fetchMoreData{
            action()
        }
    }
    
    func stopFetching(_ items:[Element]){
        if items.count == 0{
            fetchMoreData = false
        }
    }
    
    var pageNum:Int{
        pageNumber
    }
}
