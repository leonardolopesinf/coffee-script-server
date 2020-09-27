import Database from '../database/Database'

db = new Database()

class Users
    create: (name, age) ->
        user = {
            name: name,
            age: age
        }
        
        return db.insert('users', user)
    
    update: (columns, id) -> db.update('users', columns, id)

    delete: (id) -> db.delete('users', id)
    
    get: (id) -> db.select('users', id)

export default Users