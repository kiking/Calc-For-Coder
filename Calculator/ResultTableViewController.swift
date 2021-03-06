//
//  ResultTableViewController.swift
//  Calculator
//
//  Created by 李博文 on 22/12/2017.
//  Copyright © 2017 Nanjing University. All rights reserved.
//

import UIKit
import MessageUI

class ResultTableViewController: UITableViewController
{
    //MARK: Properties
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var meanLabel: UILabel!
    @IBOutlet weak var varianceLabel: UILabel!
    @IBOutlet weak var sumOfSquaresLabel: UILabel!
    @IBOutlet weak var meanOfSquareLabel: UILabel!
    @IBOutlet weak var sampleVarianceLabel: UILabel!
    @IBOutlet weak var sampleDeviationLabel: UILabel!
    
    //MARK: Actions
    @IBAction func sendEmail(_ sender: UIBarButtonItem)
    {
        if !MFMailComposeViewController.canSendMail() {
            print("Enable to send mail")
            return
        }
        let resultString =
        """
        对于以下变量
        \(variables!)
        Calc for Coder 为您计算出以下统计量：
        
        n = \(numberLabel.text!)
        ΣX = \(sumLabel.text!)
        E[X] = \(meanLabel.text!)
        D(X) = \(varianceLabel.text!)
        ΣX² = \(sumOfSquaresLabel.text!)
        E[X²] = \(meanOfSquareLabel.text!)
        S = \(sampleDeviationLabel.text!)
        S² = \(sampleVarianceLabel.text!)
        """
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        composeVC.setSubject("Statistics from Calc For Coder")
        composeVC.setMessageBody(resultString, isHTML: false)
        present(composeVC, animated: true, completion: nil)
    }
    
    //MARK: Model
    var variables: [Double]! //由前一个ViewController传过来
    //MARK: ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberLabel.text = String(StatisticsBrain.numberOfVariables(variables: variables))
        sumLabel.text = String(StatisticsBrain.sumOfVariables(variables: variables))
        meanLabel.text = String(StatisticsBrain.meanOfVariables(variables: variables))
        varianceLabel.text = String(StatisticsBrain.varianceOfVariables(variables: variables))
        sumOfSquaresLabel.text = String(StatisticsBrain.sumOfSquares(variables: variables))
        meanOfSquareLabel.text = String(StatisticsBrain.meanOfSquare(variables: variables))
        sampleDeviationLabel.text = String(StatisticsBrain.sampleDeviation(variables: variables))
        sampleVarianceLabel.text = String(StatisticsBrain.sampleVariance(variables: variables))
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 8
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ResultTableViewController: MFMailComposeViewControllerDelegate
{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
    {
        controller.dismiss(animated: true, completion: nil)
    }
}
