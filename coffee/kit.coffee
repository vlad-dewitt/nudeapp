import './lib/initial_script'
import './lib/global_scope'

import { Provider } from 'react-redux'
import { createStore, applyMiddleware } from 'redux'

import Redux from './imports/genius/redux'

import App from './imports/kit'



@STORE = createStore Redux()



export default =>
  <Provider store={ STORE }>
    <App/>
  </Provider>
