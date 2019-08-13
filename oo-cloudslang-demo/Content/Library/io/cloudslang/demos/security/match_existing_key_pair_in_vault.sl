namespace: io.cloudslang.demos.security
flow:
  name: match_existing_key_pair_in_vault
  inputs:
    - user: hcm_user
    - private_key: 'zlhtpx8ru{y'
  workflow:
    - url_encoder:
        do:
          io.cloudslang.base.http.url_encoder:
            - data: '${user}'
        publish:
          - user: '${result}'
        navigate:
          - SUCCESS: read_secret
          - FAILURE: on_failure
    - read_secret:
        do:
          io.cloudslang.demos.security.vault.read_secret:
            - secret: '${user}'
        publish:
          - secret_value: "${''.join( c for c in secret_value if  c not in '\\\"' )}"
        navigate:
          - FAILURE: on_failure
          - SUCCESS: string_equals
    - string_equals:
        do:
          io.cloudslang.base.strings.string_equals:
            - first_string: '${private_key}'
            - second_string: "${secret_value.split('time')[0]}"
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: FAILURE
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      url_encoder:
        x: 49
        y: 348
      read_secret:
        x: 45
        y: 96
      string_equals:
        x: 303
        y: 230
        navigate:
          f1949344-51c3-6474-daf1-971fc3df7903:
            targetId: 381bb638-a01c-ef95-47c2-0bff47d15786
            port: FAILURE
          e4fb4bde-4b63-e19f-78b4-134316f25f61:
            targetId: 8cc58fdc-3f6d-00d5-479d-b8c9a0bd4835
            port: SUCCESS
    results:
      FAILURE:
        381bb638-a01c-ef95-47c2-0bff47d15786:
          x: 455
          y: 405
      SUCCESS:
        8cc58fdc-3f6d-00d5-479d-b8c9a0bd4835:
          x: 462
          y: 107
