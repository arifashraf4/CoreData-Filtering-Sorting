//
//  ViewController.swift
//  CoreData Assignment
//
//  Created by arifashraf on 17/11/21.
//

import UIKit
import CoreData

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    let context = AppDelegate.shared.context
    var personViewModel = PersonViewModel(_dbOperations: DBOperations())

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Person Name"
        navigationItem.titleView = searchBar
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.searchBar.delegate = self
        
        fetchPeople()
    }

    func fetchPeople(){
        //Fetch the data from core data to display on the table view
        personViewModel.fetchData()
        self.tableView.reloadData()
    }


    @IBAction func addUsername(_ sender: UIBarButtonItem) {
        //Create Alert
        let alert = UIAlertController(title: "New Name",
                                      message: "Add a new name",
                                      preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = "Enter a name"
        }

        alert.addAction(UIAlertAction(title: "Save",
                                      style: .default,
                                      handler: { (UIAlertAction) in

            
            guard let nameTextField = alert.textFields?.first,
                  let personName: String = nameTextField.text,
                  !personName.isEmpty else { return }


                self.personViewModel.saveData(name: personName)
            self.personViewModel.request.sortDescriptors = [self.personViewModel.dbOperations.sort]
                print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
                self.fetchPeople()
                self.tableView.reloadData()

        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        present(alert, animated: true, completion: nil)
    }

    //MARK: Search Bar Config
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText.count == 0 {
            fetchPeople()
        } else {
//            do {
//            personViewModel.request.sortDescriptors = [personViewModel.sort]
            
                let pred = NSPredicate(format: "name beginswith[cd] %@", searchText.lowercased())
                personViewModel.request.predicate = pred

                personViewModel.people = try! context.fetch(personViewModel.request)
                self.tableView.reloadData()
//            } catch {

//            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        personViewModel.people.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nameCell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        nameCell.textLabel?.text = personViewModel.people[indexPath.row].name
        return nameCell
    }
}


