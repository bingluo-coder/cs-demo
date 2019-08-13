namespace: smaxflows
flow:
  name: getinc1
  inputs:
    - sawURL: 'https://smax2018.05.itsma-demo.net'
    - username: jennifer.falconmf
    - password:
        default: Password_123
        sensitive: false
    - tenantid: '712737951'
  workflow:
    - http_client_action:
        do:
          io.cloudslang.base.http.http_client_action:
            - url: "${sawURL+'/auth/authentication-endpoint/authenticate/login?TENANTID='+tenantid}"
            - auth_type: null
            - trust_all_roots: 'true'
            - use_cookies: 'true'
            - keep_alive: 'true'
            - body: "${'{\\\"login\\\":\\\"'+username+'\\\",\\\"password\\\":\\\"'+password+'\\\"}'}"
            - method: POST
        publish:
          - cookie: '${return_result}'
        navigate:
          - SUCCESS: http_client_action_1
          - FAILURE: FAILURE
    - http_client_action_1:
        do:
          io.cloudslang.base.http.http_client_action:
            - url: 'https://smax2018.05.itsma-demo.net/rest/71273795/ems/Incident/22678?layout=Id'
            - auth_type: anonymous
            - trust_all_roots: 'true'
            - use_cookies: 'true'
            - keep_alive: 'true'
            - connections_max_per_root: '100'
            - connections_max_total: '100'
            - headers: >-
                ${'Cookie:LWSSO_COOKIE_KEY='+cookie+';'
                'X-XSRF-TOKEN:051ed680-a4ed-4f54-b2a2-8929dba95924'}
            - response_character_set: UTF-8
            - follow_redirects: 'true'
            - content_type: application/json;charset=UTF-8
            - request_character_set: UTF-8
            - method: GET
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: FAILURE
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      http_client_action:
        x: 297
        y: 137
        navigate:
          33da9cc8-7d5d-008c-2ef1-373f98a4b622:
            targetId: 159828a5-95d3-f959-b0a6-dfc0d5b2dfad
            port: FAILURE
      http_client_action_1:
        x: 560
        y: 138
        navigate:
          82214096-dfaf-5872-1d64-f3b7305910a8:
            targetId: 777d0f5d-0247-5205-ec5c-e60788ea68c8
            port: SUCCESS
          d1f02e1c-6d00-ef14-fa72-ac98cc837320:
            targetId: 159828a5-95d3-f959-b0a6-dfc0d5b2dfad
            port: FAILURE
    results:
      FAILURE:
        159828a5-95d3-f959-b0a6-dfc0d5b2dfad:
          x: 272.0138854980469
          y: 333.03125
      SUCCESS:
        777d0f5d-0247-5205-ec5c-e60788ea68c8:
          x: 764
          y: 140
