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
        let instance = getInstance(on: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: instance.viewIdentifier, for: indexPath)
        instance.configure(cell)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getInstance(on: indexPath).select()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return getInstance(on: indexPath).height
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return getInstance(on: indexPath).canDelete()
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        getInstance(on: indexPath).delete()
    }
    
    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return getInstance(on: indexPath).canBeMoved()
    }
    
    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        getInstance(on: sourceIndexPath).move(to: destinationIndexPath)
    }
    
    private func getInstance(on indexPath: IndexPath) -> InstanceReuser {
        do {
            let instance = try on(indexPath: indexPath)
            return instance
        }
        catch {
            assert(false, error.localizedDescription)
        }
    }
}

