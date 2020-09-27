import express from 'express'
import cors from 'cors'
import bodyParser from 'body-parser'

import routes from './routes'

app = express()

app.use(cors())

app.use(bodyParser.urlencoded({ extended: true }))

app.use(bodyParser.json())

routes(app)

export default app