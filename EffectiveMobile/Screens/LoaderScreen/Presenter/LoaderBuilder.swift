//
//  LoaderBuilder.swift
//  EffectiveMobile
//
//  Created by Алексей on 08.05.2025.
//

import Foundation

protocol LoaderBuilderProtocol: AnyObject {
    static func build(_ completion: @escaping (LoaderController) -> ())
}

final class LoaderBuilder: LoaderBuilderProtocol {
    static func build(_ completion: @escaping (LoaderController) -> ()) {
        let view = LoaderController()
        completion(view)
    }
}
