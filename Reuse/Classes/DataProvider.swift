//
//  DataProvider.swift
//  Pods-Reuse_Example
//
//  Created by Oren F on 28/03/2018.
//

import Foundation

/// A protocol describing a section which holds an array of `Usable` instances.
/// Used to divide `UITableView` and `UICollectionView` display into sections visually.
public protocol Section: class {
    
    /// An object to configure header
    var headerObject: Usable? { get }
    /// An array of objects for current section
    var objects: [Usable] { get set }
}

public extension Section {
    
    var headerObject: Usable? { return nil }
}

/// A protocol describing a data source.
/// When connecting a `DataProvider` to the `Reuser`, this instance will manage the logic and the `Reuser` will call these methods.
/// That enables maximum flexibility to control application logic
public protocol DataProvider: class {
    
    /// An array of `Section` conforming instances
    var sections: [Section] { get }
    
    /// Controls whether a cell in a tableView should allow showing `Delete` button.
    /// Default is `false`
    func canDeleteObject(at index: ObjectIndex) -> Bool
    
    /// An action to ask for an object to be deleted. If returns `false`, the tableView will not be updated.
    /// Allows control that terms are met, before deleting the object and updating the tableView.
    func deleteObject(at index: ObjectIndex) -> Bool
    
    /// Controls whether a cell can be moved to a new indexPath.
    /// Default is `false`
    func canMoveObject(at index: ObjectIndex) -> Bool
    /// An action to ask for an object to be moved. If returns `false`, the tableView will not be updated.
    /// Allows control that terms are met, before moving the object and updating the tableView.
    /// Default is `false`
    func moveObject(from fromIndex: ObjectIndex, to toIndex: ObjectIndex) -> Bool
}

// MARK: - Default values
public extension DataProvider {
    
    func object(at indexPath: IndexPath) -> Usable {
        return sections[indexPath.section].objects[indexPath.item]
    }
    
    func object(at index: ObjectIndex) -> Usable {
        return object(at: index.indexPath)
    }

    func canDeleteObject(at index: ObjectIndex) -> Bool {
        return false
    }
    
    func deleteObject(at index: ObjectIndex) -> Bool {
        guard isInBounds(index.indexPath) else { return false }
        sections[index.sectionIndex].objects.remove(at: index.objectIndex)
        return true
    }
    
    func canMoveObject(at index: ObjectIndex) -> Bool {
        return false
    }
    
    func moveObject(from fromIndex: ObjectIndex, to toIndex: ObjectIndex) -> Bool {
        guard isInBounds(fromIndex.indexPath) else { return false }
        let object = sections[fromIndex.sectionIndex].objects.remove(at: fromIndex.objectIndex)
        sections[toIndex.sectionIndex].objects.insert(object, at: toIndex.objectIndex)
        return true
    }
}

internal extension DataProvider {

    func isInBounds(_ indexPath: IndexPath) -> Bool {
        return (indexPath.section < sections.count &&
                indexPath.item < sections[indexPath.section].objects.count)
    }
}

/// A struct which represents a position of an object in the data source.
public struct ObjectIndex {
    
    /// IndexPath for object in data
    let indexPath: IndexPath
    /// A protocol representation of the instance.
    let section: Section
    
    /// An index of the object in `Section`'s `objects` array.
    var objectIndex: Int { return indexPath.item }
    /// An index of the section in `DataProvider`'s `sections` array.
    var sectionIndex: Int { return indexPath.section}
}

public extension DataProvider where Self: Section {
    /// Allows a single section to be a `DataProvider` with a single section
    var sections: [Section] { return [self] }
}
