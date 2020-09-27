import { Pool } from 'pg'
import credentials from './credentials'

{ user, host, database, password, port } = credentials

class Database
	execute: (query) ->
		return new Promise((resolve, reject) ->
			pool = new Pool({
				user: user,
				host: host,
				database: database,
				password: password,
				port: port
			})

			pool.query(query, (err, res) ->
				if err
					reject(err)
				else
					resolve(res.rows)
				pool.end()
			)
		)
		

	insert: (table, columns) ->
		Database = @

		return new Promise((resolve, reject) ->
			columnsName = Object.keys(columns)
			columnsValue = Object.values(columns)
			columnsLength = columnsName.length
			
			query = {
				text: "INSERT INTO #{table} ("
				values: columnsValue
			}

			for columnName, index in columnsName
				if index + 1 != columnsLength
					query.text += "#{columnName}, "
				else
					query.text += "#{columnName}) "
		
			query.text += 'VALUES('

			for index in [1..columnsLength]
				if index != columnsLength
					query.text += "$#{index}, "
				else
					query.text += "$#{index});"

			Database.execute(query)
				.then(resolve)
				.catch(reject)
		)
			
	update: (table, columns, id) ->
		Database = @

		return new Promise((resolve, reject) ->
			columnsName = Object.keys(columns)
			columnsValue = Object.values(columns)
			columnsLength = columnsName.length
			
			query = {
				text: "UPDATE #{table} SET "
				values: columnsValue
			}

			for columnName, index in columnsName
				if index + 1 != columnsLength
					query.text += "#{columnName} = $#{index + 1}, "
				else
					query.text += "#{columnName} = $#{index + 1} "

			query.text += "WHERE id = #{id};"

			Database.execute(query)
				.then(resolve)
				.catch(reject)
		)

	delete: (table, id) ->
		Database = @

		return new Promise((resolve, reject) ->
			query = "DELETE FROM #{table} WHERE id = #{id};"

			Database.execute(query)
				.then(resolve)
				.catch(reject)
		)

	select: (table, id) ->
		Database = @

		return new Promise((resolve, reject) ->
			query = "SELECT * FROM #{table} "

			if id
				query += "WHERE id = #{id} "
			
			query += "ORDER BY id;"

			Database.execute(query)
				.then(resolve)
				.catch(reject)
		)

export default Database