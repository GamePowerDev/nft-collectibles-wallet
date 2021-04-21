import { combineReducers } from 'redux'
import { keyringReducer } from './keyring.reducer'
import { apiReducer } from './api.reducer'
import { authReducer } from './auth.reducer'
import { collectibleReducer } from './collectible.reducer'

export default combineReducers({
    apiReducer,
    authReducer,
    collectibleReducer,
    keyringReducer,
})