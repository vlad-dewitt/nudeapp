import { connect } from 'react-redux'

import Hunter from './hunter'
Hunter()

import API from './api/kit'



States = (state, props) ->
  { state... }



Hybrid = (component) ->
  connect(States, null)(component)



Ambry =
  state: =>
    STORE.getState()
  call: (id, data) =>
    if data is undefined
      STORE.dispatch
        type: id
    else
      STORE.dispatch
        type: id
        data: data



export { Hybrid, API, Ambry }
