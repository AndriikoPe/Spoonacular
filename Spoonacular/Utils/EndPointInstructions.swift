//
//  EndPointInstructions.swift
//  Spoonacular
//
//  Created by Bohdan on 01.11.2022.
//

import Foundation

protocol NetworkRequestBodyConvertible {
    
    var data: Data? { get }
    var queryItems: [URLQueryItem]? { get }
    var parameters: [String : Any]? { get }
    
}

struct RecipeAnalyzeInstruction: NetworkRequestBodyConvertible {
    
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var data: Data? {
        "instructions=\(text)".data(using: .utf8)
    }
    var queryItems: [URLQueryItem]? { nil }
    
    var parameters: [String : Any]? {
        ["instructions" : text]
    }
    
}

struct RecipeSearchInstruction : NetworkRequestBodyConvertible{
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var data: Data? { nil }
    
    var queryItems: [URLQueryItem]? {
        [URLQueryItem(name: "query", value: text)]
    }
    
    var parameters: [String : Any]?{ nil }
    
    
}

struct GetRecipeInstruction: NetworkRequestBodyConvertible {
    
    var id: String
    
    init(_ id: String) {
        self.id = id
    }
    
    var data: Data? { nil }
    
    var queryItems: [URLQueryItem]? { nil }
     
    var parameters: [String : Any]? { nil }
    
    
}

struct GuessInstruction: NetworkRequestBodyConvertible {
    
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var data: Data? { nil }
    
    var queryItems: [URLQueryItem]? {
        [URLQueryItem(name: "title", value: text)]
    }
    
    var parameters: [String : Any]? {
        ["title": text]
    }
    
    
}

struct ClassifyInstruction: NetworkRequestBodyConvertible {
    
    var text: String
    var ingridientList: String
    
    init(_ text: String, _ ingridientList: String) {
        self.text = text
        self.ingridientList = ingridientList
    }
    
    
    var data: Data? {
        "ingredientList=\(ingridientList)&title=\(text)".data(using: .utf8)
    }
    
    var queryItems: [URLQueryItem]? { nil }
    
    var parameters: [String : Any]? {
        ["ingredientList" : ingridientList,
         "title": text]
    }
    
    
}
