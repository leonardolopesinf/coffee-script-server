import Users from '../models/Users'

users = new Users()

class UserController
    @routes: () -> {
        default: '/',
        getById: '/:id'
    }

    get: (req, res) ->
        if req.params
            id = req.params.id
        else
            id = null

        users.get(id)
            .then((users) -> res.status(200).send(users))
            .catch((err) -> res.status(404).send(err))

    post: (req, res) ->
        { name, age } = req.body

        users.create(name, age)
            .then(() -> res.status(201).send('User created successfully'))
            .catch((error) -> res.status(500).send(error))

    put: (req, res) ->
        { columns, id } = req.body
        
        users.update(columns, id)
            .then(() -> res.status(200).send())
            .catch((error) -> res.status(500).send(error))

    delete: (req, res) ->
        { id } = req.body

        users.delete(id)
            .then(() -> res.status(200).send('User deleted successfully'))
            .catch((error) -> res.status(500).send(error))

export default UserController
