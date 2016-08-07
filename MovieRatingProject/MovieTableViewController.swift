//
//  MovieTableViewController.swift
//  MovieRatingProject
//
//  Copyright © 2016 Avel Aguilar. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var movies = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem()

        // Load the sample data
        loadSampleMovies()
    }
    
    func loadSampleMovies() {
        let photo1 = UIImage(named: "batmanVsSuperman")!
        let movie1 = Movie(name: "Batman Vs. Superman: Dawn of Justice", review: nil, photo: photo1, rating: 4)!
        
        let photo2 = UIImage(named: "captainAmerica")!
        let movie2 = Movie(name: "Captain America: Civil War", review: nil, photo: photo2, rating: 5)!
        
        movies += [movie1, movie2]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier
        let cellIdentifier = "MovieTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MovieTableViewCell
        
        // Fetches the appropriate movie for the data source layout
        let movie = movies[indexPath.row]
        
        cell.nameLabel.text = movie.name
        cell.photoImageView.image = movie.photo
        cell.ratingControl.rating = movie.rating

        return cell
    }
    
    @IBAction func unwindToMovieList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? MovieViewController, movie = sourceViewController.movie {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update existing meal
                movies[selectedIndexPath.row] = movie
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
            else {
                // Add a new movie
                let newIndexPath = NSIndexPath(forRow: movies.count, inSection: 0)
                movies.append(movie)
                // This animates the addition of a new row to the table view for the cell that contains information about the new meal.
                // The .Bottom animation option shows the inserted row slide in from the bottom.
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
        }
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            movies.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let movieDetailViewController = segue.destinationViewController as! MovieViewController
            
            // Get the cell that generated this segue
            if let selectedMovieCell = sender as? MovieTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedMovieCell)!
                let selectedMovie = movies[indexPath.row]
                movieDetailViewController.movie = selectedMovie
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new movie.")
        }
    }
}
