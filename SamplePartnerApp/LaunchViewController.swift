//      this is sample partner application file


import UIKit
import SafariServices

final internal class LaunchViewController: UITableViewController, SdkCallbacks {
    
    var chatSdk: ChatSdk?
    var brandCustomerId: String
    var isPrechatRequired: Bool
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    init(brandCustomerId: String, isPrechatRequired: Bool) {
        self.brandCustomerId = brandCustomerId
        self.isPrechatRequired = isPrechatRequired
        super.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.brandCustomerId = ""
        self.isPrechatRequired = true
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
        
        self.chatSdk!.doSdkLogin(brandUserIdentifier: brandCustomerId)
        
        chatSdk?.registerSdkCallBacks(sdkCallbacks: self)
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
    
    func openURL(_ url: URL) {
        let webViewController = SFSafariViewController(url: url)
        if #available(iOS 10.0, *) {
            webViewController.preferredControlTintColor = .white
        }
        present(webViewController, animated: true, completion: nil)
    }
    
    // MARK: - Helper functions
    
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
        
        chatSdk!.startChatFlow(isPreChatRequired: self.isPrechatRequired, brandArticleId: brandArticleId)
        
    }
    
    
    func onSdkExit() {
        
    }
    
    func onTicketRaised(sessionHash: String, ticketId: CLong, customerHash: String) {
        print(sessionHash)
        print(ticketId)
        print(customerHash)
    }
}
