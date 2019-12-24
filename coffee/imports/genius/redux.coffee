import { combineReducers } from 'redux'

import app from './boxes/app'



export default =>
  combineReducers {
    app: app
  }
