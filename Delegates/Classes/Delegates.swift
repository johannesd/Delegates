//
//  Delegates.swift
//  Delegates
//
//  Created by Johannes Dörr on 17.02.19.
//

import Foundation

/**
 Container for storing multiple delegates.
 - Discussion: Objects are not retained, analogous to the standard one-object
 delegate pattern `weak var delegate: Delegate`.
 */
public class Delegates<Delegate: Any> {
    private var delegates = NSHashTable<AnyObject>.weakObjects()
    
    public init() { }
    
    public func add(_ delegate: Delegate) {
        delegates.add(delegate as AnyObject)
    }
    public func remove(_ delegate: Delegate) {
        autoreleasepool {
            delegates.remove(delegate as AnyObject)
        }
    }
    
    public var allObjects: [Delegate] {
        return delegates.allObjects.map({ $0 as! Delegate })
    }
    
    public func forEach(_ block: (Delegate) -> ()) {
        allObjects.forEach(block)
    }

    public func any(_ block: (Delegate) -> Bool) -> Bool {
        return allObjects.first(where: block) != nil
    }

    public func all(_ block: (Delegate) -> Bool) -> Bool {
        return allObjects.first(where: { !block($0) }) == nil
    }
}
