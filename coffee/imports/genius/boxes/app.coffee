origin =
  initial_data: null
  loaded: no
  user:
    logged: no
    data: null
    full_pin: null
    email: ''
  locked_at: null
  lock_lock: no
  media_viewer:
    objects: []
    first: 0
    focus: no
  scanning:
    active: no
    progress: 0
  modal_screen:
    visible: no
    type: ''
  select_mode:
    available: no
    active: no
  data:
    media: []
  image_selector:
    active: no
    objects: []
  import_notification:
    visible: no
    objects: []



export default (state = origin, act) ->
  switch act.type

    when 'setInitialData'
      state = { state... }

      state = {
        state...
        initial_data: act.data
      }

      state



    when 'setRestoreUserMode'
      state = { state... }

      state = {
        state...
        restore_user_mode: act.data
      }

      state



    when 'setUser'
      state = { state... }

      if act.data.data
        if act.data.data.breakins
          sorted_breakins = _.sortBy act.data.data.breakins, (object) =>
            - (new Date(object.date).getTime())

      state = {
        state...
        user: {
          act.data...
          data: {
            act.data.data...
            breakins: sorted_breakins or []
          }
        }
      }

      # console.log 'setUser'
      # console.log state

      state



    when 'setAppLoaded'
      state = { state... }

      state = {
        state...
        loaded: yes
      }

      state



    when 'setFullPin'
      state = { state... }

      state = {
        state...
        user: {
          state.user...
          full_pin: act.data
        }
      }

      state



    when 'setEmailAddress'
      state = { state... }

      state = {
        state...
        user: {
          state.user...
          email: act.data
        }
      }

      state



    when 'setAppLockTimer'
      state = { state... }

      state = {
        state...
        locked_at: act.data
      }

      state



    when 'setLockLock'
      state = { state... }

      state = {
        state...
        lock_lock: act.data
      }

      state



    when 'setModalScreen'
      state = { state... }

      state = {
        state...
        modal_screen:
          visible: act.data.visible
          type: act.data.type
      }

      state



    when 'setScanning'
      state = { state... }

      state = {
        state...
        scanning: act.data
      }

      state



    when 'setSelectMode'
      state = { state... }

      state = {
        state...
        select_mode: act.data
      }

      state



    when 'fillMediaViewer'
      state = { state... }

      state = {
        state...
        media_viewer:
          objects: act.data.objects
          first: act.data.first
          focus: no
      }

      state



    when 'setMediaViewerFocus'
      state = { state... }

      state = {
        state...
        media_viewer: {
          state.media_viewer...
          focus: act.data
        }
      }

      state



    when 'clearMediaViewer'
      state = { state... }

      state = {
        state...
        media_viewer:
          objects: []
          first: 0
          focus: no
      }

      state



    when 'setMediaData'
      state = { state... }

      sorted = _.sortBy act.data, (object) =>
        - (new Date(object.date).getTime())

      state = {
        state...
        data: {
          state.data...
          media: sorted
        }
      }

      state



    when 'setImageSelector'
      state = { state... }

      state = {
        state...
        image_selector: act.data
      }

      state



    when 'setImportNotification'
      state = { state... }

      state = {
        state...
        import_notification: act.data
      }

      state



    else state
