import UIKit

class AppCoordinator {
	private var presentingController: UITabBarController!
	private var coordinator: VideoFeedCoordinator!
	private let dateProvider: DateProvider

	init(dateProvider: DateProvider = DateProviderImpl()) {
		self.dateProvider = dateProvider
	}

	func start(window: UIWindow, theme: Theme) {
		let service = FetchVideoFeedService(session: .shared, dateProvider: dateProvider)
		let videos = VideoFeedController(viewModel: VideoFeedViewModel(service: service), theme: .dark)
		videos.tabBarItem = UITabBarItem(title: "Videos", image: R.image.video(), selectedImage: R.image.video())
		
		presentingController = UITabBarController()

		presentingController.setViewControllers(
			[videos],
			animated: false
		)

		let tabBarAppearance = UITabBar.appearance()
		tabBarAppearance.barTintColor = theme.backgroundColor
		tabBarAppearance.tintColor = theme.accentColor

		window.rootViewController = presentingController
		window.makeKeyAndVisible()
	}
}
