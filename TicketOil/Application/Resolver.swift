//
//  Resolver.swift
//  TicketOil
//
//  Created by Nursat on 17.04.2022.
//

import Swinject

public final class DIResolver {
    private static let assembler = Assembler([
        ApplicationAssembly(),
        ManagersAssembly(),
        ProvidersAssembly(),
        StoragesAssembly(),
        RepositoriesAssembly(),
        CoordinatorAssembly(),
        ConfiguratorAssembly()
    ])
    
    class func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        assembler.resolver.resolve(serviceType)
    }
    
    class func resolve<Service, Arg1>(_ serviceType: Service.Type, argument: Arg1) -> Service? {
        assembler.resolver.resolve(serviceType, argument: argument)
    }
    
    class func resolve<Service, Arg1, Arg2>(_ serviceType: Service.Type, argument1 arg1: Arg1, argument2 arg2: Arg2) -> Service? {
        assembler.resolver.resolve(serviceType, arguments: arg1, arg2)
    }
}

private final class ApplicationAssembly: Assembly {
    func assemble(container: Container) {
    }
}

private final class ManagersAssembly: Assembly {
    func assemble(container: Container) {
    }
}

private final class ProvidersAssembly: Assembly {
    func assemble(container: Container) {
    }
}

private final class StoragesAssembly: Assembly {
    func assemble(container: Container) {
    }
}

private final class RepositoriesAssembly: Assembly {
    func assemble(container: Container) {
    }
}

private final class CoordinatorAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AppCoordinator.self) { r in
            AppCoordinator()
        }
    }
}

private final class ConfiguratorAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NavigationBarConfigurator.self) { r in
            NavigationBarConfiguratorImpl()
        }
    }
}
