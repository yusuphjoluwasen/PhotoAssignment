//
//  AppCoordinator.swift
//  PhotosAssignment
//
//  Created by Guru on 02/06/2022.
//

import UIKit

protocol PhotosCoordinatorDelegate: AnyObject {
    func showPhotos(of id: Int)
}

protocol PhotosCoordinatorDetailDelegate: AnyObject {
    func showPhotoDetail(item:PhotoDto)
}

class AppCoordinator: CoordinatorProtocol {

    var rootNavigationController: UINavigationController!
    let network:NetworkingDelegate!
    let window: UIWindow?
    let factory:RepositoryFactoryDelegate

    init(window: UIWindow?) {
        self.window = window
        self.network = Networking()
        self.factory = RepositoryFactory(network: network)
    }
    
    func start() {
        guard let window = window else { return }
        rootNavigationController = UINavigationController(rootViewController: getAlbumViewController())
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
    }
    
    private func getAlbumViewController() -> AlbumViewController {
        let db:AlbumDBDelegate = AlbumDBHandler()
        let transform:AlbumTransformationDelegate = AlbumTransformationHandler()
        let api:AlbumApiDelegate = AlbumAPiHandler(factory: factory)
        let repository = AlbumRepository(api: api, transform: transform, db: db)
        let viewModel = AlbumViewModel(repository: repository)
        let controller = StoryboardInitializable.initFromStoryboard(storyboardIdentifier: Constants.StoryboardIdentifiers.album) as? AlbumViewController
        controller?.viewModel = viewModel
        viewModel.coordinatorDelegate = self
        return controller!
    }
}

extension AppCoordinator:PhotosCoordinatorDelegate{
    func showPhotos(of id: Int) {
        let repository = PhotoRepository(factory: factory)
        let viewModel = PhotoViewModel(repository: repository, albumId: id)
        let controller = PhotoViewController()
        controller.viewModel = viewModel
        viewModel.coordinatorDelegate = self
        rootNavigationController.pushViewController(controller, animated: true)
    }
}

extension AppCoordinator:PhotosCoordinatorDetailDelegate{
    func showPhotoDetail(item:PhotoDto) {
        let viewModel = PhotoDetailsViewModel(title: item.title, image: item.imageUrl)
        let controller = StoryboardInitializable.initFromStoryboard(storyboardIdentifier: Constants.StoryboardIdentifiers.photodetail) as? PhotoDetailsViewController
        controller?.viewModel = viewModel
        rootNavigationController.pushViewController(controller!, animated: true)
    }
}
