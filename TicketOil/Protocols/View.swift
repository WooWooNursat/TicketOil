//
//  ViewController.swift
//  TicketOil
//
//  Created by Nursat on 19.04.2022.
//

public protocol View: AnyObject {
    // MARK: - Associated Types
    
    associatedtype ViewModelType
    
    // MARK: - Properties
    
    var viewModel: ViewModelType! { get }
}

