# Reuse

[![Version](https://img.shields.io/cocoapods/v/Reuse.svg?style=flat)](http://cocoapods.org/pods/Reuse)
[![License](https://img.shields.io/cocoapods/l/Reuse.svg?style=flat)](http://cocoapods.org/pods/Reuse)
[![Platform](https://img.shields.io/cocoapods/p/Reuse.svg?style=flat)](http://cocoapods.org/pods/Reuse)

## About Reuse

Reuse was created in an attempt to avoid the tedious, repetitive work required to populate UITableViews/UICollectionViews, in a simple to use, unified way.

It uses the concept of `InstanceReuser`s, a single configurator to manage all similar items.
Once created, all data will be provided from the `InstanceReuser` to drive the UI. It will also handle interaction and database updates.

### Example

Say we need to display a list of people.
Let's follow the most common pattern.

First, we create some structure to hold our data:
```swift
class PeopleDatabase {
    
    var people: [Person]
    
    init(people: [Person]) {
        self.people = people
    }
}
```
Second, we have our view controller:
```swift
class PeopleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let cellIdentifier: String = "person.cell.id"

    @IBOutlet weak var tableView: UITableView!

    var database: PeopleDatabase!

    func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return database.people.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = database.people[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PersonCell
        cell.nameLabel.text = person.name
        cell.emailLabel.text = person.email
        // ...
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = database.people[indexPath.row]
        let viewController = PersonViewController(person: person)
        navigationController?.push(viewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        // delete entry from database
        // update table
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // update database
    }

}
```

It's okay when you have a single table, but it's not scalable and will require some code duplications when you have more screens.

*Personal note:*

For me, I found that I lacked consistency in structuring this approach, sometime in the same project. That means theres a learning process each time I revisited code.


This is what `Reuse` is for. Having a reusable component system that could be applied to instance and can be shared across the app.

Let's modify the project to `Reuse`.

First, we implement the database protocols:

```swift
extension PeopleDatabase: Section, DataProvider {
    
    // MARK: DataProvider protocol

    var objects: [Usable] {
        get { return people }
        set { people = newValue }
    }
    
    func canDeleteObject(at index: ObjectIndex) -> Bool {
        return true
    }
    
    func canMoveObject(at index: ObjectIndex) -> Bool {
        return true
    }
}
```
By making our database both a `DataProvider` and a `Section`, we basically say it only has one section.

Then we create a reusable instance to configure our cells.
```swift
struct PersonReuser: InstanceReuser {
    
    var viewIdentifier: String { return "person.cell.id" }
    var height: CGFloat { return 120.0 }
    
    private var person: Person?
    private weak var navigationController: UINavigationController?
    
    // We inject a navigation controller to handle our navigation.
    // I would prefer injecting some `Navigator` protocol, which will allow easier testing and abstraction, but for simplicity we'll just use this.
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    // MARK: InstanceReuser protocol

    mutating func setObject(_ object: Usable) {
        person = object as? Person
    }
 
    func configure(_ reusable: Reusable) -> Bool {
        guard let person = person, let cell = reusable as? PersonCell else { return false }        
        cell.nameLabel?.text = person.name
        cell.emailLabel?.text = person.email
        return true
    }
    
    func select() {
        guard let person = person else { return }
        let viewController = PersonViewController(person: person)
        navigationController?.push(viewController, animated: true)
    }
}
```

Now all that's left is to refactor our view controller to create a `Reuser` and let it handle everything for us.
```swift
class PeopleViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var database: PeopleDatabase!
    private var reuser: Reuser!

    func viewDidLoad() {
        super.viewDidLoad()
        setupReuser()
        tableView.passHandling(to: reuser)
    }

    private func setupReuser() {
        reuser = Reuser(dataProvider: database)
        let instanceReuser = PersonReuser(navigationController: navigationController)
        reuser.register(instanceReuser, forObject: Person.self)
    }
}
```
And you're done. `Reuse` will handle everything else.
You can add logic to the `PersonReuser` or you could avoid writing it at all and just use the generic provided one. 
If you need more control, you could implement the `UITableViewDataSource` and `UITableViewDelegate` functions and just access your reuser using a subscript. For example:
```swift
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    reuser[indexPath].select()
    tableView.deselectRow(at: indexPath, animated: true)
}
```

Now, if you need it elsewhere, just `Reuse` it. No code duplications.
It easy to maintain, update or replace.

There's more you could do with it, but I'll let you explore.

Hope it will help you the same as it helps me.


## Installation

Reuse is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Reuse'
```

## Author

Oren Farhan

## License

Reuse is available under the MIT license. See the LICENSE file for more info.
