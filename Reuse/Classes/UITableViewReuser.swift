//
//  UITableViewReuser.swift
//  Pods-Reuse_Example
//
//  Created by Oren F on 30/03/2018.
//

import UIKit

extension Reuser: UITableViewDataSource, UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems(in: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let instance = on(indexPath: indexPath)
        guard instance.isValidReuser else {
            let message: String
            switch instance.viewIdentifier {
            case "":
                message = "`InstanceReuser` is returning an empty string for `viewIdentifier`"
            default:
                message = "Object of type \(getObject(at: indexPath).name) does not have a designated `InstanceReuser`"
            }
            assert(false, message)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: instance.viewIdentifier, for: indexPath)
        instance.configure(cell)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        on(indexPath: indexPath).select()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return on(indexPath: indexPath).height
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return on(indexPath: indexPath).canDelete()
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        on(indexPath: indexPath).delete()
    }
    
    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return on(indexPath: indexPath).canBeMoved()
    }
    
    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        on(indexPath: sourceIndexPath).move(to: destinationIndexPath)
    }
}

