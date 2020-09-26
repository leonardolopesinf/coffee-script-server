# @flow
import express from 'express'

app = express()

app.listen(3000, () -> console.log('Server started on port 3000'))