//
//  BookResponse.swift
//  ApiBookDecoder
//
//  Created by Mac on 16/05/23.
//

import Foundation
import UIKit
struct BookResponse : Decodable{
    var total : String
    var error : String
    var books : [Book]
}
struct Book : Decodable{
    var title : String
    var subtitle : String
    var isbn13 : String
    var image : String
    var price : String
    
}

