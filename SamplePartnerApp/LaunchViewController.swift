/*
 MIT License
 
 Copyright (c) 2017-2019 MessageKit
 
 Multiple commands produce '/Users/gowthamgowdatc/Library/Developer/Xcode/DerivedData/SamplePartnerApp-ayypoovutzhiesedrtndsrxgtxzm/Build/Products/Debug-iphonesimulator/SamplePartnerApp.app/Assets.car':
 1) Target 'SamplePartnerApp' (project 'SamplePartnerApp') has compile command with input '/Users/gowthamgowdatc/Documents/ios-onedirect/SamplePartnerApp/SamplePartnerApp/Preview Content/Preview Assets.xcassets'
 2) That command depends on command in Target 'SamplePartnerApp' (project 'SamplePartnerApp'): script phase “[CP] Copy Pods Resources”
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */



//      this is sample partner application file


import UIKit
import SafariServices
import OnedirectChatSdk

final internal class LaunchViewController: UITableViewController {
    var chatSdk: ChatSdk?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cells = ["All Tickets", "Open Tickets", "Closed Tickets",
                 "od-article-identifier-1011", "od-article-identifier-1021", "od-article-identifier-1022",
                 "od-article-identifier-1031", "od-article-identifier-1032", "od-article-identifier-1033"]
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Onedirect - ChatSDK"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        
        // for staging
//        self.chatSdk = ChatSdk.build(brandHash: "NjE4MV8xNTUxOTM5MDU3MTg4X1ZJQkVS")
        
        // for production
        self.chatSdk = ChatSdk.build(brandHash: "ODAyOF8xNTk5MzA2MTQ2MTEzXzQ=")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        }
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        cell.textLabel?.text = cells[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = cells[indexPath.row]
        switch cell {
        case "All Tickets":
            allTicketsClicked()
        case "Open Tickets":
            openTicketsClicked()
        case "Closed Tickets":
            closedTicketsClicked()
        case "od-article-identifier-1011":
            createChat(brandArticleId: "od-article-identifier-1011")
        case "od-article-identifier-1021":
            createChat(brandArticleId: "od-article-identifier-1021")
        case "od-article-identifier-1022":
            createChat(brandArticleId: "od-article-identifier-1022")
        case "od-article-identifier-1031":
            createChat(brandArticleId: "od-article-identifier-1031")
        case "od-article-identifier-1032":
            createChat(brandArticleId: "od-article-identifier-1032")
        case "od-article-identifier-1033":
            createChat(brandArticleId: "od-article-identifier-1033")
            
        default:
            assertionFailure("You need to impliment the action for this cell: \(cell)")
            return
        }
    }

    // MARK: - helper functions
    
    func allTicketsClicked() {
        // TODO - create a new class with constructor taking parametes [All, Open, Closed]
        // In its viewDidLoad, start a spinner - call customerSessions API - stop spinner - populate tableview
        
        chatSdk!.openTicketListing(sessionStatusFor: "All")
    }
    
    func openTicketsClicked() {
        chatSdk!.openTicketListing(sessionStatusFor: "Open")
    }
    
    func closedTicketsClicked() {
        chatSdk!.openTicketListing(sessionStatusFor: "Resolved")
    }
    
    func createChat(brandArticleId: String) {
        // use chatSdk object to call startChatFlow
        
        chatSdk!.startChatFlow(isPreChatRequired: true, brandArticleId: brandArticleId)
    }
}
