import UserController from './controllers/UserController'

userController = new UserController
usersRoutes = UserController.routes()

export default (app) ->
    app.route(usersRoutes.default)
        .get(userController.get)
        .post(userController.post)
        .put(userController.put)
        .delete(userController.delete)

    app.route(usersRoutes.getById)
        .get(userController.get)
