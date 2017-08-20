import UIKit
import Apollo

private let token = "d154256185aa9062e4fd4544434a8c4b3834e602"

let apollo : ApolloClient = {
    let configuration: URLSessionConfiguration = .default
    configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(token)"]
    configuration.requestCachePolicy = .reloadIgnoringLocalCacheData // To avoid 412
    
    let url = URL(string: "https://api.github.com/graphql")!
    
    return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
}()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

}
