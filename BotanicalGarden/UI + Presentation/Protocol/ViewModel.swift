//
//  ViewModel.swift
//  BotanicalGarden
//
//  Created by 黃偉勛 Terry on 2021/4/18.
//

import Foundation

public protocol ViewModel {

    associatedtype Inputs
    associatedtype Outputs

    var inputs: Inputs { get }
    var outputs: Outputs { get }
}
