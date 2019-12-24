export default

  setInitialData: =>
    data =
      device_name: Constants.deviceName
      platform: Constants.platform
      device_id: Constants.deviceId

    # console.log '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
    # console.log '(((setInitialData:'
    # console.log data
    # console.log 'setInitialData)))'
    # console.log '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'

    LocalAuth.hasHardwareAsync().then (res) =>
      if res is yes
        LocalAuth.supportedAuthenticationTypesAsync().then (res) =>
          data.identity_hardware = LocalAuth.AuthenticationType[res]
          Ambry.call 'setInitialData', data
      else
        data.identity_hardware = no
        Ambry.call 'setInitialData', data

    FileSystem.makeDirectoryAsync FileSystem.documentDirectory + 'media', { intermediates: yes }
    FileSystem.makeDirectoryAsync FileSystem.documentDirectory + 'media/images', { intermediates: yes }
    FileSystem.makeDirectoryAsync FileSystem.documentDirectory + 'media/images/original', { intermediates: yes }
    # FileSystem.makeDirectoryAsync FileSystem.documentDirectory + 'media/images/med', { intermediates: yes }
    # FileSystem.makeDirectoryAsync FileSystem.documentDirectory + 'media/images/sm', { intermediates: yes }
    # FileSystem.makeDirectoryAsync FileSystem.documentDirectory + 'media/images/xsm', { intermediates: yes }
    FileSystem.makeDirectoryAsync FileSystem.documentDirectory + 'media/videos', { intermediates: yes }
    FileSystem.makeDirectoryAsync FileSystem.documentDirectory + 'breakins', { intermediates: yes }



  checkConnection: (callback) =>
    NetInfo.fetch().then (state) =>
      callback state.isConnected



  identify: (callback) =>
    LocalAuth.authenticateAsync().then (res) =>
      if res.success
        callback yes
      else
        LocalAuth.authenticateAsync().then (res) =>
          if res.success
            callback yes
          else
            LocalAuth.authenticateAsync().then (res) =>
              if res.success
                callback yes
              else
                LocalAuth.authenticateAsync().then (res) =>
                  if res.success
                    callback yes
                  else
                    LocalAuth.authenticateAsync().then (res) =>
                      if res.success
                        callback yes
                      else
                        callback no



  storeUser: =>
    local_data =
      account_created_at: new Date()
      on_trial: no
      device_id: Ambry.state().app.initial_data.device_id
      breakins: []
      allowed_until: new Date(+new Date() + 30 * 86400 * 1000)
      trial_time_left: 30
      forbidden_entry_until: new Date()
      settings:
        touch_id_enabled: no
        auto_nude_detection: yes
      user_first_time: yes

    if Ambry.state().app.restore_user_mode
      user_data = {
        local_data...
        pin: Ambry.state().app.user.full_pin
        user_referral_code: ''
        referral_code_used: ''
        emails: [
          address: Ambry.state().app.user.email
          verified_at: null
        ]
      }

      # console.log '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
      # console.log '(((storeUser (Ambry.state().app.restore_user_mode):'
      # console.log user_data
      # console.log 'storeUser)))'
      # console.log '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'

      await AsyncStorage.setItem 'user_data', JSON.stringify user_data
      # await AsyncStorage.setItem 'first_launch', JSON.stringify { first_launch: no }
      Ambry.call 'setUserFirstTime', yes
    else
      server_data =
        email: Ambry.state().app.user.email or ''
        referrer: ''
        deviceInfo: Ambry.state().app.initial_data.device_id

      API.server.createUser server_data, (res) =>
        user_data = {
          local_data...
          pin: Ambry.state().app.user.full_pin
          user_referral_code: res.user.referralCode
          referral_code_used: res.user.referralCode
          emails: [
            address: Ambry.state().app.user.email
            verified_at: null
          ]
        }

        # console.log '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
        # console.log '(((storeUser (API.server.createUser):'
        # console.log user_data
        # console.log 'storeUser)))'
        # console.log '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'

        await AsyncStorage.setItem 'user_data', JSON.stringify user_data
        Ambry.call 'setUserFirstTime', yes



  syncUserLocally: (callback) =>
    AsyncStorage.getItem('user_data').then (res) =>
      # resp = await AsyncStorage.getItem 'first_launch'
      # if resp is null
      #   await AsyncStorage.removeItem 'user_data'
      #   await AsyncStorage.removeItem 'media'
      #   await AsyncStorage.removeItem 'known_media'
      # else
      #   resp = JSON.parse resp
      #   if resp.first_launch
      #     await AsyncStorage.removeItem 'user_data'
      #     await AsyncStorage.removeItem 'media'
      #     await AsyncStorage.removeItem 'known_media'

      # console.log '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
      # console.log "(((syncUserLocally (AsyncStorage.getItem('user_data')):"
      # console.log res
      # console.log 'syncUserLocally)))'
      # console.log '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'

      if res is null
        user = {
          Ambry.state().app.user...
          logged: no
          data: null
          full_pin: null
          email: ''
        }
      else
        user = {
          Ambry.state().app.user...
          logged: yes
          data: JSON.parse res
        }

        # console.log '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
        # console.log "(((syncUserLocally (res):"
        # console.log user
        # console.log 'syncUserLocally)))'
        # console.log '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'

        API.global.syncUserOnline user, (res) =>
          if res is 'OFFLINE'
            Ambry.call 'setUser', user
            if typeof callback is 'function'
              callback if res is null then no else yes
          else
            Ambry.call 'setUser', user
            if typeof callback is 'function'
              callback if res is null then no else yes



  syncUserOnline: (local_user, callback) =>
    # console.log '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
    # console.log "(((syncUserOnline (local_user):"
    # console.log local_user
    # console.log 'syncUserOnline)))'
    # console.log '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
    API.global.checkConnection (connected) =>
      if connected
        API.server.checkUser local_user.data.emails[0].address, (res) =>
          callback 'ONLINE'
      else
        callback 'OFFLINE'



  userSawDemo: =>
    AsyncStorage.getItem('user_data').then (res) =>
      user = {
        Ambry.state().app.user...
        data: JSON.parse res
      }
      user_data = user.data
      user_data.user_first_time = no
      # await AsyncStorage.setItem 'first_launch', JSON.stringify { first_launch: no }
      await AsyncStorage.setItem 'user_data', JSON.stringify user_data
      API.global.syncUserLocally()



  startAppLockTimer: =>
    locked_at = new Date()
    Ambry.call 'setAppLockTimer', locked_at



  clearAppLockTimer: =>
    Ambry.call 'setAppLockTimer', null



  setAutoNudeDetection: (value) =>
    AsyncStorage.getItem('user_data').then (res) =>
      updated_user_data = JSON.parse res
      updated_user_data.settings.auto_nude_detection = value
      await AsyncStorage.setItem 'user_data', JSON.stringify updated_user_data

      if value is yes
        API.global.syncUserLocally =>
          API.global.startDetection()
      else
        API.global.syncUserLocally()



  setTouchIdEnabled: (value) =>
    AsyncStorage.getItem('user_data').then (res) =>
      updated_user_data = JSON.parse res
      updated_user_data.settings.touch_id_enabled = value
      await AsyncStorage.setItem 'user_data', JSON.stringify updated_user_data
      API.global.syncUserLocally()



  addEmail: (email_address, callback) =>
    API.server.resetEmail email_address, (res) =>
      AsyncStorage.getItem('user_data').then (res) =>
        updated_user_data = JSON.parse res
        updated_user_data.emails = [
          { address: email_address, verified_at: null }
        ]
        await AsyncStorage.setItem 'user_data', JSON.stringify updated_user_data
        API.global.syncUserLocally callback



  changePIN: (full_pin) =>
    AsyncStorage.getItem('user_data').then (res) =>
      updated_user_data = JSON.parse res
      updated_user_data.pin = full_pin
      await AsyncStorage.setItem 'user_data', JSON.stringify updated_user_data
      API.global.syncUserLocally()



  deleteUser: (callback) =>
    Ambry.call 'setModalScreen', visible: yes, type: 'modal_loading'
    API.global.removeBreakIns Ambry.state().app.user.data.breakins, =>
      API.global.exportMedia Ambry.state().app.data.media, =>
        API.server.deleteUser (res) =>
          await AsyncStorage.removeItem 'user_data'
          await AsyncStorage.removeItem 'media'
          await AsyncStorage.removeItem 'known_media'
          await AsyncStorage.removeItem 'last_scanning'

          Ambry.call 'setUser',
            logged: no
            data: null
            full_pin: null
            email: ''

          Ambry.call 'setModalScreen', visible: no, type: ''

          callback()



  addBreakIn: (object) =>
    breakin_object = {
      object...
      id: random 'A0', 16
      date: new Date()
    }

    next_path = FileSystem.documentDirectory + "breakins/#{ breakin_object.id }.jpg"

    FileSystem.moveAsync
      from: breakin_object.uri
      to: next_path

    breakin_object.uri = next_path

    AsyncStorage.getItem('user_data').then (res) =>
      user_data = JSON.parse res
      updated_user_data = user_data
      updated_user_data.breakins.push breakin_object

      await AsyncStorage.setItem 'user_data', JSON.stringify updated_user_data
      API.global.syncUserLocally()



  removeBreakIns: (objects, callback) =>
    AsyncStorage.getItem('user_data').then (res) =>
      user_data = JSON.parse res
      updated_breakins = user_data.breakins

      objects.map (object, num) =>
        object_to_remove = _.findWhere updated_breakins, { id: object.id }
        updated_breakins = _.without updated_breakins, object_to_remove
        FileSystem.deleteAsync object.uri, { idempotent: yes }

      user_data.breakins = updated_breakins

      await AsyncStorage.setItem 'user_data', JSON.stringify user_data

      if callback
        API.global.syncUserLocally callback
      else
        API.global.syncUserLocally()



  syncMediaLocally: =>
    AsyncStorage.getItem('media').then (res) =>
      if res is null
        media = []
      else
        media = JSON.parse res

      # console.log '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
      # console.log "(((syncMediaLocally:"
      # console.log res
      # console.log 'syncMediaLocally)))'
      # console.log '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'

      Ambry.call 'setMediaData', media



  addMedia: (options, objects, callback) =>
    new_media_objects = []

    await Promise.all objects.map await (object, num) =>
      if object.type is 'image' or object.type is 'video'
        static_media_object =
          id: random 'A0', 16
          date: new Date()
          type: object.type
          path: object.uri
          width: object.width
          height: object.height
          filetype: if object.filename then object.filename.split('.')[object.filename.split('.').length - 1] else 'jpg'
        # console.log 'addMedia:'
        # console.log static_media_object

        if object.type is 'image'
          next_paths =
            original: FileSystem.documentDirectory + "media/images/original/#{ static_media_object.id }.jpg"
            # original: FileSystem.documentDirectory + "media/images/original/#{ static_media_object.id }.#{ static_media_object.filetype }"
            # med: FileSystem.documentDirectory + "media/images/med/#{ static_media_object.id }.jpg"
            # sm: FileSystem.documentDirectory + "media/images/sm/#{ static_media_object.id }.jpg"
            # xsm: FileSystem.documentDirectory + "media/images/xsm/#{ static_media_object.id }.jpg"
          specific_media_object = {}
        else if object.type is 'video'
          next_path = FileSystem.documentDirectory + "media/videos/#{ static_media_object.id }.#{ static_media_object.filetype }"
          specific_media_object =
            duration: object.duration

        if object.type is 'image'
          { status: FS_permission_status } = await Permissions.askAsync Permissions.CAMERA_ROLL
          # { uri: path_med } = await ImageManipulator.manipulateAsync static_media_object.path, [{ resize: { width: 300 } }]
          # { uri: path_sm } = await ImageManipulator.manipulateAsync static_media_object.path, [{ resize: { width: 150 } }]
          # { uri: path_xsm } = await ImageManipulator.manipulateAsync static_media_object.path, [{ resize: { width: 50 } }]

          if options.import
            FileSystem.copyAsync { from: static_media_object.path, to: next_paths.original }
          else
            FileSystem.moveAsync { from: static_media_object.path, to: next_paths.original }
          # FileSystem.moveAsync { from: path_med, to: next_paths.med }
          # FileSystem.moveAsync { from: path_sm, to: next_paths.sm }
          # FileSystem.moveAsync { from: path_xsm, to: next_paths.xsm }

          if options.import
            specific_media_object.library_id = object.id
          specific_media_object.path = next_paths.original
          # specific_media_object.path_med = next_paths.med
          # specific_media_object.path_sm = next_paths.sm
          # specific_media_object.path_xsm = next_paths.xsm
        else if object.type is 'video'
          FileSystem.copyAsync { from: static_media_object.path, to: next_path }
          if options.import
            specific_media_object.library_id = object.id
          specific_media_object.path = next_path

        full_media_object = {
          static_media_object...
          specific_media_object...
        }

        new_media_objects.push full_media_object

    if new_media_objects.length > 0
      AsyncStorage.getItem('media').then (res) =>
        if res is null
          media = [
            new_media_objects...
          ]
        else
          media = [
            JSON.parse(res)...
            new_media_objects...
          ]

        await AsyncStorage.setItem 'media', JSON.stringify media
        API.global.syncMediaLocally()

        if options.import is yes
          Ambry.call 'setImportNotification',
            visible: yes
            objects: new_media_objects

        if callback then callback()



  removeMedia: (objects, callback) =>
    AsyncStorage.getItem('media').then (res) =>
      local_objects = JSON.parse res
      updated_objects = local_objects

      objects.map (object, num) =>
        object_to_remove = _.findWhere local_objects, { id: object.id }
        updated_objects = _.without updated_objects, object_to_remove
        FileSystem.deleteAsync object.path, { idempotent: yes }
        # if object.type is 'image'
        #   FileSystem.deleteAsync object.path_med, { idempotent: yes }
        #   FileSystem.deleteAsync object.path_sm, { idempotent: yes }
        #   FileSystem.deleteAsync object.path_xsm, { idempotent: yes }

      await AsyncStorage.setItem 'media', JSON.stringify updated_objects

      API.global.syncMediaLocally()

      if callback then callback()



  removeMediaFromLibrary: (objects, callback) =>
    # { status: FS_permission_status } = await Permissions.askAsync Permissions.CAMERA_ROLL
    # if FS_permission_status is 'granted'
    objects.map (object) =>
      # console.log 'removeMediaFromLibrary:'
      # console.log object
      MediaLibrary.deleteAssetsAsync object.library_id
    if callback then callback()
    # else
    #   if callback then callback()



  exportMedia: (objects, callback) =>
    { status: FS_permission_status } = await Permissions.askAsync Permissions.CAMERA_ROLL
    if FS_permission_status is 'granted'

      unknown_media_ids = []

      for i in [0...objects.length]
        object = objects[i]
        media_content_path = await CameraRoll.saveToCameraRoll object.path
        media_id = media_content_path.split('/')[media_content_path.split('/').length - 1]
        unknown_media_ids.push media_id

      known_media_res = await AsyncStorage.getItem 'known_media'
      known_media = if known_media_res is null then [] else JSON.parse known_media_res
      await AsyncStorage.setItem 'known_media', JSON.stringify [known_media..., unknown_media_ids...]

      # console.log '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
      # console.log "(((exportMedia(unknown_media_ids):"
      # console.log unknown_media_ids
      # console.log 'exportMedia)))'
      # console.log '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'

      API.global.removeMedia objects, callback



  lastScanning: (operation, options) =>
    last_scanning_res = await AsyncStorage.getItem 'last_scanning'
    last_scanning = if last_scanning_res is null then null else JSON.parse last_scanning_res

    switch operation

      when 'create'
        AsyncStorage.setItem 'last_scanning', JSON.stringify {
          unknown_media: options.unknown_media
          last_scanned: -1
          nude_photos_detected: []
        }

      when 'get'
        last_scanning

      when 'update'
        AsyncStorage.setItem 'last_scanning', JSON.stringify {
          last_scanning...
          last_scanned: options.last_scanned
          nude_photos_detected: if options.nude_photo_detected then [last_scanning.nude_photos_detected..., options.nude_photo_detected] else [last_scanning.nude_photos_detected...]
        }

      when 'complete'
        if last_scanning
          known_media_res = await AsyncStorage.getItem 'known_media'
          known_media = if known_media_res is null then [] else JSON.parse known_media_res
          unknown_media_ids = last_scanning.unknown_media.map (item) => item.id
          AsyncStorage.setItem 'known_media', JSON.stringify [known_media..., unknown_media_ids...]
          if last_scanning.nude_photos_detected.length > 0
            API.global.addMedia { import: yes }, last_scanning.nude_photos_detected.map (item) =>
              item.type = 'image'
              item
        else
          AsyncStorage.removeItem 'last_scanning'

      when 'finish'
        AsyncStorage.removeItem 'last_scanning'



  startDetection: =>
    objects_per_page = 30
    confidence_level = .0939

    start_index = 0
    nude_photos = []

    Ambry.call 'setScanning',
      active: yes
      progress: 0

    AsyncStorage.getItem('known_media').then (res) =>
      known_media = if res is null then [] else [JSON.parse(res)...]
      unknown_media = []

      iteration = 0
      steps_on_percent = 0
      after = '0'
      has_next_page = yes
      current_number = 0
      progress = 0

      getPhotos = =>
        MediaLibrary.getAssetsAsync
          after: after
          first: objects_per_page
          mediaType: ['photo']
          sortBy: ['creationTime']
        .then (res) =>
          iteration++
          after = res.endCursor
          processPhotos res

      processPhotos = (data) =>
        data.assets.map (asset, num) =>
          asset_exists = known_media.indexOf(asset.id) isnt -1
          if not asset_exists
            unknown_media.push asset

        if data.hasNextPage
          getPhotos()
        else
          API.global.userSawDemo()

          last_scanning = await API.global.lastScanning 'get'

          if last_scanning
            nude_photos = [last_scanning.nude_photos_detected...]
            start_index = last_scanning.last_scanned + 1
          else
            API.global.lastScanning 'create',
              unknown_media: unknown_media

          # console.log '(unknown_media.length): ' + unknown_media.length

          if unknown_media.length > 0
            progress = 1
            steps_on_percent = (100 - progress) / unknown_media.length
            if last_scanning
              progress = progress + (steps_on_percent * start_index)
            Ambry.call 'setScanning',
              active: yes
              progress: progress

            # console.log 'for i in ->:'
            # console.log [start_index...unknown_media.length]

            for i in [start_index...unknown_media.length]
              scanned_image = await API.global.scanPhoto unknown_media[i]
              # console.log '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
              # console.log "(((processPhotos (scanned_image):"
              # console.log scanned_image
              # console.log 'processPhotos)))'
              # console.log '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'

              progress = progress + steps_on_percent
              Ambry.call 'setScanning',
                active: if progress.toFixed(0) is 100 or progress > 100 then no else yes
                progress: progress

              if scanned_image.scan_result > confidence_level
                nude_photos.push scanned_image
                await API.global.lastScanning 'update',
                  last_scanned: i
                  nude_photo_detected: scanned_image
              else
                await API.global.lastScanning 'update',
                  last_scanned: i

            Ambry.call 'setScanning',
              active: no
              progress: 100

            API.global.lastScanning 'complete'
          else
            Ambry.call 'setScanning',
              active: no
              progress: 100

            API.global.lastScanning 'complete'


      getPhotos()



  scanPhoto: (image) =>
    scanned_image = image

    # filetype = scanned_image.filename.split('.')[scanned_image.filename.split('.').length - 1]

    new Promise (resolve) ->
      resolveResult = (result) =>
        scanned_image.scan_result = result
        resolve scanned_image

      try
        # console.log 'willScanPhoto:'
        # console.log scanned_image
        TFLite.runModelOnImage
          path: image.uri
          imageMean: 127.0
          imageStd: 1
          numResults: 1
        , (err, res) =>
          if err
            # console.log 'TFLite.runModelOnImage (err):'
            # console.log err
            resolveResult 0
          else
            # console.log 'TFLite.runModelOnImage (res):'
            # console.log res
            label = res[0].label

            if label is 'NSFW'
              confidence_level = res[0].confidence
            else
              confidence_level = 1 - res[0].confidence

            resolveResult confidence_level
      catch
        resolveResult 0
